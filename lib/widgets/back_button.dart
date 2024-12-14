import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Quay lại màn hình trước đó
      },
      child: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
    );
  }
}
