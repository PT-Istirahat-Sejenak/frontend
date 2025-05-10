import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadProofDonorOverlay extends StatelessWidget {
  final Function() onClose;
  final Function(File imageFile) onImageSelected;

  const UploadProofDonorOverlay({
    super.key,
    required this.onClose,
    required this.onImageSelected,
  });

  // Method to take photo using camera
  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    
    if (photo != null && context.mounted) {
      onImageSelected(File(photo.path));
      Navigator.of(context).pop();
    }
  }
  
  // Method to select photo from gallery
  Future<void> _pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    
    if (image != null && context.mounted) {
      onImageSelected(File(image.path));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onClose,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {}, // Prevent taps from closing the overlay
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Silakan upload foto bukti donor darah",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildOptionButton(
                          icon: Icons.camera_alt_outlined,
                          text: "Ambil foto",
                          onTap: () => _takePhoto(context),
                        ),
                        const SizedBox(height: 16),
                        _buildOptionButton(
                          icon: Icons.photo_outlined,
                          text: "Pilih dari galeri",
                          onTap: () => _pickFromGallery(context),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the upload overlay
void showUploadProofDonorOverlay(BuildContext context, {required Function(File) onImageSelected}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => UploadProofDonorOverlay(
      onClose: () => Navigator.of(context).pop(),
      onImageSelected: onImageSelected,
    ),
  );
}