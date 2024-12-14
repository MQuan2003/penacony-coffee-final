import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p_cf/database/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p_cf/screens/page/homepage.dart';
import 'package:p_cf/screens/start/signup.dart';
//import 'package:p_cf/screens/start/forget_password.dart';

import 'package:p_cf/themes/colors.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  SigninScreenState createState() => SigninScreenState();
}

class SigninScreenState extends State<Signin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserRepository _userRepository = UserRepository();
  bool _isPasswordVisible = false;

  String? _usernameError;
  String? _passwordError;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
  void _saveUserId(int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', userId); // Lưu userId vào SharedPreferences
}
  void _validateCredentials() async {
  setState(() {
    _usernameError = null;
    _passwordError = null;
  });

  // Validate username
  if (_usernameController.text.isEmpty) {
    setState(() {
      _usernameError = 'Vui lòng nhập username';
    });
  }

  // Validate password
  if (_passwordController.text.isEmpty) {
    setState(() {
      _passwordError = 'Vui lòng nhập password';
    });
  }

  // Nếu không có lỗi, kiểm tra thông tin đăng nhập
  if (_usernameError == null && _passwordError == null) {
    try {
      // Kiểm tra người dùng trong cơ sở dữ liệu
      final user = await _userRepository.loginUser(
        _usernameController.text,
        _passwordController.text,
      );

      if (user == null) {
        setState(() {
          _usernameError = 'Sai tên đăng nhập hoặc mật khẩu';
          _passwordError = 'Sai tên đăng nhập hoặc mật khẩu';
        });
      } else {
         _saveUserId(user['user_id']);
        // Chuyển sang HomeScreen nếu đăng nhập thành công
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      print('Lỗi khi đăng nhập: $e');
    }
  }
}


  Widget _buildTextField({
    required String hintText,
    //required IconData icon,
    required TextEditingController controller,
    bool isPasswordField = false,
    String? errorText,
  }) {
    return 
      Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: isPasswordField && !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText, 
          //prefixIcon: Icon(icon, color: Colors.black54),
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: _togglePasswordVisibility,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),    
         //contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          errorText: errorText,
           hintStyle: const TextStyle(
            color: AppColors.hinttext,
            fontSize: 11, // Màu bạn muốn chỉnh cho hintText
        ),
        ),
        onTap: () {
          setState(() {
            if (isPasswordField) {
              _passwordError = null;
            } else {
              _usernameError = null;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const BackButton(),
                  const SizedBox(height: 60),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Xin chào,',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Chào mừng bạn quay trở lại!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  const Padding(
                    padding: EdgeInsets.only(left: 12), // Thụt vào như ô nhập liệu
                    child: Text(
                      'Tên đăng nhập', // Nhãn cho ô nhập username
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                const SizedBox(height: 8), // Khoảng cách giữa nhãn và ô nhập
                  _buildTextField(
                    hintText: 'Tên đăng nhập',
                    //icon: Icons.email_outlined,
                    controller: _usernameController,
                    errorText: _usernameError,
                  ),
                  const SizedBox(height: 16),

                  const Padding(
                    padding: EdgeInsets.only(left: 12), // Thụt vào như ô nhập liệu
                    child: Text(
                      'Mật khẩu', // Nhãn cho ô nhập password
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Khoảng cách giữa nhãn và ô nhập
                  _buildTextField(
                    hintText: 'Mật khẩu',
                    //icon: Icons.lock_outline,
                    controller: _passwordController,
                    isPasswordField: true,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text.rich(
                        TextSpan(
                          text: 'Quên mật khẩu?',
                          style: const TextStyle(
                            color: AppColors.orangepeel,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                            },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                 Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: _validateCredentials,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Đặt bo tròn góc (nếu cần)
                        ),
                        backgroundColor: AppColors.primary, // Màu nền của button
                        padding: const EdgeInsets.symmetric(vertical: 25), // Điều chỉnh padding để tạo chiều cao cho button
                        minimumSize: const Size(double.infinity, 50), // Chiều rộng button là full và chiều cao là 50
                      ),
                      child: const Text(
                        'Đăng nhập', // Thay vì icon, bạn có thể sử dụng text ở đây
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16, // Điều chỉnh kích thước chữ
                        ),
                      ),
                    ),
                  ),
                ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text.rich(
                        TextSpan(
                          text: 'Bạn là thành viên mới? ',
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Đăng ký',
                              style: const TextStyle(
                                color: AppColors.orangepeel,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Signup(),
                                    ),
                                  );
                                                        },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
