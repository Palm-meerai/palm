const express = require('express');
const { Pool } = require('pg');
const path = require('path');
const bodyParser = require('body-parser');
const app = express();
// https://classroom.google.com/u/1/c/NjkwODk4NzU5ODQ5/m/NzIyODI3NjM3NDc4/details 
// ตั้งค่า EJS เป็น view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// เสิร์ฟไฟล์ static
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));

// ตั้งค่าการเชื่อมต่อ PostgreSQL
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'nakrian',
    password: 'rootroot',
    port: 5433,
    //https://github.com/trinodb/trino/issues/7403
    ssl: false // การตั้ง ssl: false จะทำให้การเชื่อมต่อไม่เข้ารหัส ข้อมูลทั้งหมดก็จะส่งไปยังฐานข้อมูลเเบบง่ายๆ
});

// ฟังก์ชันสำหรับดึงข้อมูลจาก student
//https://classroom.google.com/u/1/c/NjkwODk4NzU5ODQ5/m/NzIyODI3NjM3NDc4/details
app.get('/', async (req, res) => {
    try {
        const students = await pool.query(
            'SELECT s.id, s.first_name, s.last_name, p.prefix, c.short_name_th FROM student s JOIN prefix p ON s.prefix_id = p.id JOIN curriculum c ON s.curriculum_id = c.id'
        );
        res.render('index', { students: students.rows });
    } catch (err) {
        console.error(err);
        res.send('Error: ' + err.message);
    }
});
// ฟังก์ชันสำหรับบันทึกข้อมูลเช็คชื่อ
app.post('/save-attendance', async (req, res) => {
    let { student_ids } = req.body; // รับ student_id จาก checkbox ที่ถูกเช็ค
    const active_date = new Date().toISOString(); // เก็บเวลาปัจจุบัน

    try {
        // ดึงข้อมูลนักเรียนทั้งหมด
        const allStudents = await pool.query('SELECT id FROM student');

        // สร้างชุดข้อมูลของ student_ids ที่ถูกเช็ค
        let checkedInStudents = new Set(student_ids);

        // ถ้ามีการติ๊ก checkbox
        if (student_ids) {
            // ถ้ามีเพียง student_id เดียวจะต้องทำให้เป็น array
            if (!Array.isArray(student_ids)) {
                student_ids = [student_ids];
            }

            // บันทึกข้อมูลสำหรับนักเรียนที่เข้าชั้นเรียน
            for (let student_id of student_ids) {
                await pool.query(
                    `INSERT INTO student_list (section_id, student_id, active_date, status)
                     VALUES ($1, $2, $3, $4)`,
                     //$1 ค่าของ section_id $2 student_id $3 active_date $4 status 
                    [2, student_id, active_date, 'เข้าเรียน']
                );
            }
        }

        // บันทึกข้อมูลสำหรับนักเรียนที่ขาดเรียน
        for (let student of allStudents.rows) {
            if (!checkedInStudents.has(student.id.toString())) { // ถ้าไม่พบใน checked-in students
                await pool.query(
                    `INSERT INTO student_list (section_id, student_id, active_date, status)
                     VALUES ($1, $2, $3, $4)`,
                    [2, student.id, active_date, 'ขาดเรียน'] // ตั้งสถานะเป็น 'ขาดเรียน'
                );
            }
        }

        res.redirect('/checked-in'); // เปลี่ยนเส้นทางไปหน้า checked-in.ejs
    } catch (err) {
        console.error(err);
        res.send('Error: ' + err.message); // แสดงข้อผิดพลาด
    }
});


// หน้าที่แสดงตาราง student_list ที่ถูกบันทึก พร้อมข้อมูลนักเรียนจากตาราง student
// ฟังก์ชันสำหรับดึงข้อมูลจาก student
app.get('/checked-in', async (req, res) => {
    try {
        const attendanceList = await pool.query(`
            SELECT sl.section_id, sl.student_id, sl.active_date, sl.status, s.first_name, s.last_name, c.short_name_th
            FROM student_list sl
            JOIN student s ON sl.student_id = s.id
            JOIN curriculum c ON s.curriculum_id = c.id
        `);
        res.render('checked-in', { attendanceList: attendanceList.rows }); // ตรวจสอบว่าได้ส่ง attendanceList
    } catch (err) {
        console.error(err);
        res.send('Error');
    }
});




const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
