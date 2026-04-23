import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/app_colors.dart';

// Model class untuk produk
// Model = cetak biru untuk menyimpan data dari API
class Product {
  final int id;
  final String nama;
  final double harga;
  final String? badge; // "?" artinya boleh null
  final String? gambar;

  // Constructor — cara membuat objek Product
  Product({
    required this.id,
    required this.nama,
    required this.harga,
    this.badge,
    this.gambar,
  });

  // Factory = fungsi khusus untuk membuat objek dari JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id'].toString()), // ← ubah ini
      nama: json['nama'],
      harga: double.parse(json['harga'].toString()),
      badge: json['badge'],
      gambar: json['gambar'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List untuk menyimpan data produk dari API
  // List = kumpulan data seperti array
  List<Product> _products = [];
  bool _isLoading = true; // true = sedang loading data

  @override
  void initState() {
    // initState = dijalankan pertama kali saat halaman dibuka
    super.initState();
    print('HomeScreen dibuka!');
    _fetchProducts(); // langsung ambil data produk
  }

  // Fungsi untuk ambil data produk dari API
  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/roti515_api/products.php'),
      );

      print('Status: ${response.statusCode}'); // ← tambah ini
      print('Body: ${response.body}'); // ← tambah ini

      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        setState(() {
          _products = (data['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
          _isLoading = false;
          print('Produk: ${_products.length}'); // ← tambah ini
        });
      }
    } catch (e) {
      print('Error: $e'); // ← tambah ini
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              _buildBanner(),
              _buildSectionTitle(
                'Koleksi Kami',
                'Hari favoritmu dari panggang kami',
              ),
              _buildSectionTitle('Paling Terlaris', null, showLihatSemua: true),
              _buildProductGrid(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // Tombol keranjang mengambang di tengah atas nav bar
      floatingActionButton: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // lekukan untuk FAB
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Beranda
            InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, color: AppColors.primary),
                  Text(
                    'Beranda',
                    style: TextStyle(fontSize: 11, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            // Produk
            InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.grid_view_outlined, color: AppColors.textHint),
                  Text(
                    'Produk',
                    style: TextStyle(fontSize: 11, color: AppColors.textHint),
                  ),
                ],
              ),
            ),

            // Profil
            InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_outline, color: AppColors.textHint),
                  Text(
                    'Profil',
                    style: TextStyle(fontSize: 11, color: AppColors.textHint),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bagian 1: App Bar atas
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        'ROTI 515',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
          letterSpacing: 2,
        ),
      ),
    );
  }

  // Bagian 2: Banner besar
  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primary, // warna coklat sementara
      ),
      child: Stack(
        // Stack = tumpuk widget
        children: [
          // Teks di atas banner
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Kehangatan\nOtentik di\nSetiap Gigitan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bagian 3: Judul section
  Widget _buildSectionTitle(
    String title,
    String? subtitle, {
    bool showLihatSemua = false,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (showLihatSemua) // tampilkan hanya jika showLihatSemua = true
                Text(
                  'Lihat Semua >',
                  style: TextStyle(fontSize: 12, color: AppColors.primary),
                ),
            ],
          ),
          if (subtitle != null) // tampilkan subtitle jika tidak null
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
            ),
        ],
      ),
    );
  }

  // Bagian 4: Grid produk
  Widget _buildProductGrid() {
    // Tampilkan loading indicator saat data belum ada
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // animasi loading bulat
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        // GridView = tampilkan dalam bentuk grid
        shrinkWrap: true, // sesuaikan tinggi dengan isi
        physics: const NeverScrollableScrollPhysics(), // scroll diurus parent
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 12, // jarak antar kolom
          mainAxisSpacing: 12, // jarak antar baris
          childAspectRatio: 0.85, // rasio lebar:tinggi tiap card
        ),
        itemCount: _products.length, // jumlah produk
        itemBuilder: (context, index) {
          return _buildProductCard(_products[index]); // buat card tiap produk
        },
      ),
    );
  }

  // Bagian 5: Card produk
  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        // Stack untuk badge di atas gambar
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Area gambar produk
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.toggleBg,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    // sementara pakai ikon
                    Icons.bakery_dining,
                    size: 60,
                    color: Color(0xFFB8952A),
                  ),
                ),
              ),
              // Info produk
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nama,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      // NumberFormat untuk format angka jadi Rp 15.000
                      'Rp ${product.harga.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                      style: TextStyle(fontSize: 12, color: AppColors.textHint),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Badge "BEST SELLER" / "NEW" di pojok kiri atas
          if (product.badge != null)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: product.badge == 'BEST SELLER'
                      ? Colors.orange
                      : Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  product.badge!, // "!" = yakin tidak null
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Tombol "+" di pojok kanan bawah
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  // Bagian 6: Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      currentIndex: 0,
      type: BottomNavigationBarType.fixed, // agar semua label selalu tampil
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_outlined),
          activeIcon: Icon(Icons.grid_view),
          label: 'Produk',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Keranjang',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}
