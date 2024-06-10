import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:home_rent/utils/color.dart';
import 'package:home_rent/view/accont.dart';
import 'package:home_rent/view/home.dart';
import 'package:home_rent/view/reservations.dart';
import 'package:home_rent/view/saved.dart';

// ignore: must_be_immutable
class BottomNavi extends StatefulWidget {
  int selectedIndex = 0;
  BottomNavi({super.key, this.selectedIndex = 0});
  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Saved(),
    const MyReservationsPage(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.blue[300]!,
              hoverColor: Colors.blue[100]!,
              gap: 8,
              tabBorderRadius: 15,
              activeColor: AppColors.primaryColor,
              iconSize: 23,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue[100]!,
              color: Colors.black45,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.star,
                  text: 'Favourites',
                ),
                GButton(
                  text: 'Reservations',
                  icon: FontAwesomeIcons.ticketAlt,
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  widget.selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
