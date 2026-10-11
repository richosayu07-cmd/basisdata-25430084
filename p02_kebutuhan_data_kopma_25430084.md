# Dokumen Kebutuhan Data: Sistem Informasi Akademik (Akad)
**NIM:** 25430084  
**Nama:** Richo Sayu Rahmadani  
**Kelas:** C  

## 1. Latar Belakang dan Aktivitas Organisasi
Sistem Informasi Akademik dikembangkan untuk mengelola proses pencatatan data mahasiswa, mata kuliah, kelas perkuliahan, pengisian Kartu Rencana Studi (KRS), serta penilaian hasil studi secara terkomputerisasi. Organisasi fiktif ini bertujuan untuk menggantikan pencatatan konvensional guna menghindari kesalahan duplikasi data, memastikan keakuratan riwayat akademik, dan mempercepat pelayanan administrasi kampus.

---

## 2. Aktor dan Proses Bisnis (Minimal 4 Proses)
| Kode | Proses Bisnis | Aktor Terlibat | Pemicu Kegiatan |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mendaftarkan Mahasiswa Baru | Bagian Akademik (Admin) | Calon mahasiswa melakukan pendaftaran masuk kuliah |
| **PB-02** | Pengelolaan Mata Kuliah & Kurikulum | Bagian Akademik (Admin) | Menjelang penyusunan kurikulum atau semester baru |
| **PB-03** | Pengisian Kartu Rencana Studi (KRS) | Mahasiswa | Memasuki awal periode pengisian KRS semester baru |
| **PB-04** | Pencatatan dan Input Nilai Ujian | Dosen Pengampu | Berakhirnya masa perkuliahan atau ujian akhir semester |
| **PB-05** | Penyusunan Laporan Transkrip / Studi | Ketua / Pimpinan Prodi | Kebutuhan evaluasi akademik dan kelulusan mahasiswa |

---

## 3. Dokumen Sumber Fiktif dan Pembedahannya
### Dokumen Sumber: Formulir Rencana Studi (KRS) Fiktif
* **Nomor Dokumen**: KRS-20261-0084
* **Tanggal**: 10 Februari 2026
* **Identitas Mahasiswa**: NIM: 25430084, Nama: Richo Sayu Rahmadani, Prodi: Teknik Informatika
* **Daftar Mata Kuliah yang Diambil**:
  1. IF-301 | Basis Data II | 3 SKS | Kelas A
  2. IF-302 | Jaringan Komputer | 3 SKS | Kelas B
  3. IF-303 | Pemrograman Web | 4 SKS | Kelas A
* **Total SKS**: 10 SKS
* **Persetujuan**: Disetujui oleh Dosen Wali (Dr. Ahmad, M.Kom.)

### Hasil Pembedahan Elemen Data dari Dokumen Sumber:
1. **Identitas Dokumen**: `no_krs`, `tgl_krs`
2. **Relasi Akademik**: `nim_mahasiswa`, `nidn_dosen_wali`
3. **Detail Pilihan**: `kode_matkul`, `nama_matkul`, `sks_matkul`, `nama_kelas`
4. **Atribut Turunan (Dihitung)**: `total_sks_diambil` (dihitung dari penjumlahan SKS, tidak disimpan permanen untuk menjaga konsistensi).

---

