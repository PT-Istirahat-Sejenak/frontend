import 'package:donora_dev/models/user_role.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/back_button.dart';
import '../../../providers/auth_donor_provider.dart';
import '../../../routes/app_routes.dart';

class DonorRegisterScreen2 extends StatefulWidget {
  final String name;
  final String dateOfBirth;
  final String email;
  final String gender;
  final String address;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final File? profileImage;

  const DonorRegisterScreen2({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.email,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    this.profileImage,
  });

  @override
  State<DonorRegisterScreen2> createState() => _DonorRegisterScreen2State();
}

class _DonorRegisterScreen2State extends State<DonorRegisterScreen2> {
  String? _bloodType;
  String? _rhesus;

  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];
  final List<String> _rhesusTypes = ['positive', 'negative'];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthDonorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Donor',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                        hint: 'Golongan Darah',
                        value: _bloodType,
                        items: _bloodTypes,
                        onChanged: (val) => setState(() => _bloodType = val),
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                        hint: 'Rhesus',
                        value: _rhesus,
                        items: _rhesusTypes,
                        onChanged: (val) => setState(() => _rhesus = val),
                      ),
                      const SizedBox(height: 550),
                      _buildButtons(context, authProvider),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const BackButtonWidget(),
          const SizedBox(width: 8),
          const Text(
            'Buat Akun Pendonor',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 4,
      width: double.infinity,
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(flex: 1, child: Container(color: const Color(0xFFB00020))),
          Expanded(flex: 1, child: Container(color: const Color(0xFFB00020))),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(hint),
          ),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context, AuthDonorProvider authProvider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3B30),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'KEMBALI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryButton(
            text: authProvider.isLoading ? 'MEMPROSES...' : 'SIMPAN',
            onPressed: authProvider.isLoading ? null : _handleSubmit,
          ),
        ),
      ],
    );
  }

  void _handleSubmit() async {
    final authProvider = Provider.of<AuthDonorProvider>(context, listen: false);

    if (_bloodType == null || _rhesus == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap pilih golongan darah dan rhesus')),
      );
      return;
    }

    final success = await authProvider.register(
      name: widget.name,
      dateOfBirth: widget.dateOfBirth,
      email: widget.email,
      gender: widget.gender,
      address: widget.address,
      phoneNumber: widget.phoneNumber,
      password: widget.password,
      confirmPassword: widget.password,
      role: UserRole.pendonor,
      bloodType: _bloodType!,
      rhesus: _rhesus!,
      profileImage: widget.profileImage,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Akun berhasil dibuat')),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.donorNav,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran gagal, coba lagi.')),
      );
    }
  }
}
