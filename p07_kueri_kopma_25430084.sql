-- Nama       : Richo Sayu Rahmadhani
-- NIM        : 25430084
-- Kelas      : C
-- Database   : kopma_25430084
-- Mata Kuliah: Basis Data
--
-- Tujuan:
-- Melakukan pengambilan data menggunakan SELECT,
-- penyaringan data, pola teks, nilai NULL, fungsi skalar,
-- tanggal, dan perhitungan per baris.
--
-- ==========================================================

USE kopma_25430084;


-- ==========================================================
-- D.1 PROYEKSI DAN PENYARINGAN
-- ==========================================================


-- ----------------------------------------------------------
-- KUERI 1
-- KI-03: Barang yang perlu dipesan ulang.
-- Pertanyaan:
-- Barang apa saja yang stoknya berada di bawah stok minimum?
-- Hasil yang diharapkan:
-- Menampilkan barang yang stoknya kurang dari stok minimum.
-- ----------------------------------------------------------

SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
       stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_barang < stok_min_barang
ORDER BY kurang DESC;


-- ----------------------------------------------------------
-- KUERI 2
-- KI-03: Menampilkan barang kategori ATK atau Minuman.
-- Pertanyaan:
-- Barang apa saja yang termasuk kategori ATK atau Minuman?
-- Hasil yang diharapkan:
-- Menampilkan barang dari kedua kategori tersebut.
-- ----------------------------------------------------------

SELECT kode_barang, nama_barang, kategori_barang,
       harga_jual_barang, stok_barang
FROM barang
WHERE kategori_barang IN ('ATK', 'Minuman')
ORDER BY kategori_barang, nama_barang;


-- ----------------------------------------------------------
-- KUERI 3
-- KI-03: Menampilkan penjualan pada rentang tanggal.
-- Pertanyaan:
-- Transaksi apa saja yang terjadi selama September 2026?
-- Hasil yang diharapkan:
-- Menampilkan nomor nota, tanggal, dan pembayaran.
-- ----------------------------------------------------------

SELECT no_nota_penjualan, tgl_penjualan, bayar_penjualan
FROM penjualan
WHERE tgl_penjualan BETWEEN '2026-09-01 00:00:00'
                        AND '2026-09-30 23:59:59'
ORDER BY tgl_penjualan ASC;


-- ----------------------------------------------------------
-- KUERI 4
-- KI-03: Menampilkan anggota tanpa nomor HP.
-- Pertanyaan:
-- Anggota mana saja yang belum memiliki nomor HP?
-- Hasil yang diharapkan:
-- Menampilkan anggota dengan nilai no_hp_anggota NULL.
-- ----------------------------------------------------------

SELECT id_anggota, no_anggota, nama_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NULL
ORDER BY nama_anggota ASC;


-- ----------------------------------------------------------
-- TITIK ANALISIS 1
-- Menguji penggunaan alias pada WHERE.
-- Pertanyaan:
-- Apakah alias kurang dapat digunakan langsung pada WHERE?
-- Hasil yang diharapkan:
-- MySQL menghasilkan error Unknown column 'kurang'.
-- ----------------------------------------------------------

-- Contoh kueri yang menghasilkan error:
-- SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
--        stok_min_barang - stok_barang AS kurang
-- FROM barang
-- WHERE kurang > 0
-- ORDER BY kurang DESC;


-- Perbaikan:
-- Perhitungan ditulis ulang secara langsung pada WHERE.

SELECT kode_barang, nama_barang, stok_barang, stok_min_barang,
       stok_min_barang - stok_barang AS kurang
FROM barang
WHERE stok_min_barang - stok_barang > 0
ORDER BY kurang DESC;


-- ==========================================================
-- D.2 POLA TEKS DAN NILAI KOSONG
-- ==========================================================


-- ----------------------------------------------------------
-- KUERI 5
-- KI-03: Menampilkan anggota dengan huruf a pada nama.
-- Pertanyaan:
-- Siapa anggota yang namanya mengandung huruf a?
-- Hasil yang diharapkan:
-- Menampilkan maksimal lima anggota yang sesuai.
-- ----------------------------------------------------------

SELECT CONCAT(nama_anggota, ' (', no_anggota, ')') AS anggota,
       DATE_FORMAT(tgl_daftar_anggota, '%d-%m-%Y') AS tgl_daftar,
       IFNULL(no_hp_anggota, '-') AS hp,
       CASE
           WHEN status_anggota = 'aktif' THEN 'Diskon 5%'
           ELSE 'Tanpa diskon'
       END AS keterangan
