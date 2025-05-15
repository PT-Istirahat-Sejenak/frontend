import 'package:donora_dev/screens/seeker/seeker_search_donor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/user_role.dart';

import 'seeker_home_screen.dart';
import '../education/education_screen.dart';
import '../chat/chat_screen.dart';
import 'seeker_profile_screen.dart';

class SeekerNav extends StatefulWidget {
  final int initialIndex;
  const SeekerNav({super.key, this.initialIndex = 0});

  @override
  State<SeekerNav> createState() => _SeekerNavState();
}

class _SeekerNavState extends State<SeekerNav> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    SeekerHomeScreen(),
    EducationScreen(userRole: UserRole.pencari),
    SeekerSearchDonorScreen(),
    ChatScreen(),
    SeekerProfileScreen(),    
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
            height: 75, // lebih optimal
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
                selectedLabelStyle: const TextStyle(height: 1.5), // height kecilin
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
                    icon: SvgPicture.asset(
                      'assets/icons/search-icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 2 ? selectedColor : unselectedColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: 'Cari',
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