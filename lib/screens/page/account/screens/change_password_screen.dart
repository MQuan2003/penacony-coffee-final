import 'package:flutter/material.dart';
import 'package:p_cf/database/repository/user_repository.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isCurrentPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _passwordStrengthMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 32),

                // Username
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _usernameController,
                  hintText: 'Enter your username',
                ),
                const SizedBox(height: 16),

                // Current Password
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Current Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _currentPasswordController,
                  hintText: 'Enter your current password',
                  isPasswordField: true,
                  isPasswordVisible: _isCurrentPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // New Password
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _newPasswordController,
                  hintText: 'Enter your new password',
                  isPasswordField: true,
                  isPasswordVisible: _isNewPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                  onChanged: _checkPasswordStrength,
                ),
                if (_passwordStrengthMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 4),
                    child: Text(
                      _passwordStrengthMessage,
                      style: TextStyle(
                        color: _passwordStrengthMessage == 'Strong Password'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Confirm Password
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Re-enter your new password',
                  isPasswordField: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onTogglePasswordVisibility: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: _changePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPasswordField = false,
    bool isPasswordVisible = false,
    void Function()? onTogglePasswordVisibility,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPasswordField && !isPasswordVisible,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        suffixIcon: isPasswordField
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: onTogglePasswordVisibility,
              )
            : null,
      ),
    );
  }

  void _checkPasswordStrength(String password) {
    final regexUpperCase = RegExp(r'[A-Z]');
    final regexLowerCase = RegExp(r'[a-z]');
    final regexNumber = RegExp(r'\d');
    final regexSpecialChar = RegExp(r'[!@#\$&*~]');

    if (password.length < 8) {
      setState(() {
        _passwordStrengthMessage = 'Password must be at least 8 characters long';
      });
    } else if (!regexUpperCase.hasMatch(password)) {
      setState(() {
        _passwordStrengthMessage = 'Password must include at least one uppercase letter';
      });
    } else if (!regexLowerCase.hasMatch(password)) {
      setState(() {
        _passwordStrengthMessage = 'Password must include at least one lowercase letter';
      });
    } else if (!regexNumber.hasMatch(password)) {
      setState(() {
        _passwordStrengthMessage = 'Password must include at least one number';
      });
    } else if (!regexSpecialChar.hasMatch(password)) {
      setState(() {
        _passwordStrengthMessage = 'Password must include at least one special character';
      });
    } else {
      setState(() {
        _passwordStrengthMessage = 'Strong Password';
      });
    }
  }

  Future<void> _changePassword() async {
    final username = _usernameController.text.trim();
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    if (_passwordStrengthMessage != 'Strong Password') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a strong password')),
      );
      return;
    }

    try {
      await UserRepository().changePassword(username, currentPassword, newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
