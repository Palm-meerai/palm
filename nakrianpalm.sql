PGDMP  .    &            	    |            nakrian    17.0    17.0                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    16524    nakrian    DATABASE     y   CREATE DATABASE nakrian WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Thai_Thailand.874';
    DROP DATABASE nakrian;
                     postgres    false            �            1259    16545 
   curriculum    TABLE     �   CREATE TABLE public.curriculum (
    id integer NOT NULL,
    curr_name_th character(80),
    curr_name_en character(80),
    short_name_th character(80),
    short_name_en character(80)
);
    DROP TABLE public.curriculum;
       public         heap r       postgres    false            �            1259    16540    prefix    TABLE     Z   CREATE TABLE public.prefix (
    id integer NOT NULL,
    prefix character varying(20)
);
    DROP TABLE public.prefix;
       public         heap r       postgres    false            �            1259    16565    section    TABLE     \   CREATE TABLE public.section (
    id integer NOT NULL,
    section character varying(30)
);
    DROP TABLE public.section;
       public         heap r       postgres    false            �            1259    16550    student    TABLE     �  CREATE TABLE public.student (
    id integer NOT NULL,
    prefix_id integer,
    first_name character varying(50),
    last_name character varying(50),
    date_of_birth character varying(50),
    sex character(20),
    curriculum_id integer,
    previous_school character varying(80),
    address character varying(100),
    telephone character varying(15),
    email character varying(40),
    line_id character varying(40),
    status character varying(10)
);
    DROP TABLE public.student;
       public         heap r       postgres    false            �            1259    24817    student_list    TABLE     �   CREATE TABLE public.student_list (
    id integer NOT NULL,
    section_id integer,
    student_id integer,
    active_date timestamp without time zone,
    status character varying(50)
);
     DROP TABLE public.student_list;
       public         heap r       postgres    false            �            1259    24816    student_list_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.student_list_id_seq;
       public               postgres    false    222                       0    0    student_list_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.student_list_id_seq OWNED BY public.student_list.id;
          public               postgres    false    221            g           2604    24820    student_list id    DEFAULT     r   ALTER TABLE ONLY public.student_list ALTER COLUMN id SET DEFAULT nextval('public.student_list_id_seq'::regclass);
 >   ALTER TABLE public.student_list ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222                      0    16545 
   curriculum 
   TABLE DATA           b   COPY public.curriculum (id, curr_name_th, curr_name_en, short_name_th, short_name_en) FROM stdin;
    public               postgres    false    218   �                 0    16540    prefix 
   TABLE DATA           ,   COPY public.prefix (id, prefix) FROM stdin;
    public               postgres    false    217   �                 0    16565    section 
   TABLE DATA           .   COPY public.section (id, section) FROM stdin;
    public               postgres    false    220                    0    16550    student 
   TABLE DATA           �   COPY public.student (id, prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id, status) FROM stdin;
    public               postgres    false    219   <       
          0    24817    student_list 
   TABLE DATA           W   COPY public.student_list (id, section_id, student_id, active_date, status) FROM stdin;
    public               postgres    false    222                       0    0    student_list_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_list_id_seq', 90, true);
          public               postgres    false    221            k           2606    16549    curriculum curriculum_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_pkey;
       public                 postgres    false    218            i           2606    16544    prefix prefix_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_pkey;
       public                 postgres    false    217            o           2606    16569    section section_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.section DROP CONSTRAINT section_pkey;
       public                 postgres    false    220            m           2606    16554    student student_list_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_list_pkey PRIMARY KEY (id);
 C   ALTER TABLE ONLY public.student DROP CONSTRAINT student_list_pkey;
       public                 postgres    false    219            q           2606    24822    student_list student_list_pkey1 
   CONSTRAINT     ]   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_pkey1 PRIMARY KEY (id);
 I   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_pkey1;
       public                 postgres    false    222            r           2606    16560 '   student student_list_curriculum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_list_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id);
 Q   ALTER TABLE ONLY public.student DROP CONSTRAINT student_list_curriculum_id_fkey;
       public               postgres    false    4715    219    218            s           2606    16555 #   student student_list_prefix_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_list_prefix_id_fkey FOREIGN KEY (prefix_id) REFERENCES public.prefix(id);
 M   ALTER TABLE ONLY public.student DROP CONSTRAINT student_list_prefix_id_fkey;
       public               postgres    false    4713    219    217               �   x��Q1�`��~��@����\cK���~a6�U4�D��T�"8�y?%=%�z�-���{w��=A�z��!�]AG����*�ׄ�E�3���Di7�*�Ф9�;���4C�4���t ���$����������K�xi�x:p���Ų� !�2fP1�a�mCZ��kcKN�hQ?e�g���_���w]�W�o�B�         %   x�3�|�c���X�eg�?ر
�X����� �jL            x�3�,NM6�2QF\1z\\\ -�         �  x����J�@��ӧ�Rv�I��� ^��"�FPo*���I���Q#�V����Gqv�hT�Z�vw2����l5�@xJxFxK8��1��3�<x$D��m<�<m���#�W��ܷ��:�&a_v�N�m�@�^����F���Ҵ���w���Zs)�J�������;W�)�o���D(\_����>^H�'���hO�<_)�o���w�/CQ�J�8�ʁ;�;qÍ�$�J2.L�bk���z�֭`��f��Z.SrM�x�Na697�+���:���k�t��(
%��Ab� �����|���N�]J3�;rj���/Rr"-��y��������d�U�a�_��#P�� nYiu|ZO{�Z�T{�M۵�Y�\�`�~�lP��L9���L�'����
*��ebma9iW������c��h4�r�&�      
   a   x�����  �7�� X�fq����&&e��"q���s�8t�a����1M�Q�
�Ӿ��������\*'pm�G̶ZG%S�q��T�  �~�     