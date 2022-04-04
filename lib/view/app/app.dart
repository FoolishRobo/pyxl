import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/nav_bar/nav_bar_cubit.dart';
import 'package:pyxl_assignment/bloc/nav_bar/nav_bar_state.dart';
import 'package:pyxl_assignment/models/user/user.dart';
import 'package:pyxl_assignment/utils/colors/colors.dart';
import 'package:pyxl_assignment/view/app/gifts_page/gifts_page.dart';
import 'package:pyxl_assignment/view/app/home_page/home_page.dart';
import 'package:pyxl_assignment/view/app/profile_page/profile_page.dart';
import 'package:pyxl_assignment/view/app/wallet_page/wallet_page.dart';

class App extends StatefulWidget {
  final User? user;
  App(this.user);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late List<Widget> _pages;

  PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    _pages = [
      HomePage(user: widget.user),
      WalletPage(user: widget.user),
      GiftsPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (cubitContext, navBarState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: _pages,
                  ),
                )),
                _bottomNavBar(navBarState, cubitContext),
                // vSpace(20),
              ],
            ),
          );
        },
      ),
    ));
  }

  Widget _bottomNavBar(NavBarState navBarState, BuildContext cubitContext) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bottomNavItem(0, "assets/icons/Home.png", navBarState, cubitContext),
          _bottomNavItem(
              1, "assets/icons/Wallet.png", navBarState, cubitContext),
          _bottomNavItem(2, "assets/icons/Gift.png", navBarState, cubitContext),
          _bottomNavItem(
              3, "assets/icons/Profile.png", navBarState, cubitContext),
        ],
      ),
    );
  }

  Widget _bottomNavItem(int index, String assets, NavBarState navBarState,
      BuildContext cubitContext) {
    return GestureDetector(
      onTap: () {
        _controller.animateToPage(index,
            duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
        BlocProvider.of<NavBarCubit>(cubitContext)
            .updateNavBarIndex(NavBarState.values[index]);
      },
      child: Container(
        height: 50,
        width: 50,
        color: Colors.transparent,
        child: Center(
          child: Image.asset(
            assets,
            height: 25,
            width: 25,
            color: navBarState.index == index ? primaryColor : null,
          ),
        ),
      ),
    );
  }
}
