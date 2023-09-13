import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'page_a1.dart';
import 'page_b1.dart';
import 'page_c1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 탭바 사용을 위한 컨트롤러 선언
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,  // 컨트롤러
      screens: _buildScreens(), // 탭바를 눌렀을 때 변경될 페이지설정
      items: _navBarsItems(),   // 네비바 아이템 설정
      confineInSafeArea: true,  // 네비바를 안전영역에 둔다.
      backgroundColor: Colors.deepPurple.shade100,
      handleAndroidBackButtonPress: true,
      // 키보드가 나타날때 화면을 위로 이동하는 경우 이 조건이 충족되어야 한다.
      resizeToAvoidBottomInset: true,
      stateManagement: true,  // 각 화면 상태유지
      // 크기조정을 설정하는것이 좋다. 하단을 피하려면 이 인수를 사용할 때
      // inset이 true로 표시된다.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      // 네비바의 버튼을 눌렀을 때 전환효과
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      // 화면 전환시의 애니메이션 효과
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,  // false이면 비활성화
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle: NavBarStyle.style7,
    );
  }
  // 챕바를 클릭했을 때 처리될 페이지 선언
  List<Widget> _buildScreens() {
    return [
      const PageA1(),
      const PageB1(),
      const PageC1(),
    ];
  }
  // 탭메뉴의 버튼생성 및 설정
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.yellow,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ('Search'),
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: ('Add'),
        activeColorPrimary: Colors.blue,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
