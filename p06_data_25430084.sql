-- =====================================================
-- MILESTONE PROYEK 6
-- DATABASE SISTEM AKADEMIK
-- NIM: 25430084
-- P = (84 MOD 9) + 1 = 4
-- TARGET KRS = 10 x 4 = 40
-- =====================================================

CREATE DATABASE IF NOT EXISTS akad_084;
USE akad_084;

-- 1. TABEL MAHASISWA
CREATE TABLE mahasiswa (
    id_mahasiswa INT NOT NULL AUTO_INCREMENT,
    nim_mahasiswa VARCHAR(20) NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    status_mahasiswa ENUM('aktif','cuti','nonaktif','lulus')
        NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_mahasiswa),
    UNIQUE KEY uq_mahasiswa_nim (nim_mahasiswa)
) ENGINE=InnoDB;

-- 2. TABEL DOSEN
CREATE TABLE dosen (
    id_dosen INT NOT NULL AUTO_INCREMENT,
    nidn VARCHAR(20) NOT NULL,
    nama_dosen VARCHAR(100) NOT NULL,
    email_dosen VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (id_dosen),
    UNIQUE KEY uq_dosen_nidn (nidn)
) ENGINE=InnoDB;

-- 3. TABEL MATA KULIAH
CREATE TABLE mata_kuliah (
    id_matkul INT NOT NULL AUTO_INCREMENT,
    kode_matkul VARCHAR(15) NOT NULL,
    nama_matkul VARCHAR(100) NOT NULL,
    bobot_sks TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_matkul),
    UNIQUE KEY uq_matkul_kode (kode_matkul),
    CONSTRAINT chk_matkul_sks CHECK (bobot_sks >= 1)
) ENGINE=InnoDB;

-- 4. TABEL RUANGAN
CREATE TABLE ruangan (
    id_ruangan INT NOT NULL AUTO_INCREMENT,
    kode_ruangan VARCHAR(15) NOT NULL,
    nama_ruangan VARCHAR(100) NOT NULL,
    daya_tampung INT NOT NULL,
    PRIMARY KEY (id_ruangan),
    CONSTRAINT chk_ruangan_daya_tampung
        CHECK (daya_tampung > 0)
) ENGINE=InnoDB;

-- 5. TABEL KELAS
CREATE TABLE kelas (
    id_kelas INT NOT NULL AUTO_INCREMENT,
    kode_kelas VARCHAR(20) NOT NULL,
    id_matkul INT NOT NULL,
    id_ruangan INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    tahun_ajaran VARCHAR(9) NOT NULL,
    kapasitas_maksimal INT NOT NULL,
    batas_penutupan_nilai DATETIME DEFAULT NULL,
    PRIMARY KEY (id_kelas),
    UNIQUE KEY uq_kelas_kode_semester_tahun
        (kode_kelas, semester, tahun_ajaran),
    CONSTRAINT fk_kelas_matkul
        FOREIGN KEY (id_matkul)
        REFERENCES mata_kuliah(id_matkul),
    CONSTRAINT fk_kelas_ruangan
        FOREIGN KEY (id_ruangan)
        REFERENCES ruangan(id_ruangan),
    CONSTRAINT chk_kelas_kapasitas
        CHECK (kapasitas_maksimal > 0)
) ENGINE=InnoDB;

-- 6. TABEL KRS
CREATE TABLE krs (
    id_krs INT NOT NULL AUTO_INCREMENT,
    no_krs VARCHAR(25) NOT NULL,
    id_mahasiswa INT NOT NULL,
    id_dosen_wali INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    tahun_ajaran VARCHAR(9) NOT NULL,
    tanggal_pengisian DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    status_persetujuan
        ENUM('menunggu','disetujui','ditolak')
        NOT NULL DEFAULT 'menunggu',
    PRIMARY KEY (id_krs),
    UNIQUE KEY uq_krs_no (no_krs),
    UNIQUE KEY uq_krs_mahasiswa_semester_tahun
        (id_mahasiswa, semester, tahun_ajaran),
    CONSTRAINT fk_krs_mahasiswa
        FOREIGN KEY (id_mahasiswa)
        REFERENCES mahasiswa(id_mahasiswa),
    CONSTRAINT fk_krs_dosen_wali
        FOREIGN KEY (id_dosen_wali)
        REFERENCES dosen(id_dosen)
) ENGINE=InnoDB;

