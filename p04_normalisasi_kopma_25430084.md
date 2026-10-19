## D. Hasil Langkah Percobaan

### D.1: Dari UNF ke 1NF (Kasus Kopma)

1. **Bentuk UNF (*Unnormalized Form*)**
   Pada data spreadsheet lama Koperasi Mahasiswa (Kopma), pencatatan dilakukan dalam satu tabel besar di mana satu baris merepresentasikan satu nota penjualan yang di dalamnya memuat kelompok data barang yang dapat berulang (*repeating group*)[cite: 63, 64].
   * **Bentuk Relasi UNF:**  
     `NOTA_UNF` (`no_nota_penjualan`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `{ kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan }`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)[cite: 64]
   * **Keterangan:** Tanda kurung kurawal `{ ... }` menyatakan kelompok berulang (satu nota mencakup beberapa baris item barang sekaligus)[cite: 64]. Bentuk ini memicu berbagai anomali data (ubah, sisip, dan hapus)[cite: 62].

2. **Bentuk 1NF (*First Normal Form*)**
   Untuk memenuhi syarat Bentuk Normal Pertama (1NF), seluruh grup berulang harus dihilangkan dan setiap sel data harus bersifat atomik (hanya berisi satu nilai tunggal)[cite: 35, 64].
   * **Cara Penerapan:** Baris tabel dipecah ke bawah sehingga setiap satu jenis barang pada sebuah nota mendiami satu baris tersendiri. Akibat pemecahan ini, kunci primer (*Primary Key*) berubah menjadi kunci komposit (gabungan nomor nota dan kode barang)[cite: 64].
   * **Bentuk Relasi 1NF:**  
     `NOTA_1NF` (`no_nota_penjualan`, `kode_barang`, `tgl_penjualan`, `kode_petugas`, `nama_petugas`, `no_anggota`, `nama_anggota`, `nama_barang`, `qty_detail_penjualan`, `harga_satuan_detail_penjualan`, `subtotal_detail_penjualan`, `jumlah_penjualan`, `diskon_penjualan`, `total_penjualan`)[cite: 64]

3. **Ilustrasi Wujud Tabel Data (UNF ke 1NF):**
   * **Bentuk UNF (Contoh Data):**
     | no_nota_penjualan | tgl_penjualan | kode_petugas | nama_petugas | no_anggota | nama_anggota | { kode_barang, nama_barang, qty_detail_penjualan, harga_satuan_detail_penjualan, subtotal_detail_penjualan } |
     | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
     | NOTA-001 | 2026-05-01 | P01 | Andi | A01 | Budi | BRG01, Buku, 2, 5000, 10000 <br> BRG02, Pulpen, 1, 3000, 3000 |

   * **Bentuk 1NF (Setelah Dipecah):**
     | no_nota_penjualan | kode_barang | tgl_penjualan | kode_petugas | nama_petugas | no_anggota | nama_anggota | nama_barang | qty_detail_penjualan | harga_satuan_detail_penjualan | subtotal_detail_penjualan |
     | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
     | NOTA-001 | BRG01 | 2026-05-01 | P01 | Andi | A01 | Budi | Buku | 2 | 5000 | 10000 |
     | NOTA-001 | BRG02 | 2026-05-01 | P01 | Andi | A01 | Budi | Pulpen | 1 | 3000 | 3000 |

     ### D.2: Menuliskan Dependensi Fungsional (FD)

Dependensi fungsional diturunkan langsung dari aturan bisnis (*Business Rules*) Modul 2, bukan dari contoh data[cite: 48, 64]. Aturan ini menyatakan bahwa nilai pada atribut sebelah kiri menentukan dengan pasti nilai pada atribut sebelah kanan ($A \rightarrow B$).

Berdasarkan studi kasus Kopma, ketergantungan fungsionalnya adalah:
* **FD1:** `no_nota_penjualan -> tgl_penjualan, kode_petugas, no_anggota`[cite: 64]  
  *(Satu nomor nota yang unik menentukan tanggal, kasir, dan anggota pembelinya[cite: 47, 64]).*
* **FD2:** `kode_petugas -> nama_petugas`[cite: 64]  
  *(Kode petugas merujuk pada satu nama petugas tertentu.)*
