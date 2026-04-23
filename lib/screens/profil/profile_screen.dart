import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  // Konstanta Warna sesuai desain Roti 515
  final Color bgKrem = const Color(0xFFFDF7E9);
  final Color coklatTua = const Color(0xFF4A342E);
  final Color coklatMuda = const Color(0xFF8D6E63);
  final Color kartuKrem = const Color(0xFFF3EADA);
  final Color pinkKeluar = const Color(0xFFFFEBEE);
  final Color merahTeks = const Color(0xFFC62828);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgKrem,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ROTI 515',
          style: TextStyle(color: coklatTua, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Header Profil (Foto dan Nama)
            _buildProfileHeader(),
            const SizedBox(height: 30),
            
            // Bagian Informasi Akun
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Informasi Akun',
                style: TextStyle(color: coklatTua, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            
            // Kartu Telepon
            _buildInfoTile(
              icon: Icons.phone_outlined,
              title: 'TELEPON',
              subtitle: '+62 812 3456 7890',
            ),
            const SizedBox(height: 12),
            
            // Kartu Alamat
            _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'ALAMAT UTAMA',
              subtitle: 'Kauman, Kec. Nganjuk, Kabupaten Nganjuk, Jawa Timur',
            ),
            const SizedBox(height: 12),
            
            // Tombol Riwayat Pesanan
            _buildMenuTile(
              icon: Icons.receipt_long_outlined,
              title: 'RIWAYAT PESANAN',
            ),
            const SizedBox(height: 40),
            
            // Tombol Keluar dari Akun
            _buildLogoutButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget untuk bagian atas (Foto & Nama)
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: kartuKrem,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/user_photo.jpg'), // Pastikan file ada di assets
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: Color(0xFF6D4C41), shape: BoxShape.circle),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            'Dims Suka Aralie',
            style: TextStyle(color: coklatTua, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'dims@gmail.com',
            style: TextStyle(color: coklatMuda, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget untuk Item Informasi (Telepon & Alamat)
  Widget _buildInfoTile({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kartuKrem,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFE7DCC8), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: coklatTua),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: coklatMuda, fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: coklatTua, fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Menu (Riwayat Pesanan)
  Widget _buildMenuTile({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kartuKrem,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFE7DCC8), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: coklatTua),
          ),
          const SizedBox(width: 15),
          Text(title, style: TextStyle(color: coklatTua, fontSize: 14, fontWeight: FontWeight.bold)),
          const Spacer(),
          Icon(Icons.chevron_right, color: coklatMuda),
        ],
      ),
    );
  }

  // Widget Tombol Keluar
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: pinkKeluar,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: merahTeks),
            const SizedBox(width: 10),
            Text('Keluar dari Akun', style: TextStyle(color: merahTeks, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}