-- 7. TABEL DOSEN PENGAMPU
CREATE TABLE dosen_pengampu (
    id_kelas INT NOT NULL,
    id_dosen INT NOT NULL,
    peran_pengampu
        ENUM('utama','pendamping')
        NOT NULL DEFAULT 'utama',
    PRIMARY KEY (id_kelas, id_dosen),
    CONSTRAINT fk_pengampu_kelas
        FOREIGN KEY (id_kelas)
        REFERENCES kelas(id_kelas),
    CONSTRAINT fk_pengampu_dosen
        FOREIGN KEY (id_dosen)
        REFERENCES dosen(id_dosen)
) ENGINE=InnoDB;

-- 8. TABEL DETAIL KRS
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_kelas INT NOT NULL,
    nilai_huruf
        ENUM('A','A-','B+','B','B-','C+','C','D','E')
        DEFAULT NULL,
    PRIMARY KEY (id_krs, id_kelas),
    CONSTRAINT fk_detail_krs_krs
        FOREIGN KEY (id_krs)
        REFERENCES krs(id_krs),
    CONSTRAINT fk_detail_krs_kelas
        FOREIGN KEY (id_kelas)
        REFERENCES kelas(id_kelas)
) ENGINE=InnoDB;

-- =====================================================

USE akad_084;

-- 1. DATA MAHASISWA (40 BARIS)
INSERT INTO mahasiswa
(nim_mahasiswa, nama_mahasiswa, status_mahasiswa)
VALUES
('25430001', 'Andi Pratama', 'aktif'),
('25430002', 'Budi Santoso', 'aktif'),
('25430003', 'Citra Lestari', 'aktif'),
('25430004', 'Dimas Saputra', 'aktif'),
('25430005', 'Eka Permata', 'aktif'),
('25430006', 'Mahasiswa 006', 'aktif'),
('25430007', 'Mahasiswa 007', 'aktif'),
('25430008', 'Mahasiswa 008', 'aktif'),
('25430009', 'Mahasiswa 009', 'aktif'),
('25430010', 'Mahasiswa 010', 'aktif'),
('25430011', 'Mahasiswa 011', 'aktif'),
('25430012', 'Mahasiswa 012', 'aktif'),
('25430013', 'Mahasiswa 013', 'aktif'),
('25430014', 'Mahasiswa 014', 'aktif'),
('25430015', 'Mahasiswa 015', 'aktif'),
('25430016', 'Mahasiswa 016', 'aktif'),
('25430017', 'Mahasiswa 017', 'aktif'),
('25430018', 'Mahasiswa 018', 'aktif'),
('25430019', 'Mahasiswa 019', 'aktif'),
('25430020', 'Mahasiswa 020', 'aktif'),
('25430021', 'Mahasiswa 021', 'aktif'),
('25430022', 'Mahasiswa 022', 'aktif'),
('25430023', 'Mahasiswa 023', 'aktif'),
('25430024', 'Mahasiswa 024', 'aktif'),
('25430025', 'Mahasiswa 025', 'aktif'),
('25430026', 'Mahasiswa 026', 'aktif'),
('25430027', 'Mahasiswa 027', 'aktif'),
('25430028', 'Mahasiswa 028', 'aktif'),
('25430029', 'Mahasiswa 029', 'aktif'),
('25430030', 'Mahasiswa 030', 'aktif'),
('25430031', 'Mahasiswa 031', 'aktif'),
('25430032', 'Mahasiswa 032', 'aktif'),
('25430033', 'Mahasiswa 033', 'aktif'),
('25430034', 'Mahasiswa 034', 'aktif'),
('25430035', 'Mahasiswa 035', 'aktif'),
('25430036', 'Mahasiswa 036', 'aktif'),
('25430037', 'Mahasiswa 037', 'aktif'),
('25430038', 'Mahasiswa 038', 'aktif'),
('25430039', 'Mahasiswa 039', 'aktif'),
('25430040', 'Mahasiswa 040', 'aktif');


-- 2. DATA DOSEN (5 BARIS)
INSERT INTO dosen
(nidn, nama_dosen, email_dosen)
VALUES
('D001', 'Agus Setiawan', 'agus@example.com'),
('D002', 'Dewi Anggraini', 'dewi@example.com'),
('D003', 'Rudi Hartono', 'rudi@example.com'),
('D004', 'Siti Rahmawati', 'siti@example.com'),
('D005', 'Bambang Prakoso', 'bambang@example.com');


-- 3. DATA MATA KULIAH (5 BARIS)
INSERT INTO mata_kuliah
(kode_matkul, nama_matkul, bobot_sks)
VALUES
('BD101', 'Basis Data', 3),
('AL101', 'Algoritma dan Pemrograman', 3),
('PW101', 'Pemrograman Web', 3),
('JK101', 'Jaringan Komputer', 2),
('SI101', 'Sistem Informasi', 3);