* **FD3:** `no_anggota -> nama_anggota`[cite: 64]  
  *(Nomor anggota merujuk pada satu nama anggota tertentu.)*
* **FD4:** `kode_barang -> nama_barang`[cite: 64]  
  *(Kode barang merujuk pada satu nama barang tertentu.)*
* **FD5:** `(no_nota_penjualan, kode_barang) -> qty_detail_penjualan, harga_satuan_detail_penjualan`[cite: 64]  
  *(Gabungan nomor nota dan kode barang menentukan jumlah dan harga satuan saat transaksi[cite: 47, 64]).*
* **FD6:** `qty_detail_penjualan, harga_satuan_detail_penjualan -> subtotal_detail_penjualan`[cite: 64]  
  *(Jumlah kali harga satuan menghasilkan subtotal [nilai turunan][cite: 47, 64]).*

  ### D.3: Menuju Bentuk Normal Kedua (2NF) dan Ketiga (3NF)

1. **Bentuk Normal Kedua (2NF)**
   * **Syarat:** Tabel sudah dalam bentuk 1NF dan semua atribut bukan kunci harus bergantung penuh (*fully functional dependent*) pada seluruh kunci primer (tidak boleh ada ketergantungan parsial pada sebagian kunci komposit).
   * **Penerapan pada Kasus Kopma:** Karena kunci primernya berupa kunci komposit (`no_nota_penjualan`, `kode_barang`), atribut yang hanya bergantung pada sebagian kunci (misalnya tanggal penjualan, kode petugas, dan nomor anggota yang hanya bergantung pada `no_nota_penjualan`) dipisahkan ke dalam tabel master/transaksi tersendiri.

2. **Bentuk Normal Ketiga (3NF)**
   * **Syarat:** Tabel sudah dalam bentuk 2NF dan bebas dari ketergantungan transitif, artinya atribut bukan kunci tidak boleh bergantung pada atribut bukan kunci lainnya.
   * **Penerapan pada Kasus Kopma:** Atribut seperti `nama_petugas` bergantung pada `kode_petugas`, dan `nama_anggota` bergantung pada `no_anggota`. Karena `kode_petugas` dan `no_anggota` bukan kunci primer utama tabel nota, maka dibuatkan tabel terpisah untuk entitas `petugas` dan `anggota`.
   * **Keputusan Nilai Turunan:** Atribut turunan seperti *subtotal*, *jumlah_penjualan*, dan *total_penjualan* **tidak disimpan secara fisik** di dalam tabel operasional, melainkan dihitung secara langsung saat kueri dijalankan untuk mencegah anomali pembaruan dan inkonsistensi data.

   ### D.4: Mencocokkan dengan Skema Kanonik

1. **Perbandingan dengan Skema Kanonik Kopma**
   * Berdasarkan hasil perbandingan dengan skema kanonik Kopma (Tabel 4.2 pada buku praktikum), perbedaan utamanya terletak pada penggunaan **surrogate key** (`id_*`) sebagai Kunci Primer (*Primary Key*), sedangkan kode alami seperti `no_nota_penjualan` atau `kode_barang` ditetapkan sebagai Kunci Unik (*Unique Key*)[cite: 3].
   * Pemeriksaan **BCNF** (*Boyce-Codd Normal Form*) menunjukkan bahwa seluruh penentu (*determinant*) pada tabel-tabel di bawah ini telah berupa *candidate key*, sehingga struktur sudah terbebas dari anomali[cite: 3].

2. **Tabel 4.2 Skema kanonik Kopma hasil normalisasi (Acuan Buku Praktikum)**[cite: 3]

| Tabel | Kunci primer | Kunci unik | Kunci tamu |
| :--- | :--- | :--- | :--- |
| **petugas** | `id_petugas`[cite: 3] | `kode_petugas`[cite: 3] | –[cite: 3] |
| **anggota** | `id_anggota`[cite: 3] | `no_anggota`, `nim_anggota`[cite: 3] | –[cite: 3] |
| **barang** | `id_barang`[cite: 3] | `kode_barang`[cite: 3] | –[cite: 3] |
| **pemasok** | `id_pemasok`[cite: 3] | –[cite: 3] | –[cite: 3] |
| **penjualan** | `id_penjualan`[cite: 3] | `no_nota_penjualan`[cite: 3] | `id_petugas`, `id_anggota` (boleh NULL)[cite: 3] |
| **detail_penjualan** | (`id_penjualan`, `id_barang`)[cite: 3] | –[cite: 3] | `id_penjualan`, `id_barang`[cite: 3] |
| **pembelian** | `id_pembelian`[cite: 3] | –[cite: 3] | `id_pemasok`[cite: 3] |
| **detail_pembelian** | (`id_pembelian`, `id_barang`)[cite: 3] | –[cite: 3] | `id_pembelian`, `id_barang`[cite: 3] |

