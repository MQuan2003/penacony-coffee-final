import 'package:flutter/material.dart';
import 'package:p_cf/controller/voucher_repository.dart';

import 'package:p_cf/view/page/gift/my_voucher/my_voucher_page.dart';
import 'package:p_cf/view/page/gift/new_voucher/detail_new_voucher.dart';
import 'package:p_cf/view/page/gift/new_voucher/voucher_page.dart';
import 'package:p_cf/widgets/bottomNavigationBar.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          const Divider(height: 2),
          Expanded(
            child: ListView(
              children: [
                _buildVoucherSection(
                  title: 'New voucher',
                  fetchData: VoucherRepository()
                      .getAllVouchers, // Lấy danh sách voucher mới
                  showPoints: true,
                ),
                // _buildVoucherSection(
                //   title: 'Voucher của tôi',
                //   fetchData: () async {
                //     return UserVoucherRepository().getUserVoucherDetails(1); // Thay 1 bằng userId thực tế
                //   },
                //   showPoints: false,
                // ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 3),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFF129575),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('0 P',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyVoucherPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('My voucher',
                style: TextStyle(color: Color(0xFF129575))),
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherSection({
    required String title,
    required Future<List<Voucher>> Function() fetchData,
    required bool showPoints,
  }) {
    return FutureBuilder<List<Voucher>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading vouchers'));
        }
        final vouchers = snapshot.data ?? [];
        if (vouchers.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text('No vouchers available for "$title".')),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const VoucherPage()));
                    },
                    child: const Text('See all'),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  return _VoucherItem(voucher: voucher, showPoints: showPoints);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _VoucherItem extends StatelessWidget {
  final Voucher voucher;
  final bool showPoints;

  const _VoucherItem({required this.voucher, required this.showPoints});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            voucher.image, // Đường dẫn ảnh từ voucher
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
        ),
        title: Text(voucher.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị trực tiếp endDate
            Text('Expires: ${voucher.endDate}',
                style: const TextStyle(color: Colors.grey)),
            if (showPoints)
              Text(
                'Points required: ${voucher.requiredPoint}',
                style: const TextStyle(color: Colors.blueGrey),
              ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VoucherDetailPage(
                image: voucher.image,
                title: voucher.title,
                expiration:voucher.endDate, // Truyền thẳng endDate dưới dạng String
                description: voucher.description, 
                requiredPoints: voucher.requiredPoint,
              ),
            ),
          );
        },
      ),
    );
  }
}
