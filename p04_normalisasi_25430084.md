## F. Tugas Mandiri: Milestone Proyek 4 (Sistem Informasi Akademik / KRS & Transkrip)

Pada milestone proyek ke-4 ini, proses normalisasi diterapkan secara menyeluruh pada dokumen sumber **Kartu Rencana Studi (KRS) dan Transkrip Akademik** untuk membangun skema basis data akademik yang bebas dari redundansi dan anomali manipulasi data (ubah, sisip, hapus).

---

### 1. Dokumen Sumber & Bentuk Tidak Ternormalisasi (UNF)

Dokumen sumber yang digunakan adalah **Lembar Kartu Rencana Studi (KRS)** mahasiswa. Satu lembar KRS memuat identitas mahasiswa, dosen pembimbing akademik (PA), serta daftar mata kuliah yang diambil beserta nilai akhirnya.

* **Bentuk Relasi UNF:**  
  `KRS_UNF` (`no_krs`, `tgl_krs`, `thn_akademik`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_dosen_pa`, `nama_dosen_pa`, `{ kode_mk, nama_mk, sks, kelas, semester_mk, nilai_angka, nilai_huruf, bobot_nilai }`, `total_sks`, `ips`)

* **Ilustrasi Wujud Tabel Data UNF:**
  | no_krs | tgl_krs | thn_akademik | nim_mahasiswa | nama_mahasiswa | prodi_mahasiswa | kode_dosen_pa | nama_dosen_pa | { kode_mk, nama_mk, sks, kelas, semester_mk, nilai_angka, nilai_huruf, bobot_nilai } | total_sks | ips |
  | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
  | KRS-20261-001 | 2026-02-01 | 2025/2026 Ganjil | 25430084 | Richo Sayu Rahmadani | Ilmu Komputer | D001 | Dr. Ahmad, M.Kom. | INF101, Basis Data, 3, A, 3, 85, A, 4.00 <br> INF102, Pemrograman Web, 3, C, 3, 78, B+, 3.50 | 6 | 3.75 |

---

### 2. Aturan Bisnis (AB) & Menuliskan Dependensi Fungsional (FD)

Berdasarkan domain akademik, rumusan Aturan Bisnis (AB) dan Dependensi Fungsional (FD) ditentukan sebagai berikut:

* **Kode AB-01 (Header KRS):** Satu nomor KRS diterbitkan untuk satu mahasiswa pada tanggal dan tahun akademik tertentu.
  * **FD1:** `no_krs -> tgl_krs, thn_akademik, nim_mahasiswa`
* **Kode AB-02 (Master Mahasiswa):** Setiap mahasiswa memiliki NIM unik yang menentukan nama, program studi, dan dosen pembimbing akademik (PA).
  * **FD2:** `nim_mahasiswa -> nama_mahasiswa, prodi_mahasiswa, kode_dosen_pa`
* **Kode AB-03 (Master Dosen PA):** Setiap dosen memiliki kode dosen unik yang menentukan nama dosen.
  * **FD3:** `kode_dosen_pa -> nama_dosen_pa`
* **Kode AB-04 (Master Mata Kuliah):** Setiap mata kuliah memiliki kode unik yang menentukan nama, jumlah SKS, dan semester kurikulum.
  * **FD4:** `kode_mk -> nama_mk, sks, semester_mk`
* **Kode AB-05 (Pengambilan Matkul & Penilaian):** Pengambilan mata kuliah pada suatu KRS menentukan kelas, nilai angka, nilai huruf, dan bobot nilai.
  * **FD5:** `(no_krs, kode_mk) -> kelas, nilai_angka, nilai_huruf, bobot_nilai`
* **Kode AB-06 (Skala Konversi Nilai):** Nilai angka menentukan nilai huruf dan bobot nilai berdasarkan acuan standar aturan akademik.
  * **FD6:** `nilai_angka -> nilai_huruf, bobot_nilai`

---

### 3. Tahapan Normalisasi (1NF, 2NF, 3NF, & Pemeriksaan BCNF)

#### A. Bentuk Normal Pertama (1NF)
Menghilangkan kelompok berulang (*repeating group*) `{ ... }` sehingga setiap sel berisikan nilai tunggal/atomik. Kunci Primer (*Primary Key*) berubah menjadi **Kunci Komposit** (`no_krs` + `kode_mk`).

* **Relasi 1NF:**  
  `KRS_1NF` (<u>`no_krs`</u>, <u>`kode_mk`</u>, `tgl_krs`, `thn_akademik`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_dosen_pa`, `nama_dosen_pa`, `nama_mk`, `sks`, `kelas`, `semester_mk`, `nilai_angka`, `nilai_huruf`, `bobot_nilai`, `total_sks`, `ips`)

