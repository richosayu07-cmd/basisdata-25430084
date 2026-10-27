CREATE DATABASE IF NOT EXISTS kopma_25430084;
USE kopma_25430084;

CREATE TABLE anggota (
    id_anggota INT NOT NULL AUTO_INCREMENT,
    kode_anggota CHAR(10) NOT NULL,
    nama_anggota VARCHAR(100) NOT NULL,
    alamat_anggota VARCHAR(200),
    no_telp_anggota VARCHAR(15),
    PRIMARY KEY (id_anggota),
    UNIQUE KEY uq_anggota_kode (kode_anggota)
) ENGINE=InnoDB;

CREATE TABLE barang (
    id_barang INT NOT NULL AUTO_INCREMENT,
    kode_barang VARCHAR(15) NOT NULL,
    nama_barang VARCHAR(100) NOT NULL,
    satuan_barang VARCHAR(20) NOT NULL,
    harga_jual_barang DECIMAL(12,2) NOT NULL,
    stok_barang INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_barang),
    UNIQUE KEY uq_barang_kode (kode_barang),
    CONSTRAINT ck_barang_harga CHECK (harga_jual_barang >= 0),
    CONSTRAINT ck_barang_stok CHECK (stok_barang >= 0)
) ENGINE=InnoDB;

CREATE TABLE pemasok (
    id_pemasok INT NOT NULL AUTO_INCREMENT,
    kode_pemasok CHAR(6) NOT NULL,
    nama_pemasok VARCHAR(100) NOT NULL,
    alamat_pemasok VARCHAR(200),
    no_telp_pemasok VARCHAR(15),
    PRIMARY KEY (id_pemasok),
    UNIQUE KEY uq_pemasok_kode (kode_pemasok)
) ENGINE=InnoDB;

CREATE TABLE penjualan (
    id_penjualan INT NOT NULL AUTO_INCREMENT,
    no_nota_penjualan CHAR(12) NOT NULL,
    tgl_penjualan DATETIME NOT NULL,
    id_petugas SMALLINT NOT NULL,
    id_anggota INT NULL,
    bayar_penjualan DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_penjualan),
    UNIQUE KEY uq_penjualan_nota (no_nota_penjualan),
    CONSTRAINT fk_penjualan_petugas
        FOREIGN KEY (id_petugas) REFERENCES petugas (id_petugas),
    CONSTRAINT fk_penjualan_anggota
        FOREIGN KEY (id_anggota) REFERENCES anggota (id_anggota)
) ENGINE=InnoDB;

CREATE TABLE detail_penjualan (
    id_penjualan INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_penjualan SMALLINT NOT NULL,
    harga_satuan_detail_penjualan DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_penjualan, id_barang),
    CONSTRAINT fk_detail_penjualan
        FOREIGN KEY (id_penjualan) REFERENCES penjualan (id_penjualan)
        ON DELETE CASCADE,
    CONSTRAINT fk_detail_barang
        FOREIGN KEY (id_barang) REFERENCES barang (id_barang),
    CONSTRAINT ck_detail_qty CHECK (qty_detail_penjualan > 0)
) ENGINE=InnoDB;

CREATE TABLE pembelian (
    id_pembelian INT NOT NULL AUTO_INCREMENT,
    no_faktur_pembelian VARCHAR(20) NOT NULL,
    tgl_pembelian DATE NOT NULL,
    id_pemasok INT NOT NULL,
    status_pembelian ENUM('dipesan','diterima')
        NOT NULL DEFAULT 'dipesan',
    PRIMARY KEY (id_pembelian),
    CONSTRAINT fk_pembelian_pemasok
        FOREIGN KEY (id_pemasok) REFERENCES pemasok (id_pemasok)
) ENGINE=InnoDB;

CREATE TABLE detail_pembelian (
    id_pembelian INT NOT NULL,
    id_barang INT NOT NULL,
    qty_detail_pembelian INT NOT NULL,
    harga_beli_detail_pembelian DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_pembelian, id_barang),
    CONSTRAINT fk_dbeli_pembelian
        FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian)
        ON DELETE CASCADE,
    CONSTRAINT fk_dbeli_barang
        FOREIGN KEY (id_barang) REFERENCES barang (id_barang),
    CONSTRAINT ck_dbeli_qty CHECK (qty_detail_pembelian > 0)
) ENGINE=InnoDB;

SHOW TABLES;

-- =========================================
-- D.3 MEMBUKTIKAN CONSTRAINT BEKERJA
-- =========================================

-- Uji 1: Foreign Key
-- Gagal karena id_petugas 99 belum tentu terdaftar.
INSERT INTO penjualan (
    no_nota_penjualan,
    tgl_penjualan,
    id_petugas,
    id_anggota,
    bayar_penjualan
)
VALUES (
    'PJ-2609-0199',
    NOW(),
    99,
    NULL,
    5000
);

-- Uji 2: CHECK
-- Gagal jika stok negatif tidak diizinkan.
UPDATE barang
SET stok_barang = -1
WHERE id_barang = 1;

-- Uji 3: UNIQUE
-- Gagal jika kode ATK-001 sudah digunakan.
INSERT INTO barang (
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
)
VALUES (
    'ATK-001',
    'Barang Duplikat',
    'ATK',
    1000
);

-- =========================================
-- D.4 PEMERIKSAAN STRUKTUR TABEL
-- =========================================

-- Menampilkan semua tabel dalam database
SHOW TABLES;

-- Memeriksa struktur tabel penjualan
SHOW CREATE TABLE penjualan;

-- Memeriksa struktur tabel barang
SHOW CREATE TABLE barang;

-- =========================================
-- IDENTITAS PRAKTIKUM
-- Modul 5: Membangun Struktur dengan DDL dan Constraint
-- Proyek: Koperasi Mahasiswa (Kopma)
-- NIM: 25430084
-- =========================================
