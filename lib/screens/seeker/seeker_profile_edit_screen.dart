import 'package:flutter/material.dart';

class SeekerEditProfileScreen extends StatefulWidget {
  const SeekerEditProfileScreen({super.key});

  @override
  State<SeekerEditProfileScreen> createState() => _SeekerEditProfileScreenState();
}

class _SeekerEditProfileScreenState extends State<SeekerEditProfileScreen> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(text: 'Rila Najjakha');
  final TextEditingController _birthDateController = TextEditingController(text: '14-02-2005');
  final TextEditingController _emailController = TextEditingController(text: 'rila123@gmail.com');
  final TextEditingController _genderController = TextEditingController(text: 'Perempuan');
  final TextEditingController _addressController = TextEditingController(text: 'Perempuan');
  final TextEditingController _phoneController = TextEditingController(text: '08889875679');
  final TextEditingController _profilePhotoController = TextEditingController(text: 'WhatsApp image 2024-11-08');
  

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _profilePhotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Ubah Profil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black),
            onPressed: () {
              // Save profile changes and return
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Akun',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            
            // Full Name
            _buildTextField('Nama lengkap', _nameController),
            const SizedBox(height: 16),
            
            // Birth Date
            _buildTextField('Tanggal lahir', _birthDateController),
            const SizedBox(height: 16),
            
            // Email
            _buildTextField('Email', _emailController),
            const SizedBox(height: 16),
            
            // Gender
            _buildTextField('Jenis kelamin', _genderController),
            const SizedBox(height: 16),
            
            // Address
            _buildTextField('Alamat', _addressController),
            const SizedBox(height: 16),
            
            // Phone Number
            _buildTextField('No telepon', _phoneController),
            const SizedBox(height: 16),
            
            // Profile Photo
            _buildProfilePhotoField(),
            const SizedBox(height: 24),        
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto profil',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: _profilePhotoController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // Handle photo upload
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC30010),
                minimumSize: const Size(80, 48),
              ),
              child: const Text(
                'Unggah',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


}