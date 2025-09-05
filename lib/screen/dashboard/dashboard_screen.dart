import 'package:flutter/material.dart';
import 'package:mandir/screen/blog/blog_screen.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/screen/notification/notification_screen.dart';
import 'package:mandir/screen/profile/profile_screen.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/widgets.dart';

/// Todo new bottomNavigationBar
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<NavigationItem> _items = [
    NavigationItem('assets/icons/home.png', Text('Home'), 0),
    NavigationItem('assets/icons/dashboard_outline.png', Text('Blog'), 0),
    NavigationItem('assets/icons/notification_outline.png', Text('Notification'), 0),
    NavigationItem('assets/icons/user_outline.png', Text('Profile'), 0),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _key,
        // backgroundColor: ThemeColor.primaryColor,
        body: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            switch (position) {
              case 0:
                return HomeScreen();
              case 1:
                return BlogScreen();
              case 2:
                return NotificationScreen();
              case 3:
                return ProfileScreen();
              default:
                return HomeScreen();
            }
          },
          itemCount: 4,
        ),
        bottomNavigationBar: _bottomNav(),
      ),
    );
  }

  void openDrawer() {
    _key.currentState?.openDrawer();
  }

  Widget _bottomNav() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _items.map((item) {
          var itemIndex = _items.indexOf(item);
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = itemIndex;
                _pageController.jumpToPage(_selectedIndex);
              });
            },
            child: navItem(item, _selectedIndex == itemIndex),
          );
        }).toList(),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
        _pageController.jumpToPage(_selectedIndex);
      });
    } else {
      Helper.exitAlert();
    }
    return false;
  }
}

class NavigationItem {
  final String icon;
  final Text title;
  final int count;

  NavigationItem(this.icon, this.title, this.count);
}