-- 4. DATA RUANGAN (5 BARIS)
INSERT INTO ruangan
(kode_ruangan, nama_ruangan, daya_tampung)
VALUES
('R101', 'Ruang Teori 1', 40),
('R102', 'Ruang Teori 2', 35),
('R103', 'Lab Komputer 1', 30),
('R104', 'Lab Komputer 2', 25),
('R105', 'Ruang Seminar', 50);


-- 5. DATA KELAS (5 BARIS)
INSERT INTO kelas
(kode_kelas, id_matkul, id_ruangan, semester,
 tahun_ajaran, kapasitas_maksimal, batas_penutupan_nilai)
VALUES
('BD101-A', 1, 1, 'Ganjil', '2026/2027', 35, NULL),
('AL101-A', 2, 2, 'Ganjil', '2026/2027', 30, NULL),
('PW101-A', 3, 3, 'Ganjil', '2026/2027', 25, NULL),
('JK101-A', 4, 4, 'Ganjil', '2026/2027', 20, NULL),
('SI101-A', 5, 5, 'Ganjil', '2026/2027', 40, NULL);

-- =====================================================
-- DATA TRANSAKSI DAN PEMERIKSAAN
-- =====================================================

USE akad_084;

-- 1. DATA DOSEN PENGAMPU (5 BARIS)
INSERT INTO dosen_pengampu
(id_kelas, id_dosen, peran_pengampu)
VALUES
(1, 1, 'utama'),
(2, 2, 'utama'),
(3, 3, 'utama'),
(4, 4, 'utama'),
(5, 5, 'utama');


-- 2. DATA KRS (40 BARIS)
INSERT INTO krs
(no_krs, id_mahasiswa, id_dosen_wali, semester,
 tahun_ajaran, tanggal_pengisian, status_persetujuan)
VALUES
('KRS-001', 1, 1, 'Ganjil', '2026/2027', '2026-08-01 08:00:00', 'disetujui'),
('KRS-002', 2, 2, 'Ganjil', '2026/2027', '2026-08-01 09:00:00', 'menunggu'),
('KRS-003', 3, 3, 'Ganjil', '2026/2027', '2026-08-01 10:00:00', 'disetujui'),
('KRS-004', 4, 4, 'Ganjil', '2026/2027', '2026-08-02 08:00:00', 'menunggu'),
('KRS-005', 5, 5, 'Ganjil', '2026/2027', '2026-08-02 09:00:00', 'disetujui'),
('KRS-006', 6, 1, 'Ganjil', '2026/2027', '2026-08-02 10:00:00', 'menunggu'),
('KRS-007', 7, 2, 'Ganjil', '2026/2027', '2026-08-02 11:00:00', 'menunggu'),
('KRS-008', 8, 3, 'Ganjil', '2026/2027', '2026-08-02 12:00:00', 'menunggu'),
('KRS-009', 9, 4, 'Ganjil', '2026/2027', '2026-08-02 13:00:00', 'menunggu'),
('KRS-010', 10, 5, 'Ganjil', '2026/2027', '2026-08-02 14:00:00', 'menunggu'),
('KRS-011', 11, 1, 'Ganjil', '2026/2027', '2026-08-03 08:00:00', 'menunggu'),
('KRS-012', 12, 2, 'Ganjil', '2026/2027', '2026-08-03 09:00:00', 'menunggu'),
('KRS-013', 13, 3, 'Ganjil', '2026/2027', '2026-08-03 10:00:00', 'menunggu'),
('KRS-014', 14, 4, 'Ganjil', '2026/2027', '2026-08-03 11:00:00', 'menunggu'),
('KRS-015', 15, 5, 'Ganjil', '2026/2027', '2026-08-03 12:00:00', 'menunggu'),
('KRS-016', 16, 1, 'Ganjil', '2026/2027', '2026-08-03 13:00:00', 'menunggu'),
('KRS-017', 17, 2, 'Ganjil', '2026/2027', '2026-08-03 14:00:00', 'menunggu'),
('KRS-018', 18, 3, 'Ganjil', '2026/2027', '2026-08-03 15:00:00', 'menunggu'),
('KRS-019', 19, 4, 'Ganjil', '2026/2027', '2026-08-03 16:00:00', 'menunggu'),
('KRS-020', 20, 5, 'Ganjil', '2026/2027', '2026-08-03 17:00:00', 'menunggu'),
('KRS-021', 21, 1, 'Ganjil', '2026/2027', '2026-08-01 11:00:00', 'menunggu'),
('KRS-022', 22, 2, 'Ganjil', '2026/2027', '2026-08-01 12:00:00', 'menunggu'),
('KRS-023', 23, 3, 'Ganjil', '2026/2027', '2026-08-01 13:00:00', 'menunggu'),
('KRS-024', 24, 4, 'Ganjil', '2026/2027', '2026-08-01 14:00:00', 'menunggu'),
('KRS-025', 25, 5, 'Ganjil', '2026/2027', '2026-08-01 15:00:00', 'menunggu'),
('KRS-026', 26, 1, 'Ganjil', '2026/2027', '2026-08-02 15:00:00', 'menunggu'),
('KRS-027', 27, 2, 'Ganjil', '2026/2027', '2026-08-02 16:00:00', 'menunggu'),
('KRS-028', 28, 3, 'Ganjil', '2026/2027', '2026-08-02 17:00:00', 'menunggu'),
('KRS-029', 29, 4, 'Ganjil', '2026/2027', '2026-08-02 18:00:00', 'menunggu'),
('KRS-030', 30, 5, 'Ganjil', '2026/2027', '2026-08-02 19:00:00', 'menunggu'),
('KRS-031', 31, 1, 'Ganjil', '2026/2027', '2026-08-03 18:00:00', 'menunggu'),
('KRS-032', 32, 2, 'Ganjil', '2026/2027', '2026-08-03 19:00:00', 'menunggu'),
('KRS-033', 33, 3, 'Ganjil', '2026/2027', '2026-08-03 20:00:00', 'menunggu'),
('KRS-034', 34, 4, 'Ganjil', '2026/2027', '2026-08-03 21:00:00', 'menunggu'),
('KRS-035', 35, 5, 'Ganjil', '2026/2027', '2026-08-03 22:00:00', 'menunggu'),
('KRS-036', 36, 1, 'Ganjil', '2026/2027', '2026-08-01 16:00:00', 'menunggu'),
('KRS-037', 37, 2, 'Ganjil', '2026/2027', '2026-08-01 17:00:00', 'menunggu'),
('KRS-038', 38, 3, 'Ganjil', '2026/2027', '2026-08-02 20:00:00', 'menunggu'),
('KRS-039', 39, 4, 'Ganjil', '2026/2027', '2026-08-02 21:00:00', 'menunggu'),
('KRS-040', 40, 5, 'Ganjil', '2026/2027', '2026-08-03 23:00:00', 'menunggu');


