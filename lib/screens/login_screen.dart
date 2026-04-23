// ===================================================
// FILE: lib/screens/login_screen.dart
// Halaman Login untuk App Roti 515
// ===================================================

import '../services/auth_service.dart';
import 'admin_login_screen.dart';
import 'register_screen.dart';
import 'login_success_screen.dart';
import 'package:flutter/material.dart'; // import library Flutter (wajib di setiap file UI)
import '../utils/app_colors.dart'; // import warna kustom kita (.. = naik satu folder)

// CLASS LoginScreen — cetak biru untuk halaman login
// StatefulWidget = widget yang bisa berubah tampilannya (misal: tab aktif, show/hide password)
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  }); // constructor — super.key untuk identitas widget

  @override
  State<LoginScreen> createState() => _LoginScreenState(); // hubungkan ke "isi" class di bawah
}

// CLASS _LoginScreenState — tempat semua logika dan tampilan ditulis
// Tanda "_" di depan = private, hanya bisa dipakai di file ini
class _LoginScreenState extends State<LoginScreen> {
  // VARIABEL — menyimpan data yang bisa berubah
  String _selectedRole =
      'Pelanggan'; // menyimpan tab yang aktif (Pelanggan atau Admin)
  bool _isPasswordVisible =
      false; // true = password terlihat, false = tersembunyi