3. **Titik Analisis: 3**
   * **Pertanyaan:** Kolom `pemasok_brg` di spreadsheet lama tidak muncul di tabel barang. Di mana informasi "barang ini dipasok oleh siapa" kini disimpan? Apa keuntungannya dibandingkan menyimpan satu nama pemasok di tabel barang?[cite: 3]
   * **Jawaban Analisis:** Informasi mengenai pemasok suatu barang kini disimpan melalui relasi pada tabel **`pembelian`** dan **`detail_pembelian`** (yang menghubungkan `id_pembelian` dengan `id_barang` serta merujuk ke `id_pemasok`). Keuntungannya adalah kita dapat mencatat riwayat pembelian dari berbagai pemasok berbeda untuk barang yang sama dari waktu ke waktu tanpa mengalami redundansi data atau anomali pembaruan pada tabel master barang.

### E. Latihan dan Modifikasi

#### 1. Normalisasi Nomor Telepon Pemasok (*Multi-valued Attribute*)
* **Kasus:** Kopma ingin mencatat beberapa nomor telepon untuk setiap pemasok. Normalisasikan kebutuhan ini dan tuliskan relasi barunya[cite: 2].
* **Analisis & Solusi:** 
  Atribut nomor telepon yang bernilai banyak (*multi-valued attribute*) melanggar aturan bentuk normal pertama (1NF). Untuk menormalkannya, kita tidak boleh menumpuk nomor telepon dalam satu kolom di tabel `pemasok`, melainkan harus memecahnya menjadi entitas atau tabel relasional baru yang independen.
* **Struktur Relasi Baru:**
  * **`pemasok`** (`id_pemasok` (PK), `nama_pemasok`, `alamat_pemasok`)
  * **`telepon_pemasok`** (`id_telepon` (PK), `id_pemasok` (FK), `nomor_telepon`)
  * *Penjelasan:* Dengan tabel terpisah `telepon_pemasok`, satu pemasok (`id_pemasok`) dapat memiliki banyak baris nomor telepon tanpa batas, sehingga bentuk data tetap atomik dan memenuhi kaidah normalisasi.

---

#### 2. Simulasi Pelanggaran 3NF dan Anomali Ubah (*Update Anomaly*)
* **Kasus:** Tunjukkan satu contoh data yang melanggar 3NF jika `nama_anggota` disimpan di tabel penjualan, lalu tulis kueri ubah yang memperlihatkan anomali ubahnya[cite: 2].
* **Analisis & Solusi:**
  Jika atribut `nama_anggota` disimpan langsung di dalam tabel `penjualan` (yang memiliki kunci utama `id_penjualan` atau `no_nota_penjualan`), maka terjadi ketergantungan transitif (`no_nota_penjualan -> no_anggota -> nama_anggota`), yang melanggar **3NF**.
* **Contoh Data Pelanggaran (Tabel Penjualan Tidak Ternormalisasi):**

| id_penjualan | no_nota_penjualan | no_anggota | nama_anggota | total_belanja |
| :--- | :--- | :--- | :--- | :--- |
| 1 | NOTA-001 | A01 | Budi Santoso | 50000 |
| 2 | NOTA-002 | A02 | Ani Lestari | 75000 |
| 3 | NOTA-003 | A01 | Budi Santosa | 120000 |

* **Simulasi Anomali Ubah (*Update Anomaly*):**
  Jika anggota dengan `no_anggota` = 'A01' mengubah namanya dari "Budi Santoso" menjadi "Budi Santoso, S.Kom.", dan kita melakukan pembaruan data hanya pada baris pertama saja menggunakan kueri berikut:
  ```sql
  UPDATE penjualan 
  SET nama_anggota = 'Budi Santoso, S.Kom.' 
  WHERE no_nota_penjualan = 'NOTA-001';
