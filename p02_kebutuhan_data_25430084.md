# Dokumen Kebutuhan Data: Rumah Inovasi Siswa Aktif (RISA)

## IDENTITAS PROYEK
* **NAMA**: Richo sayu rahmadhani
* **NPM**: 25430084
* **KELAS**: C
* **Tema Proyek**: Akademik
* **Nama Organisasi**: Rumah Inovasi Siswa Aktif (RISA)
* **Lingkup Layanan**: Organisasi ini bergerak di bidang pengelolaan kegiatan ekstrakurikuler, pembinaan kelompok belajar siswa, serta penyelenggaraan kompetisi akademik dan sains antar kelas di lingkungan sekolah.
* **Parameter P**: 46 *(Perhitungan: $P = 40 + (84 \bmod 7) = 46$)*

---

## 1. Latar Belakang dan Aktivitas Organisasi
**Rumah Inovasi Siswa Aktif (RISA)** adalah organisasi di lingkungan sekolah yang mengelola tiga pilar utama aktivitas siswa:
1. **Kegiatan Ekstrakurikuler**: Pendaftaran anggota, penjadwalan latihan, dan pencatatan presensi siswa.
2. **Kelompok Belajar Siswa**: Pembentukan kelompok bimbingan sains/akademik dan alokasi mentor/tutor.
3. **Kompetisi Akademik & Sains**: Penyelenggaraan lomba antar kelas, pendaftaran tim/peserta, dan pencatatan rekapitulasi skor/juara.

Pengembangan sistem basis data terpusat ini bertujuan untuk menggantikan pencatatan manual guna menghindari bentrok jadwal latihan, duplikasi pendaftaran anggota, serta memastikan rekapitulasi prestasi akademik siswa tercatat dengan akurat dan akuntabel.

---

## 2. Aktor dan Proses Bisnis (PB)

| Kode PB | Nama Proses Bisnis | Aktor Utama | Pemicu (*Trigger*) | Deskripsi Singkat |
| :--- | :--- | :--- | :--- | :--- |
| **PB-01** | Pendaftaran Anggota Ekstrakurikuler | Siswa / Pengurus RISA | Pembukaan pendaftaran ekstrakurikuler baru | Mencatat partisipasi siswa dalam kegiatan ekstrakurikuler sekolah. |
| **PB-02** | Pembentukan Kelompok Belajar | Pembina / Pengurus RISA | Awal semester atau persiapan ujian | Mengelompokkan siswa dan menunjuk mentor/pembina kelompok belajar. |
| **PB-03** | Penyelenggaraan Kompetisi Sains | Panitia Kompetisi | Agenda tahunan kompetisi antar kelas | Mengelola pendaftaran tim lomba, cabang kompetisi, dan jadwal tanding. |
| **PB-04** | Pencatatan Presensi & Kegiatan | Pembina / Ekstrakurikuler | Jadwal rutinitas latihan/bimbingan | Mencatat kehadiran siswa dalam kegiatan ekstrakurikuler dan kelompok belajar. |
| **PB-05** | Input Hasil & Rekapitulasi Skor | Juri / Panitia Lomba | Selesainya babak kompetisi sains | Memasukkan nilai/skor perlombaan dan menentukan penentuan juara antar kelas. |
| **PB-06** | Penyusunan Laporan Prestasi Siswa | Pembina RISA / Kepala Sekolah | Akhir semester / evaluasi berkala | Mencetak rekapitulasi keikutsertaan dan prestasi akademik/sains siswa. |

---

## 3. Dokumen Sumber Fiktif dan Pembedahannya

