import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import '../views/menu_drawer_screen.dart';

class MenuDrawer extends StatelessWidget {

  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener:(context,state){} ,
      builder:(context,state){

        var cubit = PharmacyCubit.get(context);

        return Container(
          color: PharmacyCubit.get(context).isDark ? ColorManager.scaffoldDarkColor :ColorManager.buttonColor,
          child: ZoomDrawer(
            style: DrawerStyle.defaultStyle,
            menuScreen:  const MenuDrawerScreen(),
            mainScreen: cubit.zoomDrawerScreen[cubit.zoomDrawerIndex],
            borderRadius: 24.0,
            showShadow: true,
            drawerShadowsBackgroundColor: ColorManager.white,
            openCurve: Curves.fastOutSlowIn,
            closeCurve: Curves.bounceIn,
          ),
        );
      } ,
    );
  }

}
