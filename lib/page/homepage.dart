import 'package:flutter/material.dart';
import 'package:serumpun_sebalai/page/beranda.dart';
import 'package:serumpun_sebalai/page/beritapage.dart';
import 'package:serumpun_sebalai/page/data.dart';
import 'package:serumpun_sebalai/page/data_test.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomeScreen';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _changeSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Beranda(),
    const Data(),
    // DataTest(),
    const BeritaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(255, 47, 87, 133),
              blurRadius: 5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart_outlined),
              label: 'Data',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_outlined),
              label: 'Berita',
            ),
          ],
          elevation: 2,
          currentIndex: _selectedIndex,
          backgroundColor: const Color.fromARGB(255, 85, 143, 209),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xFF83b0de),
          showUnselectedLabels: true,
          onTap: _changeSelectedIndex,
        ),
      ),
      // backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   color: const Color(0xFF5b8fcb),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13),
      //     child: GNav(
      //       backgroundColor: const Color(0xFF5b8fcb),
      //       color: Colors.white,
      //       activeColor: Colors.white,
      //       tabBackgroundColor: const Color(0xFF83b0de),
      //       padding: EdgeInsets.all(10),
      //       gap: 8,
      //       onTabChange: (index) {
      //         setState(() {
      //           _selectedIndex = index;
      //         });
      //       },
      //       tabs: const [
      //         GButton(
      //           icon: Icons.home_outlined,
      //           text: 'Beranda',
      //         ),
      //         GButton(
      //           icon: Icons.table_chart_outlined,
      //           text: 'Data',
      //         ),
      //         GButton(
      //           icon: Icons.newspaper_outlined,
      //           text: 'Berita',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
