-- ============================================================
-- Judul     : Milestone Proyek 5 — Membangun Struktur dengan DDL
--             dan Constraint pada Sistem Akademik
-- Nama      : Richo sayu rahmadhani
-- NIM/NPM   : 25430084
-- Kelas     : C
-- Nama file : p05_ddl_25430084.sql
-- Catatan   : Jalankan di MariaDB/MySQL. Skrip dapat dijalankan
--             ulang; tabel lama dalam database proyek ini akan
--             dihapus lalu dibuat kembali.
-- ============================================================

CREATE TABLE dosen (
    id_dosen INT NOT NULL AUTO_INCREMENT,
    nidn VARCHAR(20) NOT NULL,
    nama_dosen VARCHAR(100) NOT NULL,
    email_dosen VARCHAR(100) NULL,
    PRIMARY KEY (id_dosen),
    CONSTRAINT uq_dosen_nidn UNIQUE (nidn)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel mahasiswa
-- AB-01: NIM wajib diisi dan unik.
-- AB-07: status_mahasiswa dipakai untuk menandai keaktifan.
--         Hak akses pengisian KRS berdasarkan status aktif perlu
--         diperiksa oleh aplikasi/prosedur/trigger.
-- ============================================================
CREATE TABLE mahasiswa (
    id_mahasiswa INT NOT NULL AUTO_INCREMENT,
    nim_mahasiswa VARCHAR(20) NOT NULL,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    status_mahasiswa ENUM('aktif', 'cuti', 'nonaktif', 'lulus')
        NOT NULL DEFAULT 'aktif',
    PRIMARY KEY (id_mahasiswa),
    CONSTRAINT uq_mahasiswa_nim UNIQUE (nim_mahasiswa)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel mata_kuliah
-- AB-02: kode_matkul unik dan bobot SKS minimal 1.
-- ============================================================
CREATE TABLE mata_kuliah (
    id_matkul INT NOT NULL AUTO_INCREMENT,
    kode_matkul VARCHAR(15) NOT NULL,
    nama_matkul VARCHAR(100) NOT NULL,
    bobot_sks TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_matkul),
    CONSTRAINT uq_matkul_kode UNIQUE (kode_matkul),
    CONSTRAINT chk_matkul_sks CHECK (bobot_sks >= 1)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel ruangan
-- AB-05: kapasitas fisik ruangan menjadi batas pembanding
--         kapasitas kelas. Perbandingan antar-tabel tidak dapat
--         dijamin dengan CHECK biasa; perlu trigger/aplikasi.
-- ============================================================
CREATE TABLE ruangan (
    id_ruangan INT NOT NULL AUTO_INCREMENT,
    kode_ruangan VARCHAR(15) NOT NULL,
    nama_ruangan VARCHAR(100) NOT NULL,
    daya_tampung INT NOT NULL,
    PRIMARY KEY (id_ruangan),
    CONSTRAINT uq_ruangan_kode UNIQUE (kode_ruangan),
    CONSTRAINT chk_ruangan_daya_tampung CHECK (daya_tampung > 0)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel kelas
-- AB-05: kapasitas_maksimal tidak boleh melampaui daya_tampung
--         ruangan. Karena membandingkan dua tabel, aturan ini
--         dicatat untuk implementasi trigger/aplikasi.
-- AB-06: batas_penutupan_nilai menjadi batas waktu penginputan
--         nilai; kewenangan dosen pengampu perlu dikontrol oleh
--         aplikasi/trigger.
-- ============================================================
CREATE TABLE kelas (
    id_kelas INT NOT NULL AUTO_INCREMENT,
    kode_kelas VARCHAR(20) NOT NULL,
    id_matkul INT NOT NULL,
    id_ruangan INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    tahun_ajaran VARCHAR(9) NOT NULL,
    kapasitas_maksimal INT NOT NULL,
    batas_penutupan_nilai DATETIME NULL,
    PRIMARY KEY (id_kelas),
    CONSTRAINT uq_kelas_kode_semester_tahun
        UNIQUE (kode_kelas, semester, tahun_ajaran),
    CONSTRAINT chk_kelas_kapasitas CHECK (kapasitas_maksimal > 0),
    CONSTRAINT fk_kelas_matkul
        FOREIGN KEY (id_matkul) REFERENCES mata_kuliah(id_matkul),
    CONSTRAINT fk_kelas_ruangan
        FOREIGN KEY (id_ruangan) REFERENCES ruangan(id_ruangan)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel krs
-- AB-03: KRS terhubung ke satu mahasiswa dan dosen wali.
--         Persetujuan dosen wali dicatat melalui status_persetujuan.
--         Mahasiswa harus aktif saat mengisi KRS; pemeriksaan status
--         lintas tabel memerlukan aplikasi/prosedur/trigger.
-- ============================================================
CREATE TABLE krs (
    id_krs INT NOT NULL AUTO_INCREMENT,
    no_krs VARCHAR(25) NOT NULL,
    id_mahasiswa INT NOT NULL,
    id_dosen_wali INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    tahun_ajaran VARCHAR(9) NOT NULL,
    tanggal_pengisian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status_persetujuan ENUM('menunggu', 'disetujui', 'ditolak')
        NOT NULL DEFAULT 'menunggu',
    PRIMARY KEY (id_krs),
    CONSTRAINT uq_krs_no UNIQUE (no_krs),
    CONSTRAINT uq_krs_mahasiswa_semester_tahun
        UNIQUE (id_mahasiswa, semester, tahun_ajaran),
    CONSTRAINT fk_krs_mahasiswa
        FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa),
    CONSTRAINT fk_krs_dosen_wali
        FOREIGN KEY (id_dosen_wali) REFERENCES dosen(id_dosen)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel detail_krs
-- AB-04: P + 2 = 46 + 2 = 48 SKS kumulatif/tahunan.
--         Batas ini menjumlahkan SKS dari banyak baris/transaksi,
--         sehingga CHECK tidak dapat menegakkannya. Tandai untuk
--         diselesaikan pada Modul 14 (misalnya trigger/prosedur).
-- AB-06: nilai_huruf dibatasi pada nilai yang dikenal. Siapa yang
--         boleh mengubah nilai dan batas waktunya perlu dikontrol
--         oleh aplikasi/trigger karena melibatkan pengguna dan waktu.
-- ============================================================
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_kelas INT NOT NULL,
    nilai_huruf ENUM('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'E')
        NULL,
    PRIMARY KEY (id_krs, id_kelas),
    CONSTRAINT fk_detail_krs_krs
        FOREIGN KEY (id_krs) REFERENCES krs(id_krs)
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_krs_kelas
        FOREIGN KEY (id_kelas) REFERENCES kelas(id_kelas)
) ENGINE=InnoDB;

-- ============================================================
-- Tabel dosen_pengampu
-- AB-08: relasi kelas dan dosen pengampu. Foreign Key memastikan
--         setiap baris penugasan mengacu pada dosen dan kelas yang
--         terdaftar. Keharusan minimal satu dosen untuk setiap kelas
--         tidak dapat dijamin dengan FK/CHECK biasa karena perlu
--         memeriksa keberadaan baris pada tabel lain; tandai untuk
--         validasi aplikasi/trigger/prosedur.
-- ============================================================
CREATE TABLE dosen_pengampu (
    id_kelas INT NOT NULL,
    id_dosen INT NOT NULL,
    peran_pengampu ENUM('utama', 'pendamping') NOT NULL DEFAULT 'utama',
    PRIMARY KEY (id_kelas, id_dosen),
    CONSTRAINT fk_pengampu_kelas
        FOREIGN KEY (id_kelas) REFERENCES kelas(id_kelas)
        ON DELETE CASCADE,
    CONSTRAINT fk_pengampu_dosen
        FOREIGN KEY (id_dosen) REFERENCES dosen(id_dosen)
) ENGINE=InnoDB;

-- ============================================================
-- Ringkasan aturan yang perlu validasi di luar CHECK/FK biasa:
-- AB-03: mahasiswa harus berstatus aktif saat mengisi KRS.
-- AB-04: jumlah SKS kumulatif/tahunan maksimal 48 (Modul 14).
-- AB-05: kapasitas kelas <= daya tampung ruangan.
-- AB-06: hanya dosen pengampu boleh mengelola nilai sebelum tenggat.
-- AB-07: status aktif menentukan hak akses pengisian KRS.
-- AB-08: setiap kelas wajib memiliki minimal satu dosen pengampu.
-- ============================================================