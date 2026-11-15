# JejakRasa

Aplikasi Flutter untuk menjelajah kuliner daerah Indonesia, menyimpan menu
favorit, dan menulis jurnal rasa. Semua data menggunakan dummy data dan disimpan
di state aplikasi—tidak memerlukan akun, API, atau koneksi internet.

## Menjalankan aplikasi

Pastikan Flutter stable dan Android SDK tersedia, lalu jalankan dari folder
proyek:

```shell
flutter pub get
flutter run
```

Pilih perangkat atau emulator Android yang terhubung. Aplikasi juga mendukung
Chrome untuk pratinjau cepat:

```shell
flutter run -d chrome
```

## Fitur

- Splash screen dan layar masuk dengan validasi nama.
- Beranda, jelajah kuliner, jurnal rasa, profil, dan detail kuliner.
- Pencarian berdasarkan nama menu atau daerah dan filter kategori.
- Favorit dinamis yang dapat ditambahkan atau dihapus.
- Jurnal kuliner dengan pilihan menu, validasi catatan, dan riwayat catatan.
- State aplikasi bersama agar pilihan menu, favorit, pencarian, dan draft
  catatan tetap terjaga saat berpindah halaman dan orientasi layar berubah.

## Verifikasi

```shell
flutter analyze
flutter test
```
