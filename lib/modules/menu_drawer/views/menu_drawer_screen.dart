import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';

class MenuDrawerScreen extends StatelessWidget {

  const MenuDrawerScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var userModel = PharmacyCubit.get(context).userModel;
        var profileImage = PharmacyCubit.get(context).profileImage;

        return Scaffold(
                  backgroundColor:PharmacyCubit.get(context).isDark ? ColorManager.scaffoldDarkColor :ColorManager.buttonColor,
                  body: ConditionalBuilder(
                      condition:state is! PharmacyGetUserLoadingState  ,
                      builder: (context)=>Padding(
                        padding: const EdgeInsets.symmetric(  vertical:90.0 ),
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics:const BouncingScrollPhysics() ,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 50.sp,
                                  backgroundImage:profileImage == null ? NetworkImage('${userModel!.image}') :  FileImage(profileImage) as ImageProvider,
                                ),
                                SizedBox(
                                  height:10.h ,
                                ),
                                Text('${userModel!.name}',
                                  style:TextStyle(
                                      fontWeight:FontWeightManager.bold,
                                      fontSize:15.sp,
                                      fontFamily:FontConstants.fontFamily,
                                      color:ColorManager.white
                                  ) ,
                                ),
                                SizedBox(
                                  height:5.h ,
                                ),
                                Text('${userModel.phone}',
                                  style:TextStyle(
                                      fontWeight:FontWeightManager.bold,
                                      fontSize:15.sp,
                                      fontFamily:FontConstants.fontFamily,
                                      color:ColorManager.white
                                  ) ,
                                ),
                                SizedBox(
                                  height:30.h ,
                                ),
                                builderMnue(Icons.home_outlined, 'Home', 0 , context),
                                builderMnue(Icons.person_outlined, 'Profile', 1 , context),
                                builderMnue(Icons.color_lens_outlined, 'Theme',2 , context),
                              ],
                            ),
                          ),
                        ),
                      ),
                      fallback:(context)=>const Center(child: CircularProgressIndicator(),) )
                );
              },
            );



  }

  Widget builderMnue (IconData icon , String text , int index,context  )=>ListTile(
    onTap: ()
    {
      PharmacyCubit.get(context).changeZoomDrawerIndex(index);
    },

    selectedColor:ColorManager.black ,
    minLeadingWidth: 50,
    leading:Icon(icon,
      color:ColorManager.white ,
      size:30.sp ,) ,
    title:Text(text,style: TextStyle(
        fontWeight:FontWeightManager.bold,
        fontSize:20.sp,
        fontFamily:FontConstants.fontFamily,
        color:ColorManager.white ),),

  );
}

