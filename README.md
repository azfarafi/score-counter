# Papan Skor Pertandingan

Aplikasi Flutter untuk mencatat skor pertandingan 2 pemain, dengan skor
maksimal (target menang) yang bisa diatur sebelum permainan dimulai.

## Fitur

- **Atur skor maksimal sebelum main** gunakan preset (11 / 15 / 21 / 25)
  atau atur bebas dengan tombol +/-.
- **2 pemain**, masing-masing punya nama, warna, dan area ketuk sendiri.
- Tampilan bergaya papan skor arena: gelap, kontras tinggi, angka besar, indikator **MATCH POINT**
- Tombol koreksi (–) untuk membetulkan salah ketuk, tombol reset, dan
  konfirmasi sebelum membatalkan pertandingan yang sedang berjalan.
- Layar kemenangan dengan animasi, tombol **MAIN LAGI** (skor direset,
  pengaturan tetap) atau **PENGATURAN BARU** (kembali ke layar awal).

## Persyaratan

- Flutter SDK terpasang (disarankan versi 3.10 ke atas). Cek dengan:
  ```
  flutter doctor
  ```
- Emulator Android/iOS, atau HP yang tersambung lewat USB debugging.

## Cara membuka & menjalankan (dari file ZIP)

1. **Ekstrak** file zip ke folder mana saja, misalnya `score_pertandingan`.
2. Buka terminal, masuk ke folder hasil ekstrak:
   ```
   cd score_pertandingan
   ```
3. Jalankan perintah berikut untuk melengkapi folder platform
   (Android/iOS/Web) yang memang tidak disertakan di dalam zip:
   ```
   flutter create .
   ```
   Perintah ini **aman** — dia hanya menambahkan folder `android/`, `ios/`,
   dll. yang belum ada. File `lib/`, `pubspec.yaml`, dan `assets/` yang sudah
   disiapkan **tidak akan tertimpa**.
4. Ambil semua dependency:
   ```
   flutter pub get
   ```
5. Jalankan aplikasinya (emulator harus sudah menyala atau HP sudah
   tersambung):
   ```
   flutter run
   ```
   Atau buka folder ini di VS Code / Android Studio lalu tekan tombol Run.

## Cara main

1. Di layar awal, isi nama Pemain 1 dan Pemain 2 (boleh dikosongkan, nanti
   memakai nama default).
2. Atur skor maksimal untuk menang, lalu tekan **MULAI PERTANDINGAN**.
3. Layar berputar ke mode landscape. Ketuk/tekan di area masing-masing pemain untuk
   menambah skor; tombol kecil (–) di dekat garis tengah untuk mengoreksi.
4. Saat salah satu pemain mencapai skor maksimal, layar kemenangan muncul.
   Pilih **MAIN LAGI** untuk rematch dengan pengaturan yang sama, atau
   **PENGATURAN BARU** untuk kembali ke layar awal.

## Struktur proyek

```
lib/
  main.dart                     # Entry point aplikasi
  theme/app_theme.dart          # Palet warna & style teks arena
  models/match_settings.dart    # Data nama pemain & skor maksimal
  screens/setup_screen.dart     # Layar pengaturan sebelum main
  screens/scoreboard_screen.dart# Layar papan skor utama
  widgets/player_panel.dart     # Panel skor tiap pemain (bisa dibalik 180°)
  widgets/win_overlay.dart      # Overlay saat ada pemenang
  widgets/arena_background.dart# Latar belakang garis tengah lapangan
assets/fonts/                   # Font Orbitron & Bebas Neue (SIL OFL)
test/widget_test.dart           # Tes dasar (smoke test)
```