* **Tabel Data 1NF:**
  | no_krs | kode_mk | tgl_krs | thn_akademik | nim_mahasiswa | nama_mahasiswa | prodi_mahasiswa | kode_dosen_pa | nama_dosen_pa | nama_mk | sks | kelas | semester_mk | nilai_angka | nilai_huruf | bobot_nilai | total_sks | ips |
  | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
  | KRS-20261-001 | INF101 | 2026-02-01 | 2025/2026 Ganjil | 25430084 | Richo Sayu Rahmadani | Ilmu Komputer | D001 | Dr. Ahmad, M.Kom. | Basis Data | 3 | A | 3 | 85 | A | 4.00 | 6 | 3.75 |
  | KRS-20261-001 | INF102 | 2026-02-01 | 2025/2026 Ganjil | 25430084 | Richo Sayu Rahmadani | Ilmu Komputer | D001 | Dr. Ahmad, M.Kom. | Pemrograman Web | 3 | C | 3 | 78 | B+ | 3.50 | 6 | 3.75 |

#### B. Bentuk Normal Kedua (2NF)
Menghilangkan **Ketergantungan Parsial** (*Partial Dependency*), yaitu kondisi di mana atribut non-kunci hanya bergantung pada sebagian kunci komposit:
* Atribut `tgl_krs`, `thn_akademik`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_dosen_pa`, `nama_dosen_pa` hanya bergantung pada `no_krs` (FD1).
* Atribut `nama_mk`, `sks`, `semester_mk` hanya bergantung pada `kode_mk` (FD4).

* **Dekomposisi Tabel 2NF:**
  * `krs` (<u>`no_krs`</u>, `tgl_krs`, `thn_akademik`, `nim_mahasiswa`, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_dosen_pa`, `nama_dosen_pa`)
  * `mata_kuliah` (<u>`kode_mk`</u>, `nama_mk`, `sks`, `semester_mk`)
  * `detail_krs` (<u>`no_krs`</u>, <u>`kode_mk`</u>, `kelas`, `nilai_angka`, `nilai_huruf`, `bobot_nilai`)

#### C. Bentuk Normal Ketiga (3NF)
Menghilangkan **Ketergantungan Transitif** (*Transitive Dependency*), yaitu atribut non-kunci yang bergantung pada atribut non-kunci lainnya:
* Pada tabel `krs`, terjadi ketergantungan transitif: `no_krs -> nim_mahasiswa -> kode_dosen_pa -> nama_dosen_pa`.
* Pada tabel `detail_krs`, terjadi ketergantungan transitif: `(no_krs, kode_mk) -> nilai_angka -> (nilai_huruf, bobot_nilai)`.

* **Dekomposisi Tabel 3NF:**
  * `dosen` (<u>`kode_dosen_pa`</u>, `nama_dosen_pa`)
  * `mahasiswa` (<u>`nim_mahasiswa`</u>, `nama_mahasiswa`, `prodi_mahasiswa`, `kode_dosen_pa`*)
  * `krs` (<u>`no_krs`</u>, `tgl_krs`, `thn_akademik`, `nim_mahasiswa`*)
  * `mata_kuliah` (<u>`kode_mk`</u>, `nama_mk`, `sks`, `semester_mk`)
  * `detail_krs` (<u>`no_krs`</u>*, <u>`kode_mk`</u>*, `kelas`, `nilai_angka`, `nilai_huruf`, `bobot_nilai`)

