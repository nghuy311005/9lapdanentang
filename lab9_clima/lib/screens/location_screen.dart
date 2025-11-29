import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // PHẦN QUAN TRỌNG: Thêm ảnh nền tại đây
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_weather.png'), // Gọi đúng đường dẫn
            fit: BoxFit.cover, // Chỉnh ảnh phủ kín màn hình
          ),
        ),
        constraints: const BoxConstraints.expand(), // Mở rộng full màn hình
        // Nội dung đè lên ảnh
        child: Center(
          child: Container(
            // Thêm nền mờ nhỏ để chữ dễ đọc hơn (tùy chọn)
            padding: const EdgeInsets.all(20),
            color: Colors.black54,
            child: Text(
              'Your Location:\nLat: $latitude\nLong: $longitude',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white, // Đổi màu chữ sang trắng cho nổi
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
