import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/modules/add_cart/views/addcart_screen.dart';
import '../../global_widgets/navigateandfinish.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';


class PharmacyLayoutScreen extends StatelessWidget {


   const PharmacyLayoutScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener:(context,state){},
      builder:(context,state)
      {
        var cubit = PharmacyCubit.get(context);

        return Scaffold(
          appBar:AppBar(
            centerTitle:true ,
            titleTextStyle:TextStyle(
              color: PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
              fontWeight:FontWeightManager.bold,
              fontFamily:FontConstants.fontFamily ,
              fontSize:20.sp,
            ) ,
            title:Text(cubit.titles[cubit.currentIndex]) ,
            leading:  IconButton(
                onPressed:()=> ZoomDrawer.of(context)!.toggle(),
                icon: const Icon(Icons.menu_outlined)),

            iconTheme:IconThemeData(color:PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor , size: 20.h) ,
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: ()
                {
                  navigateTo(context, const AddCartScreen());
                },
                  icon: const Icon(Icons.add_shopping_cart,))
            ],
          ) ,
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            animationCurve:Curves.fastLinearToSlowEaseIn ,
            backgroundColor:PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.buttonColor ,
            color:PharmacyCubit.get(context).isDark ? ColorManager.scaffoldDarkColor : ColorManager.white  ,

            items: const [
              Icon(Icons.home ,size: 30,),
              Icon(Icons.category ,size: 30,),
              Icon(Icons.add_box ,size: 30,),
              Icon(Icons.location_on ,size: 30,),
            ],
            height: 50.h,
            index: cubit.currentIndex,
            onTap:(index)
            {
              cubit.changeCurrentIndex(index);
            } ,
          ),
        );
      } ,
    );
  }
}
