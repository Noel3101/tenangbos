# TenangBos - Sistem Operasional Terpadu

Aplikasi dashboard manajemen operasional untuk multi-outlet (retail/F&B). Dibangun menggunakan **PHP Native (PDO)** dan **MySQL**, tanpa framework, sehingga ringan dan mudah di-deploy di shared hosting.

## 🚀 Fitur Utama

- **Dashboard Ringkasan**: Pantau keterlambatan, karyawan alpha, insiden, dan SOP yang belum selesai dalam satu layar.
- **Kesehatan Outlet**: Lihat status (Normal/Perlu Perhatian/Bermasalah) dari setiap outlet.
- **Absensi Karyawan**: Kelola data kehadiran, keterlambatan, dan ketidakhadiran.
- **Insiden**: Catat dan selesaikan masalah operasional di lapangan.
- **SOP (Checklist)**: Pastikan setiap outlet mengikuti standar operasional.
- **Pelatihan**: Pantau status pelatihan karyawan.
- **Mode Demo**: Dilengkapi data contoh agar bisa langsung dicoba tanpa setup rumit.

## 🛠️ Prasyarat

- PHP 7.4 atau lebih baru (disarankan PHP 8+).
- Ekstensi PHP: `pdo_mysql`.
- MySQL / MariaDB (XAMPP / Laragon).
- Web server (Apache/Nginx) atau PHP Built-in Server.

## 📦 Cara Instalasi

1. **Clone / Download** project ini ke folder web server Anda (misal `C:\xampp\htdocs\tenangbos-php`).
2. **Buat Database**:
   - Buka phpMyAdmin (`http://localhost/phpmyadmin`).
   - Import file `database/schema.sql` (membuat database dan tabel).
   - Import file `database/seed.sql` (mengisi data demo).
3. **Konfigurasi Database**:
   - Buka `app/config/database.php`.
   - Sesuaikan `$DB_USER` dan `$DB_PASS` dengan pengaturan MySQL Anda (biasanya `root` dan kosong untuk XAMPP).
4. **Konfigurasi Web Server (Apache)**:
   - Pastikan modul `mod_rewrite` di Apache sudah aktif.
   - Pastikan `AllowOverride All` diizinkan untuk folder project Anda.
5. **Jalankan Aplikasi**:
   - **Opsi A (XAMPP)**: Akses melalui `http://localhost/tenangbos-php/public`.
   - **Opsi B (PHP Built-in Server)**:
     ```bash
     php -S localhost:8000 -t public