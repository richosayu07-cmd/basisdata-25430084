# ANALISIS HASIL KUERI MODUL 7 BAGIAN F

## 1. Analisis Hasil Kueri

### Kueri 1 – KI-01: Rekapitulasi Mahasiswa Aktif

Kueri digunakan untuk menampilkan mahasiswa yang memiliki status aktif. Hasil menunjukkan terdapat 25 mahasiswa berstatus aktif. Kueri ini mendukung KI-01, tetapi belum menampilkan informasi kelas yang diikuti mahasiswa.

### Kueri 2 – KI-02: Laporan Pengisian KRS

Kueri digunakan untuk menampilkan nomor KRS, semester, tahun ajaran, tanggal pengisian, dan status persetujuan. Hasil menampilkan data pengisian KRS mahasiswa.

### Kueri 3 – KI-03: Informasi Mata Kuliah dan Kelas

Kueri digunakan untuk menampilkan daftar kelas berdasarkan kode kelas, ID mata kuliah, ID ruangan, semester, tahun ajaran, dan kapasitas maksimal. Hasil menunjukkan terdapat 6 data kelas. Nama mata kuliah dan nama ruangan memerlukan penggabungan tabel.

### Kueri 4 – KI-04: Laporan Dosen Pengampu

Kueri digunakan untuk menampilkan ID kelas, ID dosen, dan peran dosen pengampu. Hasil menunjukkan terdapat 6 data penugasan dosen pengampu.

### Kueri 5 – KI-05: Rekapitulasi Nilai Mahasiswa

Kueri digunakan untuk menampilkan ID KRS, ID kelas, dan nilai huruf mahasiswa. Hasil menunjukkan bahwa nilai huruf masih bernilai `NULL`, artinya belum ada nilai huruf yang diisikan.

### Kueri 6 – KI-02: Pengelompokan Status KRS Menggunakan IN

Kueri digunakan untuk mencari data KRS yang memiliki status menunggu atau disetujui.

### Kueri 7 – KI-02: Pengelompokan Status Menggunakan CASE

Kueri digunakan untuk mengelompokkan status persetujuan KRS. Hasil menunjukkan terdapat 3 KRS berstatus disetujui dan 22 KRS berstatus menunggu.

### Kueri 8 – KI-02: Tahun Pengisian KRS Menggunakan YEAR()

Kueri digunakan untuk mengambil tahun dari tanggal pengisian KRS. Hasil menunjukkan seluruh data KRS memiliki tahun pengisian 2026.

### Kueri 9 – KI-04: Nama Dosen Menggunakan UPPER()

Kueri digunakan untuk mengubah nama dosen menjadi huruf kapital. Hasil menunjukkan terdapat 5 nama dosen.

### Kueri 10 – KI-02: Rentang Tanggal Menggunakan BETWEEN

Kueri digunakan untuk menampilkan KRS yang diisi pada rentang tanggal 1 sampai 31 Agustus 2026. Hasil menunjukkan terdapat 25 data KRS.

### Kueri 11 – KI-04: Pemeriksaan Email Menggunakan IS NULL

Kueri digunakan untuk memeriksa apakah terdapat dosen yang belum memiliki email. Hasil tidak menampilkan baris data, sehingga tidak ditemukan email dosen yang bernilai `NULL`.

### Kueri 12 – KI-04: Pencarian Nama Dosen Menggunakan LIKE

Kueri digunakan untuk mencari dosen yang namanya mengandung kata Rahma. Hasil menemukan satu dosen, yaitu Siti Rahmawati.

---

## 2. Analisis Fungsi dan Operator SQL

1. **LIKE** digunakan untuk mencari data berdasarkan pola teks tertentu.
2. **BETWEEN** digunakan untuk mencari data dalam rentang nilai atau tanggal tertentu.
3. **IN** digunakan untuk mencari data berdasarkan beberapa pilihan nilai.
4. **IS NULL** digunakan untuk memeriksa kolom yang tidak memiliki nilai.
5. **CASE** digunakan untuk membuat kategori berdasarkan kondisi tertentu.
6. **YEAR()** digunakan untuk mengambil tahun dari sebuah tanggal.
7. **UPPER()** digunakan untuk mengubah teks menjadi huruf kapital.

---

## 3. Pemetaan Kueri terhadap Kebutuhan Informasi (KI)

| Kebutuhan Informasi | Kueri Pendukung | Keterangan |
|---|---|---|
| KI-01 Rekapitulasi Mahasiswa Aktif | 1 | Menampilkan mahasiswa aktif, tetapi informasi kelas memerlukan JOIN. |
| KI-02 Laporan Pengisian KRS | 2, 6, 7, 8, 10 | Menampilkan informasi pengisian, status, dan tanggal KRS. |
| KI-03 Informasi Mata Kuliah dan Kelas | 3 | Menampilkan informasi dasar kelas, sedangkan nama mata kuliah dan ruangan memerlukan JOIN. |
| KI-04 Laporan Dosen Pengampu | 4, 9, 11, 12 | Menampilkan penugasan dan informasi dosen, tetapi laporan lengkap memerlukan JOIN. |
| KI-05 Rekapitulasi Nilai Mahasiswa | 5 | Menampilkan data nilai huruf, tetapi informasi lengkap memerlukan JOIN. |

---

## 4. Kebutuhan Informasi yang Memerlukan Penggabungan Tabel

1. **KI-01:** Memerlukan penggabungan tabel `mahasiswa`, `krs`, `detail_krs`, dan `kelas`.
2. **KI-02:** Memerlukan penggabungan tabel `krs` dan `mahasiswa` apabila laporan harus menampilkan identitas mahasiswa.
3. **KI-03:** Memerlukan penggabungan tabel `kelas`, `mata_kuliah`, dan `ruangan`.
4. **KI-04:** Memerlukan penggabungan tabel `dosen_pengampu`, `dosen`, dan `kelas`.
5. **KI-05:** Memerlukan penggabungan tabel `detail_krs`, `krs`, `mahasiswa`, `kelas`, dan `mata_kuliah`.

---

## 5. Kesimpulan

Berdasarkan pelaksanaan Modul 7 bagian F, telah dibuat dan dijalankan sebanyak 12 kueri SQL menggunakan satu tabel. Kueri tersebut telah menerapkan operator `LIKE`, `BETWEEN`, `IN`, `IS NULL`, `CASE`, serta fungsi tanggal `YEAR()` dan fungsi string `UPPER()`.

Hasil kueri menunjukkan bahwa database Sistem Informasi Akademik dapat digunakan untuk mendukung kebutuhan informasi yang telah ditentukan. Namun, beberapa kebutuhan informasi masih memerlukan penggabungan beberapa tabel menggunakan `JOIN` agar hasilnya lebih lengkap. Pengembangan tersebut akan dilanjutkan pada pertemuan berikutnya.