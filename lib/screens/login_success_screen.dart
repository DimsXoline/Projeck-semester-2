// ===================================================
// FILE: lib/screens/login_success_screen.dart
// Halaman sukses setelah login berhasil
// ===================================================

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // warna latar krem
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // posisi tengah vertikal
            children: [
              const Spacer(), // mendorong konten ke tengah
              _buildLogo(), // lingkaran logo + badge centang
              const SizedBox(height: 40),
              _buildWelcomeText(), // teks "Selamat Datang Kembali!"
              const SizedBox(height: 16),
              _buildSubtitle(), // teks keterangan
              const Spacer(), // mendorong tombol ke bawah
              _buildContinueButton(context), // tombol "Lanjut ke Aplikasi"
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Bagian 1: Logo bulat + badge centang oranye
  Widget _buildLogo() {
    return Stack(
      // Stack = tumpuk widget di atas widget lain
      clipBehavior: Clip.none, // izinkan child keluar dari batas Stack
      children: [
        // Lingkaran putih besar (background logo)
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white, // warna putih
            shape: BoxShape.circle, // bentuk lingkaran
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08), // bayangan halus
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon roti (menggunakan emoji sebagai placeholder)
                // Nanti bisa diganti dengan gambar asli dari assets
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8952A), // warna emas/kuning
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'ROTI 515\nLOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Ikon roti di bawah label
                const Icon(
                  Icons.bakery_dining, // ikon roti dari Flutter
                  size: 36,
                  color: Color(0xFFB8952A), // warna emas
                ),
              ],
            ),
          ),
        ),

        // Badge centang oranye di pojok kanan bawah lingkaran
        Positioned(
          bottom: 0, // posisi dari bawah
          right: -4, // posisi dari kanan (sedikit keluar)
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFFF8C42), // warna oranye
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check, // ikon centang
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  // Bagian 2: Teks "Selamat Datang Kembali!"
  Widget _buildWelcomeText() {
    return const Text(
      'Selamat Datang\nKembali!', // "\n" = pindah baris
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        height: 1.2, // jarak antar baris
      ),
    );
  }

  // Bagian 3: Teks keterangan
  Widget _buildSubtitle() {
    return Text(
      'Aroma roti hangat sudah menunggu.\nLogin Anda berhasil dan sesi Anda telah\ndisiapkan dengan sempurna.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textHint, // warna abu
        height: 1.6, // jarak antar baris
      ),
    );
  }

  // Bagian 4: Tombol "Lanjut ke Aplikasi"
  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity, // lebar penuh
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        icon: const Icon(
          Icons.arrow_forward, // ikon panah ke kanan
          color: Colors.white,
        ),
        label: const Text(
          'Lanjut ke Aplikasi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // warna coklat
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // sangat membulat
          ),
        ),
      ),
    );
  }
}
