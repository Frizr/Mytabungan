# Tabungan Online

Tabungan Online adalah aplikasi pencatatan keuangan berbasis *mobile* yang dirancang untuk membantu pengguna mengelola uang masuk dan keluar dengan mudah. Aplikasi ini dibangun dengan Flutter dan memanfaatkan Firebase sebagai *backend* untuk sinkronisasi data secara *real-time*.

## Fitur Aplikasi

- **Dashboard Keuangan:** Menampilkan total saldo pengguna saat ini.
- **Pencatatan Transaksi:** Mencatat setiap transaksi uang masuk (Pemasukan) dan uang keluar (Pengeluaran).
- **Riwayat Transaksi:** Menampilkan daftar riwayat transaksi terbaru.
- **Hide Balance:** Fitur untuk menyembunyikan nominal saldo demi privasi.
- **Real-time Database:** Data tersimpan menggunakan Firebase Firestore.

## Teknologi yang Digunakan

Proyek ini dibagi menjadi beberapa modul menggunakan arsitektur monorepo:

- **Frontend:** [Flutter](https://flutter.dev/) (Dart)
- **Database:** Firebase (Firestore)
- **Shared Models:** Package Dart terpisah untuk model data (`shared_models`)
- **Package Manager:** Melos

## Struktur Direktori

```text
tabungan_online/
├── frontend/          # Source code aplikasi utama (Flutter)
├── backend/           # Direktori backend (Cloud Functions/Server)
├── shared_models/     # Model data yang digunakan lintas modul
└── melos.yaml         # Konfigurasi Melos Workspace
```

## Alur Penggunaan Aplikasi

1. **Halaman Utama (Dashboard):**
   Saat membuka aplikasi, pengguna akan langsung disajikan dengan **Total Saldo** yang dimiliki secara *real-time*. Saldo ini dikalkulasikan otomatis dari seluruh riwayat pemasukan dan pengeluaran.
   
2. **Menyembunyikan Saldo:**
   Terdapat ikon "mata" pada kartu saldo utama. Jika pengguna sedang berada di tempat umum, pengguna bisa mengetuk ikon tersebut untuk menyensor tampilan saldo.

3. **Mencatat Transaksi Baru:**
   Pengguna dapat menekan tombol tambah (`+`) untuk mencatat uang masuk atau uang keluar yang baru. Cukup masukkan nominal dan keterangan transaksi, lalu simpan.

4. **Memantau Riwayat:**
   Di bagian bawah layar, terdapat daftar riwayat transaksi terakhir yang mencantumkan detail setiap transaksi (tanggal, nominal, dan jenis pemasukannya). Data ini ditarik langsung dari *database* (Firestore) sehingga tidak akan hilang.
