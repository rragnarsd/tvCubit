import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/screens/home_screen.dart';

import 'glassmorphism.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _list.elementAt(_selectedIndex),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Align(
            alignment: const Alignment(0.0, 1.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              child: GlassMorphism(
                blur: 20,
                opacity: 0.7,
                radius: BorderRadius.circular(30),
                border: Border.all(
                  width: 1.5,
                  color: Colors.brown.withOpacity(0.2),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 18.0,
                  unselectedItemColor: Colors.white.withOpacity(0.4),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  items: items,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.house),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.play),
      label: 'Play',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.heart),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.user),
      label: 'Person',
    ),
  ];

  final List<Widget> _list = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];
}
