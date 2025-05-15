import 'package:donora_dev/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'donor_home_screen.dart';
import '../education/education_screen.dart';
import '../chat/chat_screen.dart';
import 'donor_profile_screen.dart';
import 'donor_request_screen.dart';

class DonorNav extends StatefulWidget {
  final int initialIndex;
  const DonorNav({super.key, this.initialIndex = 0});

  @override
  State<DonorNav> createState() => _DonorNavState();
}

class _DonorNavState extends State<DonorNav> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    DonorHomeScreen(),
    EducationScreen(userRole: UserRole.pendonor),
    DonorRequestScreen(),
    ChatScreen(),
    DonorProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Color(0xFFB00020);
    Color unselectedColor = Colors.grey;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFF1F4F8),
                  blurRadius: 7,
                  offset: Offset(4, 7),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onTap,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
                selectedItemColor: selectedColor,
                unselectedItemColor: unselectedColor,
                selectedLabelStyle: const TextStyle(height: 1.5),
                unselectedLabelStyle: const TextStyle(height: 1.5),
                iconSize: 24,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/home-icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 0 ? selectedColor : unselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/book-04.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 1 ? selectedColor : unselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Edukasi',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.water_drop_outlined,
                        color: _selectedIndex == 2 ? selectedColor : unselectedColor),
                    label: 'Donor',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/message-icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 3 ? selectedColor : unselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Pesan',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/person-icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 4 ? selectedColor : unselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Akun',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}