#### D. Pemeriksaan BCNF (Boyce-Codd Normal Form)
Syarat BCNF menetapkan bahwa untuk setiap ketergantungan fungsional $X \rightarrow Y$, determinan $X$ wajib merupakan *Super Key* / *Candidate Key*.

Analisis determinan tiap relasi:
1. **Tabel `dosen`:** Determinan `kode_dosen_pa` $\rightarrow$ Primary Key. (Memenuhi BCNF)
2. **Tabel `mahasiswa`:** Determinan `nim_mahasiswa` $\rightarrow$ Primary Key. (Memenuhi BCNF)
3. **Tabel `krs`:** Determinan `no_krs` $\rightarrow$ Primary Key. (Memenuhi BCNF)
4. **Tabel `mata_kuliah`:** Determinan `kode_mk` $\rightarrow$ Primary Key. (Memenuhi BCNF)
5. **Tabel `detail_krs`:** Determinan (`no_krs`, `kode_mk`) $\rightarrow$ Primary Key. (Memenuhi BCNF)

* **Kesimpulan:** Seluruh tabel hasil dekomposisi **telah memenuhi standar BCNF**.

---

### 4. Keputusan Penyimpanan Nilai Turunan (*Derived Attribute*)

| Atribut Turunan | Keputusan | Alasan Akademik & Teknis |
| :--- | :--- | :--- |
| **`total_sks`** | **TIDAK DISIMPAN** | Dihitung secara dinamis melalui kueri agregasi `SUM(mata_kuliah.sks)`. Menyimpan atribut ini memicu anomali jika mahasiswa menambah/membatalkan mata kuliah. |
| **`ips` (Indeks Prestasi Semester)** | **TIDAK DISIMPAN** | Merupakan hasil kalkulasi `SUM(sks * bobot_nilai) / SUM(sks)`. Cukup dihitung lewat *VIEW* atau kueri laporan semester. |
| **`subtotal_sks_bobot`** | **TIDAK DISIMPAN** | Hasil perkalian antara `sks` dan `bobot_nilai` dihitung secara On-The-Fly saat pencetakan transkrip. |
| **`nilai_huruf` & `bobot_nilai`** | **TETAP DISIMPAN** | Wajib disimpan secara permanen di `detail_krs` untuk menjaga integritas histori akademik. Standar/skala acuan konversi nilai dapat berubah antar tahun ajaran, sehingga nilai historis mahasiswa tidak boleh berubah. |

---

### 5. Pembaruan ERD Proyek & Skema Kanonik Final

Proses normalisasi menghasilkan pembaruan ERD proyek sebagai berikut:
1. **Pemisahan Entitas Pembimbing (`dosen`):** Menghilangkan redundansi data dosen pada entitas mahasiswa.
2. **Penyediaan Entitas Asosiatif (`detail_krs`):** Memecah hubungan *many-to-many* antara `krs` dan `mata_kuliah`.
3. **Penerapan Surrogate Keys (Persiapan DDL Pertemuan 5):** Menggunakan ID integer autoincrement untuk optimalisasi kueri relasional[cite: 4].

#### Skema Kanonik Final Proyek Akademik (Standar Tabel 4.2)

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
| :--- | :--- | :--- | :--- |
| **dosen** | `id_dosen` | `kode_dosen_pa` | – |
| **mahasiswa** | `id_mahasiswa` | `nim_mahasiswa` | `id_dosen` |
| **krs** | `id_krs` | `no_krs` | `id_mahasiswa` |
| **mata_kuliah** | `id_mk` | `kode_mk` | – |
| **detail_krs** | (`id_krs`, `id_mk`) | – | `id_krs`, `id_mk` |