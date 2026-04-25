import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
            _buildProfileHeader(),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Informasi Akun',
                style: TextStyle(color: coklatTua, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            _buildInfoTile(
              icon: Icons.phone_outlined,
              title: 'TELEPON',
              subtitle: '+62 812 3456 7890',
            ),
            const SizedBox(height: 12),
            _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'ALAMAT UTAMA',
              subtitle: 'Kauman, Kec. Nganjuk, Kabupaten Nganjuk, Jawa Timur',
            ),
            const SizedBox(height: 12),
            _buildMenuTile(
              icon: Icons.receipt_long_outlined,
              title: 'RIWAYAT PESANAN',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur riwayat pesanan segera hadir!')),
                );
              },
            ),
            const SizedBox(height: 40),
            _buildLogoutButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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
                child: Icon(Icons.person, size: 50, color: Colors.brown),
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

  Widget _buildMenuTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  // ========== TAMBAHKAN FUNGSI LOGOUT ==========
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Konfirmasi Keluar'),
                content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: merahTeks,
                    ),
                    child: const Text('Keluar'),
                  ),
                ],
              );
            },
          );
        },
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
  // ==============================================
}