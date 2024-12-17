// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// import 'package:p_cf/screens/start/otp.dart';
// import 'package:p_cf/themes/colors.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
// }

// class ForgotPasswordScreenState extends State<ForgotPassword> {
//   final TextEditingController _emailController = TextEditingController();
//   String? _emailError;

//   void _validateEmail() {
//     setState(() {
//       _emailError = null;

//       // Biểu thức RegExp để kiểm tra email
//       final emailRegex =
//           RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

//       if (_emailController.text.isEmpty ||
//           !emailRegex.hasMatch(_emailController.text)) {
//         _emailError = 'Email không hợp lệ';
//       } else if (_emailController.text != Credentials.email) {
//         _emailError = 'Email không tồn tại trong hệ thống';
//       } else {
//         // Thực hiện gửi email khôi phục mật khẩu
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const OTPVerificationScreen(
//               email: 'user@example.com', // Email từ màn hình trước
//               purpose: 'forgot_password',
//             ),
//           ),
//         );

//         print(
//             'Email khôi phục mật khẩu đã được gửi tới: ${_emailController.text}');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 60),
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Quên mật khẩu?',
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(
//                       'Nhập email của bạn để nhận liên kết khôi phục mật khẩu.',
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 32),

//                   // Email field
//                   const Padding(
//                     padding: EdgeInsets.only(left: 12),
//                     child: Text(
//                       'Email',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         hintText: 'Email',
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 18, horizontal: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide:
//                               BorderSide(color: Colors.grey.shade300, width: 1),
//                         ),
//                         errorText: _emailError,
//                         hintStyle: const TextStyle(
//                           color: AppColors.hinttext,
//                           fontSize: 11,
//                         ),
//                       ),
//                       onTap: () {
//                         setState(() {
//                           _emailError = null;
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16),

//                   // Reset password button
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20),
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: ElevatedButton(
//                         onPressed: _validateEmail,
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor:
//                               AppColors.primary, // Màu nền của button
//                           padding: const EdgeInsets.symmetric(vertical: 25),
//                           minimumSize: const Size(double.infinity, 50),
//                         ),
//                         child: const Text(
//                           'Gửi',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Back to login
//                   Padding(
//                     padding: const EdgeInsets.only(top: 60),
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Text.rich(
//                         TextSpan(
//                           text: 'Nhớ mật khẩu rồi? ',
//                           style: const TextStyle(color: Colors.black),
//                           children: [
//                             TextSpan(
//                               text: 'Đăng nhập',
//                               style: const TextStyle(
//                                 color: AppColors.orangepeel,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.pop(
//                                       context); // Quay lại trang đăng nhập
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
