import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import 'package:pharmacy/shared/network/local/cache_helper.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener:(context,state){} ,
      builder:(context,state)
      {
        return Scaffold(
            appBar:AppBar(
              leading:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  onPressed:()=> ZoomDrawer.of(context)!.toggle(),
                  icon:  Icon(
                    Icons.menu_outlined,
                    color: PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                    size: 30,
                  ),
                ),
              ),
              centerTitle:true ,
              titleTextStyle:TextStyle(
                color:PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                fontWeight:FontWeightManager.bold,
                fontFamily:FontConstants.fontFamily ,
                fontSize:20.sp,
              ) ,
              title:const Text('Theme') ,
            ) ,
            body:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Light",
                        style: TextStyle(
                            color: PharmacyCubit.get(context).isDark? Colors.white:Colors.black,
                            fontSize: 20,
                            fontFamily:FontConstants.fontFamily,
                            fontWeight:FontWeightManager.bold

                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: false,
                        groupValue: PharmacyCubit.get(context).isDark,
                        onChanged: (value) {
                          PharmacyCubit.get(context).changeAppMode(value: value);
                          CacheHelper.saveData(key: 'isDark', value: value);

                        },
                        activeColor: ColorManager.buttonColor,
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text("Dark",
                        style: TextStyle(
                            color: PharmacyCubit.get(context).isDark? Colors.white:Colors.black,
                            fontSize: 20,
                          fontFamily:FontConstants.fontFamily,
                          fontWeight:FontWeightManager.bold
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: true,
                        groupValue: PharmacyCubit.get(context).isDark,
                        onChanged: (value) {
                          PharmacyCubit.get(context).changeAppMode(value: value);
                          CacheHelper.saveData(key: 'isDark', value: value);


                        },
                        activeColor: ColorManager.buttonColor,

                      ),
                    ],
                  ),
                ),
              ],
            )
        );

      } ,
    );
  }
}