  // TextEditingController = alat untuk mengambil teks yang diketik user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // FUNGSI BUILD — wajib ada, dipanggil Flutter untuk menggambar tampilan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // kerangka dasar halaman Flutter
      backgroundColor: AppColors.background, // warna latar belakang krem
      body: SafeArea(
        // hindari area notch/status bar
        child: SingleChildScrollView(
          // bisa di-scroll jika konten panjang
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ), // jarak kiri-kanan 24px
          child: Column(
            // susun widget dari atas ke bawah
            crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
            children: [
              _buildHeader(), // bagian judul "Roti 515"
              _buildRoleToggle(), // bagian tab Pelanggan/Admin
              _buildWelcomeText(), // teks "Selamat Datang"
              _buildEmailField(), // input email
              _buildPasswordField(), // input kata sandi
              _buildLoginButton(), // tombol "Masuk Ke Akun"
              _buildDivider(), // garis "atau masuk dengan"
              _buildGoogleButton(), // tombol Google
              _buildRegisterLink(), // link "Daftar Sekarang"
            ],
          ),
        ),
      ),
    );
  }

  // ===================================================
  // FUNGSI-FUNGSI PEMBUAT BAGIAN UI
  // Setiap fungsi mengembalikan (return) satu Widget
  // ===================================================

  // Bagian 1: Header "Roti 515" di atas
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 24,
      ), // jarak atas 32px, bawah 24px
      child: Center(
        // posisikan di tengah
        child: Text(
          'Roti 515', // teks yang ditampilkan
          style: TextStyle(
            fontSize: 20, // ukuran huruf 20px
            fontWeight: FontWeight.w600, // ketebalan semi-bold
            color: AppColors.primaryDark, // warna coklat gelap
          ),
        ),
      ),
    );
  }

  // Bagian 2: Tab Toggle Pelanggan / Admin
  Widget _buildRoleToggle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 32), // jarak bawah 32px
      padding: const EdgeInsets.all(4), // jarak dalam semua sisi 4px
      decoration: BoxDecoration(
        color: AppColors.toggleBg, // warna abu krem
        borderRadius: BorderRadius.circular(
          30,
        ), // sudut sangat membulat (pill shape)
      ),
      child: Row(
        // susun tombol kiri ke kanan
        children: [
          _buildToggleButton('Pelanggan'), // tombol kiri
          _buildToggleButton('Admin'), // tombol kanan
        ],
      ),
    );
  }

  // Helper: membuat SATU tombol toggle
  // Parameter "String label" = menerima teks 'Pelanggan' atau 'Admin'
  Widget _buildToggleButton(String label) {
    bool isActive =
        _selectedRole == label; // cek apakah tombol ini sedang aktif

    return Expanded(
      // isi sisa ruang yang tersedia secara merata
      child: GestureDetector(
        // mendeteksi sentuhan/tap user
        onTap: () {
          setState(() {
            _selectedRole = label;
          });
          // Jika tap Admin, navigasi ke halaman Admin
          if (label == 'Admin') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
            );
          }
        },
        child: AnimatedContainer(
          // Container dengan animasi otomatis saat berubah
          duration: const Duration(
            milliseconds: 200,
          ), // animasi selama 0.2 detik
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // Jika aktif: warna coklat. Jika tidak: transparan
            // Format: kondisi ? nilai_true : nilai_false
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Text(
            label, // teks tombol ('Pelanggan' atau 'Admin')
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive
                  ? AppColors.white
                  : AppColors.textHint, // putih jika aktif
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // Bagian 3: Teks "Selamat Datang"
  Widget _buildWelcomeText() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 24), // jarak bawah 24px
      child: Text(
        'Selamat Datang',
        style: TextStyle(
          fontSize: 28, // ukuran besar
          fontWeight: FontWeight.bold, // tebal
          color: Colors.black87, // hitam sedikit transparan
        ),
      ),
    );
  }

  // Bagian 4: Input Email
  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // rata kiri
      children: [
        const Text('Email', style: TextStyle(fontSize: 14)), // label "Email"
        const SizedBox(height: 8), // jarak 8px
        TextField(
          controller: _emailController, // hubungkan ke controller
          decoration: InputDecoration(
            hintText: 'nama@email.com', // teks placeholder
            hintStyle: TextStyle(color: AppColors.textHint),
            prefixIcon: Icon(
              Icons.email_outlined, // ikon amplop di kiri
              color: AppColors.textHint,
            ),
            filled: true, // aktifkan warna background
            fillColor: AppColors.inputBg, // warna background input
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // sudut membulat
              borderSide: BorderSide.none, // hilangkan garis border
            ),
          ),
        ),
        const SizedBox(height: 16), // jarak bawah 16px
      ],
    );
  }

  // Bagian 5: Input Kata Sandi
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // kiri dan kanan berjauhan
          children: [
            const Text('Kata Sandi', style: TextStyle(fontSize: 14)),
            Text(
              'Lupa Kata Sandi?', // link di kanan
              style: TextStyle(fontSize: 14, color: AppColors.textHint),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText:
              !_isPasswordVisible, // true = sembunyikan teks (jadi titik-titik)
          decoration: InputDecoration(
            hintText: '••••••••',
            prefixIcon: Icon(Icons.lock_outline, color: AppColors.textHint),
            suffixIcon: GestureDetector(
              // ikon mata di kanan, bisa diklik
              onTap: () {
                setState(() {
                  // "!" artinya membalik nilai boolean
                  // false jadi true, true jadi false
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                // Tampilkan ikon mata terbuka atau tertutup sesuai kondisi
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.textHint,
              ),
            ),
            filled: true,
            fillColor: AppColors.inputBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  // Bagian 6: Tombol "Masuk Ke Akun"
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity, // lebar penuh mengikuti layar
      child: ElevatedButton(
        onPressed: () async {
          // Ambil teks yang diketik user
          String email = _emailController.text;
          String password = _passwordController.text;

          // Validasi — jangan sampai kosong
          if (email.isEmpty || password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email dan password wajib diisi!')),
            );
            return; // berhenti di sini, jangan lanjut
          }

          // Panggil API login
          final result = await AuthService.login(
            email: email,
            password: password,
          );

          // Cek hasilnya
          if (result['success'] == true) {
            // Berhasil → pindah ke halaman sukses
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginSuccessScreen(),
              ),
            );
          } else {
            // Gagal → tampilkan pesan error
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(result['message'])));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary,
          disabledForegroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Masuk Ke Akun',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Bagian 7: Garis pemisah "atau masuk dengan"
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(child: Divider(color: AppColors.textHint)), // garis kiri
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'atau masuk dengan',
              style: TextStyle(color: AppColors.textHint, fontSize: 13),
            ),
          ),
          Expanded(child: Divider(color: AppColors.textHint)), // garis kanan
        ],
      ),
    );
  }

  // Bagian 8: Tombol Google
  Widget _buildGoogleButton() {
    return Center(
      child: OutlinedButton.icon(
        // tombol dengan ikon + teks
        onPressed: () {},
        icon: const Icon(
          Icons.g_mobiledata,
          size: 24,
        ), // ikon Google (sementara)
        label: const Text('Google'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Bagian 9: Link "Belum punya akun? Daftar Sekarang"
  Widget _buildRegisterLink() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // posisi tengah
          children: [
            const Text('Belum punya akun? '), // teks biasa
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: Text(
                'Daftar Sekarang',
                style: TextStyle(
                  color: AppColors.primary, // warna coklat
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
