import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'Username');
  final TextEditingController _fullnameController =
      TextEditingController(text: 'Full Name user');
  // ignore: unused_field
  final TextEditingController _emailController =
      TextEditingController(text: 'Email');
  final TextEditingController _dobController =
      TextEditingController(text: '2000-01-01');
  String? _selectedGender = 'Nam';

  File? _avatar;

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    }
  }

  // Hàm hiển thị DatePicker
  Future<void> _selectDate() async {
    DateTime initialDate = DateTime.tryParse(_dobController.text) ??
        DateTime.now(); // Nếu không có ngày mặc định, dùng ngày hiện tại
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = pickedDate.toIso8601String().split('T').first;
      });
    }
  }

  // Hàm xử lý cập nhật thông tin
  void _updateProfile() {
    final fullname = _fullnameController.text.trim();
    final dob = _dobController.text.trim();
    final gender = _selectedGender;

    // Kiểm tra dữ liệu hợp lệ
    if (fullname.isEmpty || dob.isEmpty || gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin!')),
      );
      return;
    }

    // Xử lý cập nhật (Gửi dữ liệu lên server hoặc lưu vào database)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cập nhật thành công!')),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        enabled: enabled,
        onTap: onTap,
        readOnly: onTap != null,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cập nhật thông tin cá nhân"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _avatar != null
                          ? FileImage(_avatar!)
                          : const AssetImage('assets/avatar_placeholder.png')
                              as ImageProvider,
                      backgroundColor: Colors.grey,
                    ),
                    IconButton(
                      onPressed: _pickImage,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Các ô nhập liệu
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Tên đăng nhập',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'Tên đăng nhập',
                controller: _usernameController,
                enabled: false,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Họ và tên',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'Nhập họ và tên',
                controller: _fullnameController,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Ngày sinh',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(
                hintText: 'VD: 2000-01-01',
                controller: _dobController,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  'Giới tính',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: ['Nam', 'Nữ', 'Khác']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Nút cập nhật
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