## 4. Entitas Kandidat dan Elemen Data (Minimal 6 Entitas)
1. **Mahasiswa**: `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `angkatan_mahasiswa`, `no_hp_mahasiswa`, `status_mahasiswa`
2. **Dosen**: `nidn_dosen`, `nama_dosen`, `email_dosen`, `telepon_dosen`
3. **Mata Kuliah**: `kode_matkul`, `nama_matkul`, `sks_matkul`, `semester_kurikulum`
4. **Kelas Perkuliahan**: `id_kelas`, `kode_matkul`, `nidn_dosen`, `hari_kuliah`, `jam_kuliah`, `ruang_kuliah`, `kapasitas_maksimal`
5. **KRS (Kartu Rencana Studi)**: `no_krs`, `nim_mahasiswa`, `tgl_krs`, `status_persetujuan`
6. **Detail KRS**: `no_krs`, `id_kelas`, `nilai_huruf`, `nilai_angka`

---

## 5. Aturan Bisnis (Minimal 8 Aturan)
* **AB-01**: Setiap mahasiswa wajib memiliki `nim_mahasiswa` yang bersifat unik dan tidak boleh sama.
* **AB-02**: Setiap mata kuliah wajib memiliki `kode_matkul` yang unik dan bobot SKS minimal 1.
* **AB-03**: Pengisian KRS (`no_krs`) harus terikat pada satu mahasiswa aktif dan disetujui oleh dosen wali.
* **AB-04**: Total SKS yang diambil oleh mahasiswa dalam satu semester dibatasi maksimum **$P + 2 = 48$ SKS kumulatif/tahunan** (berdasarkan parameter $P = 46$).
* **AB-05**: Kapasitas peserta di dalam satu kelas (`kapasitas_maksimal`) tidak boleh melebihi daya tampung fisik ruangan kuliah.
* **AB-06**: Nilai akhir mahasiswa (`nilai_huruf`) hanya dapat diinput atau diubah oleh Dosen Pengampu mata kuliah terkait sebelum batas waktu penutupan nilai.
* **AB-07**: Status keaktifan mahasiswa (`status_mahasiswa`) menentukan hak akses dalam melakukan pengisian KRS secara online.
* **AB-08**: Setiap kelas perkuliahan wajib diasuh oleh minimal satu dosen pengampu yang terdaftar di sistem.

---

## 6. Kebutuhan Informasi (Minimal 5 Laporan/Output)
* **KI-01**: Rekapitulasi jumlah mahasiswa aktif per program studi dan per angkatan.
* **KI-02**: Daftar peserta kelas (presensi) untuk setiap mata kuliah yang diselenggarakan pada semester berjalan.
* **KI-03**: Transkrip nilai sementara dan perhitungan Indeks Prestasi Semester (IPS) / Indeks Prestasi Kumulatif (IPK).
* **KI-04**: Laporan daftar mata kuliah dengan peminat terbanyak pada setiap awal pembukaan KRS.
* **KI-05**: Laporan rekapitulasi pengisian KRS mahasiswa yang belum divalidasi oleh dosen wali.

---

## 7. Matriks CRUD
| Proses Bisnis | Mahasiswa | Dosen | Mata Kuliah | Kelas Perkuliahan | KRS | Detail KRS |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 Daftar Mahasiswa Baru** | C | R | R | | | |
| **PB-02 Kelola Kurikulum/Matkul** | | R | C, U | | | |
| **PB-03 Pengisian KRS** | R | R | R | R, U | C | C |
| **PB-04 Input Nilai Ujian** | | R | R | R | R | U |
| **PB-05 Laporan Studi / Transkrip** | R | R | R | R | R | R |

*(Keterangan: C = Create, R = Read, U = Update, D = Delete. Tidak ada entitas mati karena seluruh tabel ter-create/diakses melalui proses bisnis di atas).*

---

## 8. Kamus Data Awal (Minimal 20 Elemen dengan Penanggung Jawab)
| No | Nama Elemen Data | Tipe Data & Panjang | Arti / Deskripsi | Penanggung Jawab (Data Steward) |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `nim_mahasiswa` | VARCHAR(10) | Nomor Induk Mahasiswa yang bersifat unik | Bagian Akademik |
| 2 | `nama_mahasiswa` | VARCHAR(100) | Nama lengkap mahasiswa sesuai ijazah | Bagian Akademik |
| 3 | `prodi_mahasiswa` | VARCHAR(50) | Program studi tempat mahasiswa terdaftar | Bagian Akademik |
| 4 | `angkatan_mahasiswa`| CHAR(4) | Tahun masuk atau angkatan mahasiswa | Bagian Akademik |
| 5 | `no_hp_mahasiswa` | VARCHAR(15) | Nomor telepon/WhatsApp aktif mahasiswa | Mahasiswa / Pemilik |
| 6 | `status_mahasiswa` | VARCHAR(20) | Status keaktifan (Aktif, Cuti, Keluar) | Bagian Akademik |
| 7 | `nidn_dosen` | VARCHAR(15) | Nomor Induk Dosen Nasional yang unik | Bagian Kepegawaian |
| 8 | `nama_dosen` | VARCHAR(100) | Nama lengkap dosen beserta gelar | Bagian Kepegawaian |
| 9 | `email_dosen` | VARCHAR(50) | Alamat email resmi kedinasan dosen | Bagian Kepegawaian |
| 10 | `telepon_dosen` | VARCHAR(15) | Nomor kontak telepon/HP dosen | Dosen Bersangkutan |
| 11 | `kode_matkul` | VARCHAR(10) | Kode unik mata kuliah kurikulum | Tim Kurikulum Prodi |
| 12 | `nama_matkul` | VARCHAR(100) | Nama resmi mata kuliah | Tim Kurikulum Prodi |
| 13 | `sks_matkul` | INT | Bobot Satuan Kredit Semester (SKS) | Tim Kurikulum Prodi |
| 14 | `semester_kurikulum`| INT | Anjuran semester pengambilan matkul | Tim Kurikulum Prodi |
| 15 | `id_kelas` | INT (Auto) | Nomor pengenal unik kelas perkuliahan | Bagian Akademik / IT |
| 16 | `hari_kuliah` | VARCHAR(10) | Hari penyelenggaraan kelas (Senin-Sabtu) | Bagian Akademik |
| 17 | `jam_kuliah` | VARCHAR(20) | Waktu mulai dan selesai perkuliahan | Bagian Akademik |
| 18 | `ruang_kuliah` | VARCHAR(20) | Kode atau nama ruangan kelas | Bagian Sarana Prasarana |
| 19 | `kapasitas_maksimal`| INT | Batas maksimal jumlah mahasiswa di kelas | Bagian Sarana Prasarana |
| 20 | `no_krs` | VARCHAR(20) | Nomor unik dokumen Kartu Rencana Studi | Mahasiswa / Sistem |
| 21 | `tgl_krs` | DATE | Tanggal pengesahan atau pengisian KRS | Sistem Akademik |
| 22 | `status_persetujuan`| VARCHAR(20) | Status validasi KRS (Pending/Disetujui) | Dosen Wali |
| 23 | `nilai_huruf` | CHAR(2) | Huruf mutu hasil ujian (A, B, C, D, E) | Dosen Pengampu |
| 24 | `nilai_angka` | DECIMAL(3,2)| Bobot angka mutu nilai (4.00, 3.00, dll) | Dosen Pengampu |

---

## 9. Kebutuhan Non-Fungsional Data
* **Volume & Skala**: Perkiraan volume transaksi pendaftaran KRS harian pada awal semester mencapai $\pm 270$ aktivitas simultan (berdasarkan perhitungan parameter $P = 46$, di mana $40 + (5 \times 46) = 270$).
* **Retensi Data**: Seluruh data transaksional akademik (KRS dan nilai) wajib disimpan sekurang-kurangnya selama masa studi aktif mahasiswa ditambah 5 tahun masa kelulusan.
* **Keamanan & Identifikasi Data Pribadi**: 
  * Data pribadi seperti `no_hp_mahasiswa`, `email_dosen`, dan riwayat nilai dikategorikan sebagai informasi privat.
  * **Hak Akses**: Mahasiswa hanya dapat melihat data pribadi dan nilai miliknya sendiri; Dosen Wali hanya dapat mengakses data mahasiswa bimbingannya; sedangkan Bagian Akademik memiliki akses penuh untuk pengelolaan data induk.
* **Ketersediaan**: Sistem dirancang dengan ketersediaan tinggi (*high availability*) terutama pada masa periode pengisian KRS agar tidak terjadi kegagalan transaksi data.

---

## 10. Isu Kualitas Data yang Diantisipasi
* **Inkonsistensi Penulisan**: Potensi perbedaan penulisan nama program studi atau mata kuliah antar formulir pendaftaran fisik dan digital yang diatasi dengan penerapan validasi pilihan tetap (*dropdown*).
* **Kesalahan Input NIM/Kode**: Risiko salah ketik nomor induk yang dapat menyebabkan relasi data terputus, dicegah dengan penerapan konstrain *Primary Key* dan *Foreign Key* yang ketat pada perancangan basis data tahap berikutnya.