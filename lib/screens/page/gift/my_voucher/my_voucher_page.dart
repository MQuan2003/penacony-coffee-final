import 'package:flutter/material.dart';
import 'package:p_cf/screens/page/gift/my_voucher/detail_my_voucher.dart';

class MyVoucherPage extends StatelessWidget {
  const MyVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myVouchers = [
      {
        'title': 'Discount 10%',
        'expiration': '30/11/2024',
        'description': 'Áp dụng cho hóa đơn từ 2 món trở lên',
      },
      {
        'title': 'Free Coffee',
        'expiration': '31/12/2024',
        'description': 'Tặng 1 ly coffee miễn phí cho đơn hàng trên 100k',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Voucher'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: myVouchers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Tên Voucher'),
              subtitle: const Text('Hạn sử dụng: 31/12/2024'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyVoucherDetailPage(
                      title: 'Free Coffee',
                      expiration: '31/12/2024',
                      description:
                          'Tặng 1 ly coffee miễn phí cho đơn hàng trên 100k',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
