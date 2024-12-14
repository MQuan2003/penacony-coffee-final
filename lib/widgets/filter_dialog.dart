
import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Thêm các tùy chọn bộ lọc ở đây
          ListTile(
            title: const Text('Price Low to High'),
            onTap: () {
              // Xử lý lọc theo giá thấp đến cao
              Navigator.pop(context);  // Đóng dialog sau khi chọn
            },
          ),
          ListTile(
            title: const Text('Price High to Low'),
            onTap: () {
              // Xử lý lọc theo giá cao đến thấp
              Navigator.pop(context);  // Đóng dialog sau khi chọn
            },
          ),
          ListTile(
            title: const Text('Category: Burgers'),
            onTap: () {
              // Xử lý lọc theo category
              Navigator.pop(context);  // Đóng dialog sau khi chọn
            },
          ),
          // Bạn có thể thêm các tùy chọn bộ lọc khác ở đây
        ],
      ),
    );
  }
}
