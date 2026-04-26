import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'Diproses', 'Selesai'];

  final List<OrderItem> _orders = [
    OrderItem(
      id: '#BRD-88291',
      name: 'ROTI SOBEK + ROTI SISIR',
      status: 'Sedang Dipanggang',
      isProcess: true,
      date: 'Pesan pada 26 Apr 2026, 09:30 AM',
      total: 92000,
      progress: 60,
      estimatedTime: '45 Menit',
    ),
    OrderItem(
      id: '#ORD-7752',
      name: 'ROTI SOBEK',
      status: 'SELESAI',
      isProcess: false,
      date: 'Pesan pada 10 Okt 2023, 07:12 AM',
      total: 92000,
      progress: 100,
      estimatedTime: 'Selesai',
    ),
    OrderItem(
      id: '#ORD-6610',
      name: 'French Butter Croissant (x4)',
      status: 'SELESAI',
      isProcess: false,
      date: 'Pesan pada 02 Okt 2023, 09:30 AM',
      total: 35000,
      progress: 100,
      estimatedTime: 'Selesai',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _selectedFilter == 'Semua'
        ? _orders
        : _orders.where((order) {
            if (_selectedFilter == 'Diproses') return order.isProcess;
            if (_selectedFilter == 'Selesai') return !order.isProcess;
            return true;
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'The Artisanal Bakery',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilter(),
          Expanded(
            child: filteredOrders.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) => _buildOrderCard(filteredOrders[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Riwayat Pesanan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Kenang kembali rasa roti favoritmu dari dapur kami.',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textHint,
                  width: 1,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textHint,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text('Belum ada pesanan', style: TextStyle(color: AppColors.textHint)),
        ],
      ),
    );
  }

  Widget _buildOrderCard(OrderItem order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (order.isProcess) {
              _showDetailDialog(order);
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        order.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: order.isProcess 
                            ? Colors.orange.withOpacity(0.1) 
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        order.status,
                        style: TextStyle(
                          fontSize: 11,
                          color: order.isProcess ? Colors.orange : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  order.id,
                  style: TextStyle(fontSize: 11, color: AppColors.textHint),
                ),
                const SizedBox(height: 8),
                if (order.isProcess) ...[
                  _buildProgressBar(order.progress),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 14, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text('Estimasi Siap', style: TextStyle(fontSize: 11, color: AppColors.textHint)),
                        ],
                      ),
                      Text(
                        order.estimatedTime,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.emoji_food_beverage, size: 18, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Roti Anda sedang dalam oven. Kami memastikan gurih sempurna!',
                            style: TextStyle(fontSize: 11, color: Colors.orange.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Divider(color: AppColors.toggleBg),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TOTAL BAYAR', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                        const SizedBox(height: 2),
                        Text(_formatPrice(order.total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    if (!order.isProcess)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Pesan Lagi', style: TextStyle(fontSize: 12)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(int progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Kemajuan Panggangan', style: TextStyle(fontSize: 11)),
            Text('$progress%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: AppColors.toggleBg,
            color: Colors.orange,
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  void _showDetailDialog(OrderItem order) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.id, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            const Text('Sedang Dipanggang', style: TextStyle(fontSize: 12, color: Colors.orange)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProgressBar(order.progress),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, color: Colors.orange, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ESTIMASI SIAP', style: TextStyle(fontSize: 10)),
                      Text(order.estimatedTime, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.toggleBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.emoji_food_beverage, color: Colors.brown),
                  const SizedBox(width: 12),
                  const Text('Aroma Fresh', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }
}

class OrderItem {
  final String id;
  final String name;
  final String status;
  final bool isProcess;
  final String date;
  final int total;
  final int progress;
  final String estimatedTime;

  OrderItem({
    required this.id,
    required this.name,
    required this.status,
    required this.isProcess,
    required this.date,
    required this.total,
    required this.progress,
    required this.estimatedTime,
  });
}