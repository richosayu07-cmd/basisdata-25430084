-- =====================================================
-- FILE PRAKTIKUM MODUL 6
-- Nama File : p06_data_kopma_25430084.sql
-- Database : kopma_25430084
-- NIM      : 25430084
-- Materi   : Data Master, Transaksi, UPDATE dan DELETE
-- =====================================================

USE kopma_25430084;


-- =====================================================
-- D.1 DATA MASTER
-- =====================================================

-- 1. Data Barang

INSERT INTO barang
(id_barang, kode_barang, nama_barang, kategori_barang,
 harga_jual_barang, stok_barang, stok_min_barang)
VALUES
(1, 'ATK-001', 'Pulpen Hitam', 'ATK', 3000, 50, 5),
(8, 'ATK-002', 'Buku Tulis', 'ATK', 5000, 40, 5),
(9, 'ATK-003', 'Pensil 2B', 'ATK', 2500, 30, 5);


-- 2. Data Anggota

INSERT INTO anggota
(id_anggota, no_anggota, nim_anggota, nama_anggota,
 prodi_anggota, no_hp_anggota, status_anggota,
 tgl_daftar_anggota)
VALUES
(1, 'A-1001', NULL, 'Andi Saputra',
 NULL, NULL, 'aktif', NULL),
(2, 'A-1002', NULL, 'Siti Rahma',
 NULL, NULL, 'aktif', NULL),
(3, 'A-1003', NULL, 'Budi Santoso',
 NULL, NULL, 'nonaktif', NULL);


-- 3. Data Pemasok

INSERT INTO pemasok
(kode_pemasok, nama_pemasok, alamat_pemasok,
 no_telp_pemasok)
VALUES
('PS-001', 'PT Sumber Makmur',
 'Bandar Lampung', '081234567801'),
('PS-002', 'CV Berkah Jaya',
 'Lampung Selatan', '081234567802');


-- =====================================================
-- D.2 TRANSAKSI PENJUALAN
-- =====================================================

-- 1. Membuat transaksi penjualan

INSERT INTO penjualan
(no_nota_penjualan, tgl_penjualan, id_petugas,
 id_anggota, bayar_penjualan)
VALUES
('PJ-2609-0142', '2026-09-24 10:15:00',
 3, 1, 30000);


-- 2. Memasukkan detail transaksi ATK-001

INSERT INTO detail_penjualan
(id_penjualan, id_barang, qty_detail_penjualan,
 harga_satuan_detail_penjualan)
SELECT 2, id_barang, 3, harga_jual_barang
FROM barang
WHERE kode_barang = 'ATK-001';


-- 3. Memasukkan detail transaksi ATK-002

INSERT INTO detail_penjualan
(id_penjualan, id_barang, qty_detail_penjualan,
 harga_satuan_detail_penjualan)
SELECT 2, id_barang, 2, harga_jual_barang
FROM barang
WHERE kode_barang = 'ATK-002';


-- 4. Memasukkan detail transaksi ATK-003

INSERT INTO detail_penjualan
(id_penjualan, id_barang, qty_detail_penjualan,
 harga_satuan_detail_penjualan)
SELECT 2, id_barang, 1, harga_jual_barang
FROM barang
WHERE kode_barang = 'ATK-003';


-- 5. Mengurangi stok barang setelah transaksi

UPDATE barang
SET stok_barang = stok_barang - 3
WHERE kode_barang = 'ATK-001';

UPDATE barang
SET stok_barang = stok_barang - 2
WHERE kode_barang = 'ATK-002';

UPDATE barang
SET stok_barang = stok_barang - 1
WHERE kode_barang = 'ATK-003';


-- 6. Menampilkan detail transaksi

SELECT
    p.no_nota_penjualan,
    p.tgl_penjualan,
    d.id_barang,
    d.qty_detail_penjualan,
    d.harga_satuan_detail_penjualan
FROM penjualan p
JOIN detail_penjualan d
ON p.id_penjualan = d.id_penjualan
WHERE p.no_nota_penjualan = 'PJ-2609-0142';


-- =====================================================
-- D.3 PENGUJIAN UPDATE DAN DELETE
-- =====================================================

-- 1. Mengaktifkan SQL Safe Updates

SET GLOBAL sql_safe_updates = 1;
SET SESSION sql_safe_updates = 1;


-- 2. Memeriksa status SQL Safe Updates

SELECT
    @@GLOBAL.sql_safe_updates AS mode_global,
    @@SESSION.sql_safe_updates AS mode_session;


-- 3. Pengujian UPDATE tanpa WHERE
-- Perintah ini sengaja dijalankan untuk membuktikan
-- bahwa SQL Safe Updates menolak perubahan tanpa WHERE.
-- HASIL: ERROR #1175 (SESUAI HARAPAN).

-- UPDATE barang
-- SET harga_jual_barang = harga_jual_barang * 1.1;


-- 4. Pengujian UPDATE menggunakan WHERE

UPDATE barang
SET harga_jual_barang = harga_jual_barang * 1.1
WHERE kategori_barang = 'ATK'
AND id_barang > 0;


-- 5. Mengembalikan harga barang ke harga awal

UPDATE barang
SET harga_jual_barang = CASE
    WHEN kode_barang = 'ATK-001' THEN 3000
    WHEN kode_barang = 'ATK-002' THEN 5000
    WHEN kode_barang = 'ATK-003' THEN 2500
END
WHERE kode_barang IN
('ATK-001', 'ATK-002', 'ATK-003');


-- 6. Membuat transaksi percobaan untuk pengujian DELETE

INSERT INTO penjualan
(no_nota_penjualan, tgl_penjualan, id_petugas,
 id_anggota, bayar_penjualan)
VALUES
('PJ-TEST-0001', '2026-09-25 10:00:00',
 3, 1, 10000);


-- 7. Membuat detail transaksi percobaan

INSERT INTO detail_penjualan
(id_penjualan, id_barang, qty_detail_penjualan,
 harga_satuan_detail_penjualan)
SELECT 5, id_barang, 1, harga_jual_barang
FROM barang
WHERE kode_barang = 'ATK-001';


-- 8. Menghapus transaksi percobaan

DELETE FROM penjualan
WHERE id_penjualan = 5;


-- 9. Memeriksa apakah detail transaksi ikut terhapus

SELECT *
FROM detail_penjualan
WHERE id_penjualan = 5;


-- 10. Pengujian menghapus petugas yang masih memiliki transaksi
-- HASIL: ERROR #1451 (SESUAI HARAPAN).
-- Perintah ini tidak dijalankan ulang karena petugas
-- ID 3 masih digunakan oleh transaksi utama.

-- DELETE FROM petugas
-- WHERE id_petugas = 3;


-- =====================================================
-- AKHIR PRAKTIKUM D.3
-- =====================================================