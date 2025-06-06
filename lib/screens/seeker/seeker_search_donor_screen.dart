import 'package:donora_dev/providers/seeker_form_provider.dart';
import 'package:donora_dev/providers/user_provider.dart';
import 'package:donora_dev/services/seeker_form_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_donor_service.dart';

class SeekerSearchDonorScreen extends StatefulWidget {
  const SeekerSearchDonorScreen({super.key});

  @override
  State<SeekerSearchDonorScreen> createState() => _SeekerSearchDonorScreenState();
}

class _SeekerSearchDonorScreenState extends State<SeekerSearchDonorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  
  String? _selectedBloodType;
  String? _selectedRhesus;
  String? _selectedUrgency;

  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];
  final List<String> _rhesusTypes = ['positive', 'negative'];
  final List<String> _urgencyLevels = ['Biasa', 'Penting', 'Mendesak'];

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Cari Pendonor Darah',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  label: 'Nama pencari',
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Lokasi',
                  controller: _locationController,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Golongan darah',
                  items: _bloodTypes,
                  value: _selectedBloodType,
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Rhesus',
                  items: _rhesusTypes,
                  value: _selectedRhesus,
                  onChanged: (value) {
                    setState(() {
                      _selectedRhesus = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildTextField(
                        label: 'Jumlah kantung',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildDropdown(
                        label: 'Urgensi',
                        items: _urgencyLevels,
                        value: _selectedUrgency,
                        onChanged: (value) {
                          setState(() {
                            _selectedUrgency = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSearchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.black),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.keyboard_arrow_down),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          // Show the search popup when button is clicked
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sedang mencari pendonor...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 120,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async {
                          final name = _nameController.text;
                          final location = _locationController.text;
                          final quantity = _quantityController.text;
                          final bloodType = _selectedBloodType;
                          final rhesus = _selectedRhesus;
                          final urgency = _selectedUrgency;
                          final body = '$name sedang butuh donor darah $bloodType$rhesus sebanyak $quantity kantong di $location. Kondisinya sekarang $urgency.';

                          final userProvider = Provider.of<UserProvider>(context, listen: false);
                          final seeker = userProvider.seeker;
                          if (seeker == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Data pengguna belum lengkap. Harap lengkapi profil terlebih dahulu.'),
                                duration: Duration(seconds: 2),
                              ),
                          );
                          return;
                          }

                          final result = await SeekerFormService().createSeeker(userId: seeker.id, bloodType: '$bloodType', title: 'Permintaan donor darah baru!', body: body);

                          final isSuccess = result['success'] == true;

                          if (isSuccess) {
                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Permintaan donor darah berhasil dikirim!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          // Close the popup
                          Navigator.of(dialogContext).pop();

                          Navigator.pushNamed(
                            context,
                            AppRoutes.seekerNav, // Make sure this route name matches your route definition                            
                            arguments: {'isSearching': true},
                          );
                          } else {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Gagal mengirim permintaan donor darah.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }                        
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB91C1C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        icon: SvgPicture.asset(
          'assets/icons/search-icon.svg',
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        label: const Text(
          'Cari Pendonor Sekarang',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB91C1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}