FROM anggota
WHERE nama_anggota LIKE '%a%'
ORDER BY tgl_daftar_anggota DESC
LIMIT 5;


-- ----------------------------------------------------------
-- KUERI 6
-- KI-03: Menampilkan anggota yang memiliki nomor HP.
-- Pertanyaan:
-- Anggota mana saja yang sudah memiliki nomor HP?
-- Hasil yang diharapkan:
-- Menampilkan anggota dengan nomor HP yang tidak NULL.
-- ----------------------------------------------------------

SELECT id_anggota, no_anggota, nama_anggota, no_hp_anggota
FROM anggota
WHERE no_hp_anggota IS NOT NULL
ORDER BY nama_anggota ASC;


-- ----------------------------------------------------------
-- TITIK ANALISIS 2
-- Pertanyaan:
-- Mengapa no_hp_anggota = NULL tidak digunakan?
-- Jawaban:
-- NULL harus diperiksa menggunakan IS NULL atau IS NOT NULL.
-- NULL berbeda dengan string kosong ('').
-- ----------------------------------------------------------


-- ==========================================================
-- D.3 TANGGAL DAN PERHITUNGAN PER BARIS
-- ==========================================================


-- ----------------------------------------------------------
-- KUERI 7
-- KI-03: Menghitung lama keanggotaan.
-- Pertanyaan:
-- Berapa lama setiap anggota telah terdaftar?
-- Hasil yang diharapkan:
-- Menampilkan lama keanggotaan dalam hari dan kategorinya.
-- ----------------------------------------------------------

SELECT no_anggota, nama_anggota,
       DATEDIFF(CURDATE(), tgl_daftar_anggota) AS lama_hari,
       CASE
           WHEN DATEDIFF(CURDATE(), tgl_daftar_anggota) < 180
           THEN 'baru'
           ELSE 'lama'
       END AS kategori_keanggotaan
FROM anggota
ORDER BY lama_hari DESC;


-- ----------------------------------------------------------
-- KUERI 8
-- KI-03: Menampilkan anggota berstatus aktif.
-- Pertanyaan:
-- Siapa saja anggota yang memiliki status aktif?
-- Hasil yang diharapkan:
-- Menampilkan data anggota dengan status aktif.
-- ----------------------------------------------------------

SELECT no_anggota, nama_anggota, status_anggota,
       tgl_daftar_anggota
FROM anggota
WHERE status_anggota = 'aktif'
ORDER BY nama_anggota ASC;


-- ----------------------------------------------------------
-- KUERI 9
-- KI-03: Menampilkan barang dengan harga tertentu.
-- Pertanyaan:
-- Barang apa saja yang memiliki harga jual minimal Rp3.000?
-- Hasil yang diharapkan:
-- Menampilkan barang dengan harga jual minimal Rp3.000.
-- ----------------------------------------------------------

SELECT kode_barang, nama_barang, harga_jual_barang
FROM barang
WHERE harga_jual_barang >= 3000
ORDER BY harga_jual_barang DESC;


-- ----------------------------------------------------------
-- KUERI 10
-- KI-03: Menampilkan nota dengan pembayaran tertentu.
-- Pertanyaan:
-- Transaksi apa saja yang memiliki pembayaran minimal Rp20.000?
-- Hasil yang diharapkan:
-- Menampilkan nota dengan nilai pembayaran minimal Rp20.000.
-- ----------------------------------------------------------

SELECT no_nota_penjualan, tgl_penjualan, bayar_penjualan
FROM penjualan
WHERE bayar_penjualan >= 20000
ORDER BY bayar_penjualan DESC;


-- ----------------------------------------------------------
-- KUERI 11
-- KI-03: Menghitung subtotal setiap detail penjualan.
-- Pertanyaan:
-- Berapa subtotal setiap barang dalam nota PJ-2609-0142?
-- Hasil yang diharapkan:
-- Menampilkan barang, jumlah, harga satuan, dan subtotal.
--
-- CATATAN:
-- Kueri ini membutuhkan beberapa tabel (JOIN).
-- Tidak termasuk kueri satu tabel.
-- ----------------------------------------------------------

SELECT p.no_nota_penjualan,
       b.kode_barang,
       b.nama_barang,
       d.qty_detail_penjualan,
       d.harga_satuan_detail_penjualan,
       d.qty_detail_penjualan * d.harga_satuan_detail_penjualan
           AS subtotal
FROM penjualan p
JOIN detail_penjualan d
    ON p.id_penjualan = d.id_penjualan
