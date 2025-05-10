import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class SeekerSearchDonorPopup extends StatelessWidget {
  final VoidCallback? onOkPressed;
  
  const SeekerSearchDonorPopup({
    super.key,
    this.onOkPressed,
  });

  /// Shows the donor search popup in the center of the screen
  static Future<void> show(BuildContext context, {VoidCallback? onOkPressed}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SeekerSearchDonorPopup(onOkPressed: onOkPressed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                onPressed: () {
                  // Close the popup
                  Navigator.of(context).pop();
                  
                  // First execute the callback if provided
                  if (onOkPressed != null) {
                    onOkPressed!();
                  }
                  
                  // Then navigate back to the home screen with search flag
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.seekerHome,
                    (route) => false, // Remove all routes from stack
                    arguments: {'isSearching': true},
                  );
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
    );
  }
}