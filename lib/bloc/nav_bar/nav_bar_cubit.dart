import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyxl_assignment/bloc/nav_bar/nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarState.home);


  void updateNavBarIndex(NavBarState state) {
    emit(state);
  }

  int getIndex(NavBarState state) {
    switch (state) {
      case NavBarState.home:
        return 0;
      case NavBarState.wallet:
        return 1;
      case NavBarState.gift:
        return 2;
      case NavBarState.profile:
        return 3;
      default:
        return 0;
    }
  }
}