JOIN barang b
    ON d.id_barang = b.id_barang
WHERE p.no_nota_penjualan = 'PJ-2609-0142';


-- ----------------------------------------------------------
-- KUERI 12
-- KI-03: Menghitung total subtotal nota.
-- Pertanyaan:
-- Berapa total seluruh subtotal barang pada nota tersebut?
-- Hasil yang diharapkan:
-- Menghasilkan satu nilai total nota.
--
-- CATATAN:
-- Kueri ini menggunakan SUM() dan subquery.
-- Membutuhkan tabel penjualan dan detail_penjualan.
-- Tidak termasuk kueri satu tabel.
-- ----------------------------------------------------------

SELECT SUM(qty_detail_penjualan * harga_satuan_detail_penjualan)
       AS total_nota
FROM detail_penjualan
WHERE id_penjualan = (
    SELECT id_penjualan
    FROM penjualan
    WHERE no_nota_penjualan = 'PJ-2609-0142'
);


-- ----------------------------------------------------------
-- TITIK ANALISIS 3
-- Pertanyaan:
-- Mengapa subtotal dapat dihitung per baris, tetapi total
-- nota membutuhkan fitur SQL yang berbeda?
--
-- Jawaban:
-- Perkalian menghitung subtotal setiap baris.
-- Untuk menjumlahkan seluruh subtotal menjadi satu nilai,
-- digunakan fungsi agregat SUM().
-- ----------------------------------------------------------

-- ==========================================================
-- E. LATIHAN DAN MODIFIKASI
-- ==========================================================


-- ----------------------------------------------------------
-- E.1 MENAMPILKAN NAMA BARANG DENGAN HURUF KAPITAL
--     DAN HARGA DALAM FORMAT RUPIAH
--
-- Pertanyaan:
-- Bagaimana menampilkan nama barang menggunakan huruf
-- kapital dan harga jual dengan format Rupiah?
--
-- Hasil yang diharapkan:
-- Nama barang ditampilkan menggunakan UPPER() dan harga
-- ditampilkan menggunakan format Rupiah.
-- ----------------------------------------------------------

SELECT
    UPPER(nama_barang) AS nama_barang,
    CONCAT('Rp', FORMAT(harga_jual_barang, 0, 'id_ID')) AS harga
FROM barang
ORDER BY nama_barang ASC;


-- ----------------------------------------------------------
-- E.2 MEMAHAMI KESALAHAN LOGIKA AND DAN OR
-- ----------------------------------------------------------


-- ----------------------------------------------------------
-- E.2a KUERI YANG SENGAJA SALAH SECARA LOGIKA
--
-- Pertanyaan:
-- Bagaimana hasil kueri jika kondisi kategori ATK atau
-- Minuman digabungkan dengan harga lebih dari 3000
-- tanpa menggunakan tanda kurung?
--
-- Hasil yang diharapkan:
-- Kueri tetap dapat dijalankan, tetapi hasilnya tidak
-- sesuai dengan maksud penyaringan.
-- ----------------------------------------------------------

SELECT
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
FROM barang
WHERE kategori_barang = 'ATK'
   OR kategori_barang = 'Minuman'
   AND harga_jual_barang > 3000;


-- ----------------------------------------------------------
-- E.2b PERBAIKAN KUERI
--
-- Pertanyaan:
-- Bagaimana memperbaiki kueri sebelumnya agar hanya
-- menampilkan barang kategori ATK atau Minuman yang
-- memiliki harga jual lebih dari 3000?
--
-- Hasil yang diharapkan:
-- Hanya barang dari kategori ATK atau Minuman yang
-- memiliki harga jual lebih dari 3000 yang ditampilkan.
-- ----------------------------------------------------------

SELECT
    kode_barang,
    nama_barang,
    kategori_barang,
    harga_jual_barang
FROM barang
WHERE (kategori_barang = 'ATK'
   OR kategori_barang = 'Minuman')
   AND harga_jual_barang > 3000;


-- ----------------------------------------------------------
-- TITIK ANALISIS E.2
--
-- Penjelasan:
-- Pada kueri E.2a, operator AND diproses lebih dahulu
-- daripada OR sehingga menghasilkan data yang tidak
-- sesuai dengan tujuan penyaringan.
--
-- Pada kueri E.2b, tanda kurung digunakan untuk
-- mengelompokkan kondisi kategori barang terlebih dahulu.
-- Selanjutnya, kondisi harga lebih dari 3000 diterapkan
-- pada kedua kategori tersebut.
-- ----------------------------------------------------------