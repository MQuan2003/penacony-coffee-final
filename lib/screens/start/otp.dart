import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p_cf/screens/start/welcome.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email; // Nhận email từ màn hình trước
  final String purpose; // Xác định ngữ cảnh sử dụng: forgot_password hoặc login

  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.purpose,
  });

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final int _resendTimeout = 30;
  Timer? _timer;
  int _currentTimer = 30;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _currentTimer = _resendTimeout;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentTimer > 0) {
          _currentTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validateOTP() {
    String otp = _controllers.map((controller) => controller.text).join();

    setState(() {
      if (otp.isEmpty) {
        _errorText = 'Vui lòng nhập mã xác thực';
      } else if (otp != '1234') { // Thay bằng logic xác thực OTP thực tế
        _errorText = 'Mã xác thực không đúng';
      } else {
        _errorText = null;

        // Xử lý thành công dựa trên ngữ cảnh (purpose)
        if (widget.purpose == 'forgot_password') {
          // Điều hướng tới màn hình đặt lại mật khẩu
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Welcome(), // Đổi sang ResetPasswordScreen
            ),
          );
        } else if (widget.purpose == 'login') {
          // Xử lý xác thực email thành công khi đăng nhập
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Welcome(),
            ),
          );
        }
      }
    });
  }

  void _resendCode() {
    if (_currentTimer == 0) {
      setState(() {
        _startTimer();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mã xác thực đã được gửi lại!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const BackButton(),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.purpose == 'forgot_password'
                    ? 'Xác thực email - Quên mật khẩu'
                    : 'Xác thực email - Đăng nhập',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Nhập mã xác thực đã được gửi đến email:\n${widget.email}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 60,
                  child: TextField(
                    controller: _controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      errorText: index == 0 && _errorText != null ? '' : null,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _errorText = null;
                      });
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                  child: Text(
                    _errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _resendCode,
                child: Text(
                  _currentTimer > 0
                      ? 'Gửi lại sau 00:${_currentTimer.toString().padLeft(2, '0')}'
                      : 'Gửi lại mã',
                  style: TextStyle(
                    color: _currentTimer > 0 ? Colors.black54 : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: _validateOTP,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFF2E4958),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
