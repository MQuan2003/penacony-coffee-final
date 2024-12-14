import 'package:flutter/material.dart';
import 'package:p_cf/athu/shared_preferences.dart';
import 'package:p_cf/database/seed_data.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/start/signin.dart';
import 'package:p_cf/screens/start/welcome.dart';

import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // // Xóa cơ sở dữ liệu cũ nếu cần
  // final databasePath = await getDatabasesPath();
  // final path = join(databasePath, 'my_database.db');
  // await deleteDatabase(path);  // Xóa cơ sở dữ liệu cũ
  
  final sampleDataManager = SampleDataManager();
  await sampleDataManager.addSampleData();  // Thêm dữ liệu mẫu vào tất cả các bảng

  // Kiểm tra trạng thái đăng nhập khi ứng dụng khởi động
  final prefs = await SharedPreferences.getInstance();
  bool? loggedIn = prefs.getBool('isLoggedIn') ?? false;
  
  runApp(MyApp(isLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: isLoggedIn ? const HomeScreen() : const Welcome(), // Điều hướng theo trạng thái đăng nhập
    );
  }
}
