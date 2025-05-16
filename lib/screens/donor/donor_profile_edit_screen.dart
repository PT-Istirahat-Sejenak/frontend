import 'package:donora_dev/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_dropdown_field.dart';

class DonorEditProfileScreen extends StatefulWidget {
  const DonorEditProfileScreen({super.key});

  @override
  State<DonorEditProfileScreen> createState() => _DonorEditProfileScreenState();
}

class _DonorEditProfileScreenState extends State<DonorEditProfileScreen> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();
  
  String _bloodType = '';
  String _rhesus = '';

  XFile? _profileImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final donor = Provider.of<UserProvider>(context, listen: false).donor;

      if (donor != null) {
        _nameController.text = donor.name;
        _birthDateController.text = donor.dateOfBirth ?? '';
        _emailController.text = donor.email;
        _genderController.text = donor.gender?? '';
        _addressController.text = donor.address ?? '';
        _phoneController.text = donor.phoneNumber ?? '';
        _profilePhotoController.text = donor.profilePhoto ?? '';
        _bloodType = donor.bloodType ?? '';
        _rhesus = donor.rhesus ?? '';
      }
    });
  }

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

    void _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = picked;
        _profilePhotoController.text = picked.path.split('/').last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(        
        backgroundColor: Colors.white,
        leadingWidth: 40, // Mengurangi lebar area leading
        titleSpacing: 12, // Menghilangkan spasi default antara leading dan title
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 24),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
          ),
        ),
        title: const Text(
          'Ubah Profil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              onPressed: () {
                // Save profile changes and return
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
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
            const SizedBox(height: 24),
            
            // Birth Date
            _buildTextField('Tanggal lahir', _birthDateController),
            const SizedBox(height: 24),
            
            // Email
            _buildTextField('Email', _emailController),
            const SizedBox(height: 24),
            
            // Gender
            _buildTextField('Jenis kelamin', _genderController),
            const SizedBox(height: 24),
            
            // Address
            _buildTextField('Alamat', _addressController),
            const SizedBox(height: 24),
            
            // Phone Number
            _buildTextField('No telepon', _phoneController),
            const SizedBox(height: 24),
            
            // Profile Photo
            _buildProfilePhotoField(),
            const SizedBox(height: 20),
            
            // Blood Type Section
            const Text(
              'Data Golongan Darah',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            
            // Blood Type
            _buildDropdownField('Golongan darah', _bloodType, ['A', 'B', 'AB', 'O']),
            const SizedBox(height: 16),
            
            // Rhesus
            _buildDropdownField('Rhesus', _rhesus, ['positive', 'negative']),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return CustomTextField(
      label: label,
      controller: controller,
      isPassword: isPassword,
    );
  }

  Widget _buildProfilePhotoField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              label: 'Unggah foto profil',
              controller: _profilePhotoController,
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB00020),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Unggah',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> options) {
    return CustomDropdownField(
      label: label,
      value: options.contains(value) ? value : null,
      options: options,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            if (label == 'Golongan darah') {
              _bloodType = newValue;
            } else if (label == 'Rhesus') {
              _rhesus = newValue;
            }
          });
        }
      },
    );
  }

}