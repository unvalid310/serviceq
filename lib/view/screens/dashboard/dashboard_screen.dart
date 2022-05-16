import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/history/history_screen.dart';
import 'package:serviceq/view/screens/home/home_screen.dart';
import 'package:serviceq/view/screens/profile/profile.dart';
import 'package:serviceq/view/screens/rekomendasi/rekomendasi_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
    _pageController = PageController(
      initialPage: widget.pageIndex,
      keepPage: false,
    );

    // index menu
    _screens = [
      HomeScreen(),
      RekomendasiScreen(),
      HistoryScreen(),
      ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        extendBody: true,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
        bottomNavigationBar: SizedBox(
          // height: MediaQuery.of(context).size.height * 10 / 100,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Color(0xFF73C3F9),
            selectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(size: 30),
            unselectedItemColor: Colors.red,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: _pageIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              _barItem('Home', 0, Icons.home),
              _barItem('Rekomendasi', 1, Icons.star),
              _barItem('Histori', 2, Icons.history),
              _barItem('Profile', 3, Icons.account_circle),
            ],
            onTap: (int index) {
              _setPage(index);
            },
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(String label, int index, IconData icon) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Color(0xFFAB1E22),
          size: 20,
        ),
      ),
      label: '',
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