-- 3. DATA DETAIL KRS (45 BARIS)
INSERT INTO detail_krs
(id_krs, id_kelas, nilai_huruf)
VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 2, 'A-'),
(2, 3, 'B+'),
(3, 3, 'A'),
(3, 4, 'B'),
(4, 4, 'B+'),
(4, 5, 'A-'),
(5, 5, 'A'),
(5, 1, 'B'),

(6, 1, NULL),
(7, 2, NULL),
(8, 3, NULL),
(9, 4, NULL),
(10, 5, NULL),
(11, 1, NULL),
(12, 2, NULL),
(13, 3, NULL),
(14, 4, NULL),
(15, 5, NULL),
(16, 1, NULL),
(17, 2, NULL),
(18, 3, NULL),
(19, 4, NULL),
(20, 5, NULL),
(21, 1, NULL),
(22, 2, NULL),
(23, 3, NULL),
(24, 4, NULL),
(25, 5, NULL),
(26, 1, NULL),
(27, 2, NULL),
(28, 3, NULL),
(29, 4, NULL),
(30, 5, NULL),
(31, 1, NULL),
(32, 2, NULL),
(33, 3, NULL),
(34, 4, NULL),
(35, 5, NULL),
(36, 1, NULL),
(37, 2, NULL),
(38, 3, NULL),
(39, 4, NULL),
(40, 5, NULL);


-- =====================================================
-- PART 4: PEMERIKSAAN JUMLAH DATA
-- =====================================================

SELECT 'mahasiswa' AS nama_tabel, COUNT(*) AS jumlah_data FROM mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*) FROM dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*) FROM mata_kuliah
UNION ALL
SELECT 'ruangan', COUNT(*) FROM ruangan
UNION ALL
SELECT 'kelas', COUNT(*) FROM kelas
UNION ALL
SELECT 'krs', COUNT(*) FROM krs
UNION ALL
SELECT 'dosen_pengampu', COUNT(*) FROM dosen_pengampu
UNION ALL
SELECT 'detail_krs', COUNT(*) FROM detail_krs;


-- Memeriksa jumlah tanggal transaksi KRS
SELECT
    COUNT(DISTINCT DATE(tanggal_pengisian)) AS jumlah_tanggal
FROM krs;


-- Memeriksa jumlah transaksi KRS
SELECT COUNT(*) AS total_transaksi
FROM krs;