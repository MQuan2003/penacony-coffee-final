import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      color: Colors.transparent,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          Text(
            '9:41',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          // Icons
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, color: Colors.black, size: 18),
              SizedBox(width: 6),
              Icon(Icons.wifi, color: Colors.black, size: 18),
              SizedBox(width: 6),
              Icon(Icons.battery_full, color: Colors.black, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
