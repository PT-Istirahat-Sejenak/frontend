import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/back_button.dart';
import 'donor_register_screen2.dart';

class DonorRegisterScreen extends StatefulWidget {
  const DonorRegisterScreen({super.key});

  @override
  State<DonorRegisterScreen> createState() => _DonorRegisterScreenState();
}

class _DonorRegisterScreenState extends State<DonorRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  File? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  bool validateStep1(BuildContext context) {
  if (_nameController.text.isEmpty ||
      _birthDateController.text.isEmpty ||
      _emailController.text.isEmpty ||
      _genderController.text.isEmpty ||
      _addressController.text.isEmpty ||
      _phoneController.text.isEmpty ||
      _passwordController.text.isEmpty ||
      _confirmPasswordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Harap isi semua bidang')),
    );
    return false;
  }

  if (_passwordController.text != _confirmPasswordController.text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kata sandi tidak cocok')),
    );
    return false;
  }

  return true;
}

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
              ),
              child: Row(
                children: const [
                  BackButtonWidget(),
                  SizedBox(width: 8),
                  Text(
                    'Buat Akun Pendonor',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Progress bar
            Container(
              height: 4,
              width: double.infinity,
              color: Colors.grey[300],
              child: Row(
                children: [
                  Expanded(flex: 1, child: Container(color: const Color(0xFFB00020))),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Data Akun', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    CustomTextField(label: 'Nama lengkap', controller: _nameController),
                    const SizedBox(height: 12),

                    // Birth date
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          _birthDateController.text =
                              "${picked.day}/${picked.month}/${picked.year}";
                          setState(() {});
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          label: 'Tanggal lahir',
                          controller: _birthDateController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 12),

                    // Gender picker
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Laki-laki'),
                                onTap: () {
                                  _genderController.text = 'Laki-laki';
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Perempuan'),
                                onTap: () {
                                  _genderController.text = 'Perempuan';
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          label: 'Jenis Kelamin',
                          controller: _genderController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(label: 'Alamat', controller: _addressController),
                    const SizedBox(height: 12),

                    CustomTextField(label: 'No Telepon', controller: _phoneController),
                    const SizedBox(height: 12),

                    // Upload profile image
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Unggah foto profil',
                            controller: TextEditingController(
                              text: _profileImage != null
                                  ? _profileImage!.path.split('/').last
                                  : '',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB00020),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Unggah', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      label: 'Kata sandi',
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 12),

                    CustomTextField(
                      label: 'Konfirmasi kata sandi',
                      controller: _confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 24),

                    PrimaryButton(
                      text: 'LANJUT',
                      onPressed: () {
                        // Validasi
                        if (_nameController.text.isEmpty ||
                            _birthDateController.text.isEmpty ||
                            _emailController.text.isEmpty ||
                            _genderController.text.isEmpty ||
                            _addressController.text.isEmpty ||
                            _phoneController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _confirmPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Harap isi semua bidang')),
                          );
                          return;
                        }

                        if (_passwordController.text != _confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Kata sandi tidak cocok')),
                          );
                          return;
                        }

                        // Navigasi ke halaman berikut
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DonorRegisterScreen2(
                              name: _nameController.text,
                              dateOfBirth: _birthDateController.text,
                              email: _emailController.text,
                              gender: _genderController.text,
                              address: _addressController.text,
                              phoneNumber: _phoneController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmPasswordController.text,
                              profileImage: _profileImage,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
