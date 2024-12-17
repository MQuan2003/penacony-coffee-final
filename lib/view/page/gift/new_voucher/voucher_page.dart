import 'package:flutter/material.dart';
import 'package:p_cf/controller/voucher_repository.dart';
import 'package:p_cf/view/page/gift/new_voucher/detail_new_voucher.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Voucher'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<Voucher>>(
        future: VoucherRepository().getAllVouchers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading vouchers'));
          }

          final vouchers = snapshot.data ?? [];
          if (vouchers.isEmpty) {
            return const Center(child: Text('No new vouchers available.'));
          }

          return ListView.builder(
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              final voucher = vouchers[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Icon(Icons.local_offer, color: Colors.white),
                  ),
                  title: Text(voucher.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expires: ${voucher.endDate}',
                          style: const TextStyle(color: Colors.grey)),
                      Text('Points required: ${voucher.requiredPoint}', style: const TextStyle(color: Colors.blueGrey)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherDetailPage(
                          requiredPoints: voucher.requiredPoint,
                          title: voucher.title,
                          expiration: voucher.endDate,
                          description: voucher.description, image: voucher.image,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
