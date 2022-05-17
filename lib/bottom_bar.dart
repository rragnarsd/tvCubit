import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tv_cubit/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _list = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

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
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                iconSize: 16.0,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.black,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: items,
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
}
