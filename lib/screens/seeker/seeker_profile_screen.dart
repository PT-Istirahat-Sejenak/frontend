import 'package:donora_dev/providers/user_provider.dart';
import 'package:donora_dev/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seeker_profile_edit_screen.dart';
import '../../widgets/logout_confirmation_dialog.dart';

class SeekerProfileScreen extends StatelessWidget {
  const SeekerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seeker = Provider.of<UserProvider>(context).seeker;

    print("seeker?.profilePhoto manaaaa: ${seeker?.profilePhoto}");
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: const Color(0xFFC30010),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              height: 280,
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFFC30010),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Profil Anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: DecorationImage(
                      image: (seeker?.profilePhoto != null &&
                              seeker!.profilePhoto!.isNotEmpty)
                          ? NetworkImage(seeker.profilePhoto!)
                          : const AssetImage('assets/images/default_profile.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  const SizedBox(height: 10),
                  Text(
                    seeker?.name ?? 'Nama tidak ditemukan',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Profile Menu Items
            const SizedBox(height: 20),
            ProfileMenuItem(
              title: 'Ubah Profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SeekerEditProfileScreen(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              title: 'Lupa Kata Sandi',
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.seekerForgetPassword);
              },
            ),
            ProfileMenuItem(
              title: 'Pengaturan',
              onTap: () {
                
              },
            ),
            ProfileMenuItem(
              title: 'Bahasa',
              onTap: () {
                
              },
            ),
            
            // Logout Button
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFC30010), width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () async {
                    final shouldLogout = await LogoutConfirmationDialog.show(context);

                    if (shouldLogout == true) {
                      // Logout user
                      final userProvider = Provider.of<UserProvider>(context, listen: false);
                      await userProvider.logout();

                      // Arahkan ke halaman login dan hapus semua halaman sebelumnya
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.seekerLogin,
                        (route) => false,
                      );

                      // (Opsional) Snackbar konfirmasi
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil logout')),
                      );
                    }
                  },
                  child: const Text(
                    'Keluar',
                    style: TextStyle(
                      color: Color(0xFFC30010),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color.fromARGB(255, 200, 199, 199), 
          size: 35,
        ),
        onTap: onTap,
      ),
    );
  }
}