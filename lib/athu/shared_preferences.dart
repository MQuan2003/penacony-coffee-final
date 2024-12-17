import 'package:p_cf/controller/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final UserRepository _userRepository = UserRepository();

  // Kiểm tra và lưu trạng thái đăng nhập
  Future<bool> login(String username, String password) async {
    final user = await _userRepository.loginUser(username, password);
    if (user != null) {
      // Lưu thông tin đăng nhập vào SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true); // Lưu trạng thái đăng nhập
      await prefs.setString('username', username); // Lưu tên đăng nhập
      return true;
    } else {
      return false;
    }
  }

  // Đăng xuất và xóa thông tin đăng nhập
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Xóa trạng thái đăng nhập
    await prefs.remove('username'); // Xóa tên đăng nhập
  }

  // Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
