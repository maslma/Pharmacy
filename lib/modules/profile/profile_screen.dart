// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:pharmacy/global_presentation/global_features/broken_icon_icons.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/primary_textfield.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';


class ProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener:(context,state) {},
      builder: (context,state){

        var userModel = PharmacyCubit.get(context).userModel;
        var profileImage = PharmacyCubit.get(context).profileImage;

        nameController.text=userModel!.name!;
        phoneController.text=userModel.phone!;
        emailController.text=userModel.email!;

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
            title:const Text('Profile') ,
          ) ,
          body: ConditionalBuilder(
              condition:state is! PharmacyGetUserSuccessState ,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics:const BouncingScrollPhysics() ,
                  child: Column(
                    children: [
                      if(state is PharmacyUserUpdateLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1000),
                        child: Center(
                          child: Stack(
                            alignment:AlignmentDirectional.bottomEnd ,
                            children:[
                              CircleAvatar(
                                radius:68 ,
                                backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null ? NetworkImage('${userModel.image}') :  FileImage(profileImage) as ImageProvider,
                                  radius:65.0 ,
                                ),
                              ),
                              IconButton(
                                color: PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                                onPressed: ()
                                {
                                  PharmacyCubit.get(context).getProfileImage();
                                },
                                icon:  CircleAvatar(
                                  radius:25.0 ,
                                  child: Icon(IconBroken.Camera,
                                    size:20 ,
                                    color:PharmacyCubit.get(context).isDark ? ColorManager.buttonColor :ColorManager.white,
                                  ),

                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1100),
                        child: TextButton(onPressed: ()
                        {
                          PharmacyCubit.get(context).uploadProfileImage(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        },
                            child:  Text('Edit Image',
                              style:TextStyle(
                                  color:ColorManager.buttonColor,
                                  fontWeight: FontWeightManager.bold,
                                  fontFamily: FontConstants.fontFamily

                              ) ,
                            )

                        ),
                      ),
                      SizedBox(
                        height:30.h ,
                      ),
                      FadeInDown(
                          delay: const Duration(milliseconds: 1200),
                          child:  RepTextFiled(
                            controller: nameController,
                            keyboardType:TextInputType.text,
                            icon: Icons.person,
                            text: ' Name',
                            sufIcon: null,
                          )),
                      SizedBox(
                        height:20.h ,
                      ),
                      FadeInDown(
                          delay: const Duration(milliseconds: 1400),
                          child:   RepTextFiled(
                            controller: emailController,
                            keyboardType:TextInputType.emailAddress,
                            icon: Icons.email,
                            text: ' Email',
                            sufIcon: null,
                          )),
                      SizedBox(
                        height:20.h ,
                      ),
                      FadeInDown(
                          delay: const Duration(milliseconds: 1600),
                          child:   RepTextFiled(
                            controller: phoneController,
                            keyboardType:TextInputType.phone,
                            icon: Icons.call,
                            text: 'Mobile',
                            sufIcon: null,
                          )),
                      SizedBox(
                        height:50.h ,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1800),
                        child: ConditionalBuilder(
                          condition: true,
                          builder: (BuildContext context)=>Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width:double.infinity ,
                            height:45.h ,
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                PharmacyCubit.get(context).updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );
                              },
                              style:ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                                backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                              ) ,
                              child: const Text('Update Profile'),
                            ),
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                        ),
                      ),
                      SizedBox(
                        height:20.h,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 2000),
                        child: ConditionalBuilder(
                          condition: true,
                          builder: (BuildContext context)=>Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            width:double.infinity ,
                            height:45.h ,
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                PharmacyCubit.get(context).signOut(context);
                              },
                              style:ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                                backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                              ) ,
                              child: const Text('Log Out'),
                            ),
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator(),))
        );
      },

    );
  }
}



