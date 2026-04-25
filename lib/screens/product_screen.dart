import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/cart_dialog.dart';
import '../utils/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product> _products = [];
  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _products = Product.defaults;
  }

  void _addToCart(Product product) {
    setState(() {
      _cartCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.nama} ditambahkan'), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header: ROTI 515 + Icon Keranjang (tanpa AppBar)
            _buildHeader(),
            // Search Bar
            const CustomSearchBar(),
            // Grid Produk
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: _products[index],
                      onAddToCart: () => _addToCart(_products[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Judul ROTI 515
          Text(
            'ROTI 515',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
              letterSpacing: 2,
            ),
          ),
          // Icon Keranjang dengan badge
          Stack(
            children: [
              IconButton(
                onPressed: () => showCartDialog(context, _cartCount),
                icon: Icon(Icons.shopping_cart_outlined, color: AppColors.primaryDark, size: 24),
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}