### Rancangan Dokumen Sumber: Formulir Pendaftaran & Hasil Kompetisi Sains (RISA)
```text
=================================================================================
             RUMAH INOVASI SISWA AKTIF (RISA) - FORMULIR KOMPETISI
=================================================================================
No. Pendaftaran : KMP-2026-0084                  Tanggal : 10 Oktober 2026
Nama Kompetisi  : Olimpiade Sains Antar Kelas    Cabang  : Matematika & IPA
Nama Tim / Siswa: Richo Sayu Rahmadhani          Kelas   : X-C
NPM / NIS       : 25430084                       Guru Pembina: Dr. Ahmad, M.Pd.
---------------------------------------------------------------------------------
No | Kode Pembina | Nama Anggota Tim     | Peran     | Skor Akhir | Peringkat
---------------------------------------------------------------------------------
1  | PB-01        | Richo Sayu R.        | Ketua     | 88.5       | Juara 1
2  | PB-01        | Ahmad Subagyo        | Anggota   | 88.5       | Juara 1
---------------------------------------------------------------------------------
Status Kelulusan : LULUS SELEKSI / MENANG
=================================================================================
### Hasil Pembedahan Elemen Data Dokumen Sumber:
1. **Atribut Identitas Transaksi**: `no_pendaftaran`, `tgl_pendaftaran`, `nama_kompetisi`
2. **Atribut Peserta & Relasi**: `npm_siswa`, `kelas_siswa`, `guru_pembina`
3. **Atribut Lomba & Rincian**: `kode_cabang`, `nama_cabang`, `skor_akhir`, `peringkat`
4. **Atribut Turunan (*Calculated Attribute*)**: `total_skor_tim` (Merupakan hasil akumulasi penjumlahan skor individual anggota tim, dihitung secara otomatis oleh sistem).

---

 ##  4. Entitas Kandidat dan Elemen Data (6 Entitas)

1. **Siswa**: `npm_siswa`, `nama_siswa`, `kelas_siswa`, `no_hp_siswa`, `status_aktif`
2. **Pembina/Guru**: `nip_pembina`, `nama_pembina`, `email_pembina`, `telepon_pembina`, `bidang_keahlian`
3. **Ekstrakurikuler**: `kode_ekskul`, `nama_ekskul`, `hari_latihan`, `jam_latihan`, `nip_pembina`
4. **Kelompok Belajar**: `id_kelompok`, `nama_kelompok`, `fokus_mata_pelajaran`, `nip_pembina`
5. **Kompetisi Sains**: `kode_kompetisi`, `nama_kompetisi`, `tingkat_kompetisi`, `tgl_pelaksanaan`
6. **Pendaftaran & Hasil**: `no_pendaftaran`, `npm_siswa`, `kode_kompetisi`, `id_kelompok`, `skor_akhir`, `peringkat_juara`

---

## 5. Aturan Bisnis (AB)

* **AB-01**: **Identifikasi Unik Siswa** — Setiap siswa diidentifikasi secara unik menggunakan `npm_siswa` sebagai *Primary Key*.
* **AB-02**: **Pendampingan Pembina** — Setiap kegiatan ekstrakurikuler dan kelompok belajar wajib dibimbing oleh minimal satu `nip_pembina`.
* **AB-03**: **Batas Maksimum Keikutsertaan** — Siswa diperbolehkan mengikuti **maksimal 3 kegiatan** (ekstrakurikuler/kelompok belajar) secara bersamaan.
* **AB-04**: **Batas Kapasitas Kelompok Belajar** — Total kapasitas peserta dalam satu kelompok belajar dibatasi maksimum **$P - 20 = 46 - 20 = 26$ siswa/kelompok** (berdasarkan parameter $P = 46$).
* **AB-05**: **Syarat Pendaftaran Kompetisi** — Pendaftaran kompetisi sains antar kelas hanya dibuka untuk siswa yang terdaftar dalam kelompok belajar aktif RISA.
* **AB-06**: **Otorisasi Input Skor Lomba** — Penginputan `skor_akhir` dan penentuan `peringkat_juara` perlombaan hanya dapat dilakukan oleh **Panitia/Juri** yang terdaftar.
* **AB-07**: **Syarat Kehadiran Minimal** — Siswa yang memiliki persentase presensi latihan di bawah **75%** tidak diizinkan mewakili sekolah dalam kompetisi sains luar.
* **AB-08**: **Pencegahan Bentrok Jadwal** — Jadwal kegiatan ekstrakurikuler dan kelompok belajar untuk siswa yang sama tidak boleh mengalami bentrok waktu (`hari_latihan` dan `jam_latihan`).
* **AB-09**: **Batas Waktu Revisi Lomba** — Pembatalan atau perubahan pendaftaran kompetisi sains hanya dapat dilakukan **maksimal 3 hari** sebelum `tgl_pelaksanaan` lomba.

---

## 6. Kebutuhan Informasi (KI)

1. **KI-01**: **Rekapitulasi Siswa Aktif** — Menampilkan rekapitulasi jumlah siswa aktif yang mengikuti kegiatan ekstrakurikuler dan kelompok belajar berdasarkan kelas.
2. **KI-02**: **Laporan Presensi Latihan** — Menampilkan lembar daftar hadir presensi siswa dalam kegiatan latihan ekstrakurikuler dan bimbingan kelompok belajar.
3. **KI-03**: **Rekapitulasi Juara Kompetisi** — Menampilkan perolehan medali dan peringkat juara kompetisi sains antar kelas secara periodik.
4. **KI-04**: **Laporan Keaktifan Pembina** — Menampilkan rekapitulasi kinerja dan tingkat keaktifan mentor/pembina kelompok belajar RISA.
5. **KI-05**: **Daftar Siswa Berprestasi** — Menampilkan daftar peringkat siswa berprestasi berdasarkan akumulasi skor kelompok belajar dan hasil perlombaan.

---

## 7. Matriks CRUD

| Kode PB | Nama Proses Bisnis | Siswa | Pembina | Ekstrakurikuler | Kelompok Belajar | Kompetisi Sains | Pendaftaran & Hasil |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01** | **Pendaftaran Ekstrakurikuler** | R | R | R | - | - | **C, U** |
| **PB-02** | **Pembentukan Kelompok Belajar** | R | R | - | **C, U** | - | - |
| **PB-03** | **Penyelenggaraan Kompetisi Sains**| R | R | - | R | **C, U** | - |
| **PB-04** | **Pencatatan Presensi & Kegiatan** | R | R | R | R | - | **U** |
| **PB-05** | **Input Hasil & Rekapitulasi Skor** | - | R | - | - | R | **C, U, D** |
| **PB-06** | **Laporan Prestasi Siswa** | R | R | R | R | R | R |

*(Keterangan: C = Create, R = Read, U = Update, D = Delete. Matriks ini lengkap dan tidak terdapat entitas terisolasi).*

---

## 8. Kamus Data Awal (25 Elemen Data)

| No | Nama Elemen Data | Tipe Data & Panjang | Keterangan / Deskripsi | Penanggung Jawab (*Data Steward*) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `npm_siswa` | **VARCHAR(10)** | **Nomor pokok siswa/NPM unik** | **Pengurus RISA / Admin** |
| 2 | `nama_siswa` | **VARCHAR(100)** | **Nama lengkap siswa** | **Pengurus RISA / Admin** |
| 3 | `kelas_siswa` | **VARCHAR(10)** | **Kelas tempat siswa belajar** | **Pengurus RISA / Admin** |
| 4 | `no_hp_siswa` | **VARCHAR(15)** | **Nomor kontak HP/WhatsApp** | **Siswa Bersangkutan** |
| 5 | `status_aktif` | **VARCHAR(15)** | **Status keaktifan siswa** | **Pengurus RISA** |
| 6 | `nip_pembina` | **VARCHAR(18)** | **Nomor Induk Pegawai/Pembina** | **Pembina RISA** |
| 7 | `nama_pembina` | **VARCHAR(100)** | **Nama lengkap guru/pembina** | **Pembina RISA** |
| 8 | `email_pembina` | **VARCHAR(50)** | **Alamat email resmi pembina** | **Pembina RISA** |
| 9 | `telepon_pembina` | **VARCHAR(15)** | **Nomor telepon pembina** | **Pembina RISA** |
| 10 | `bidang_keahlian` | **VARCHAR(50)** | **Keahlian pembina (Sains/Seni)** | **Pembina RISA** |
| 11 | `kode_ekskul` | **VARCHAR(10)** | **Kode unik ekstrakurikuler** | **Pengurus RISA** |
| 12 | `nama_ekskul` | **VARCHAR(50)** | **Nama kegiatan ekstrakurikuler** | **Pengurus RISA** |
| 13 | `hari_latihan` | **VARCHAR(10)** | **Hari rutin kegiatan latihan** | **Pengurus RISA** |
| 14 | `jam_latihan` | **VARCHAR(20)** | **Waktu pelaksanaan latihan** | **Pengurus RISA** |
| 15 | `id_kelompok` | **INT (Auto)** | **Identifier unik kelompok belajar** | **Pembina RISA** |
| 16 | `nama_kelompok` | **VARCHAR(50)** | **Nama kelompok belajar sains** | **Pembina RISA** |
| 17 | `fokus_mata_pelajaran`| **VARCHAR(50)** | **Fokus pelajaran (Fisika/IPA)**| **Pembina RISA** |
| 18 | `kode_kompetisi` | **VARCHAR(10)** | **Kode unik perlombaan sains** | **Panitia Lomba** |
| 19 | `nama_kompetisi` | **VARCHAR(100)** | **Nama ajang kompetisi** | **Panitia Lomba** |
| 20 | `tingkat_kompetisi`| **VARCHAR(20)** | **Tingkat lomba (Sekolah/Kota)** | **Panitia Lomba** |
| 21 | `tgl_pelaksanaan` | **DATE** | **Tanggal lomba digelar** | **Panitia Lomba** |
| 22 | `no_pendaftaran` | **VARCHAR(20)** | **Nomor pendaftaran lomba** | **Panitia Lomba** |
| 23 | `tgl_pendaftaran` | **DATE** | **Tanggal pendaftaran diterima** | **Panitia Lomba** |
| 24 | `skor_akhir` | **DECIMAL(5,2)**| **Skor akumulasi hasil lomba** | **Juri / Panitia Lomba** |
| 25 | `peringkat_juara` | **VARCHAR(20)** | **Peringkat (Juara 1, Juara 2)** | **Juri / Panitia Lomba** |

---

## 9. Kebutuhan Non-Fungsional Data

* **Volume Transaksi Harian**: Perkiraan puncak pendaftaran harian dihitung berdasarkan parameter $P$:
  $$\text{Volume Transaksi} = 40 + (5 \times P) = 40 + (5 \times 46) = 270 \text{ pendaftaran/hari}$$
* **Retensi & Arsip Data**: Data rekapitulasi disimpan selama siswa masih bersekolah ditambah **3 tahun setelah kelulusan**.
* **Keamanan & Privasi Data**:
  * **Data Sensitif/Pribadi**: Atribut seperti `no_hp_siswa`, `telepon_pembina`, dan `email_pembina` dikategorikan privat.
  * **Hak Akses**: **Siswa** (Read/Update profil pribadi), **Pembina** (Kelola kelompok & input nilai), **Admin RISA** (Full Access).
* **Ketersediaan Sistem**: Sistem siap diakses **24 jam penuh** terutama saat periode pendaftaran kompetisi dibuka.

---

## 10. Isu Kualitas Data yang Diantisipasi

* **Risiko Duplikasi Pendaftaran**: Adanya risiko siswa mendaftar di dua kelompok belajar dengan jam latihan yang bersamaan.
* **Strategi Mitigasi**: Penerapan konstrain *Unique Key* gabungan antara `npm_siswa`, `hari_latihan`, dan `jam_latihan`.

---

## 11. Sinkronisasi Kompetensi (Evaluasi Diri Modul 2)

| Indikator Capaian Modul 2 | Status Pencapaian | Pembuktian dalam Dokumen |
| :--- | :---: | :--- |
| **Identifikasi Aktor & Proses Bisnis** | **Selesai** | Teridentifikasi Aktor & 6 Proses Bisnis spesifik RISA (Bagian 2). |
| **Analisis Dokumen Sumber** | **Selesai** | Membedah Formulir Kompetisi RISA menjadi 4 kelompok data (Bagian 3). |
| **Penentuan Entitas Kandidat** | **Selesai** | Membentuk 6 Entitas Kandidat RISA (Bagian 4). |
| **Perumusan Aturan Bisnis Terukur** | **Selesai** | Merumuskan 9 Aturan Bisnis terukur dengan parameter $P = 46$ (Bagian 5). |
| **Penyusunan Matriks CRUD** | **Selesai** | Menyusun Matriks CRUD tanpa entitas terisolasi (Bagian 7). |
| **Penyusunan Kamus Data Awal** | **Selesai** | Terdaftar 25 elemen data beserta *Data Steward* (Bagian 8). |
| **Pemetaan Non-Fungsional & Privasi** | **Selesai** | Perhitungan $\pm 270$ transaksi dan batasan privasi data (Bagian 9). |