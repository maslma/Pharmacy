// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/broken_icon_icons.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_features/images_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/primary_textfield.dart';
import 'package:pharmacy/modules/login/views/login_screen.dart';
import '../sign/cubit/cubit.dart';

class ResetPasswordScreen extends StatelessWidget {

  var passwordController = TextEditingController();

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading:IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2,
                color:ColorManager.black ,
                size:25 ,
              )) ,
        ) ,
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics() ,
          child: Container(
            padding:const EdgeInsets.all(10),
            child: Column(
              children: [
                FadeInDown(
                  delay:const Duration(milliseconds: 1800) ,
                  child: SizedBox(
                    width: 250.w,
                    height:250.h,
                    child: Image.asset(ImagesManager.backgroundReset),
                  ),
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 1400),
                  child: Container(
                    margin: const EdgeInsets.only(right: 160,),
                    child:  FittedBox(child: Text(
                      "Reset\nPassword",
                      style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    ),
                  ),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                FadeInDown(
                    delay:const Duration(milliseconds: 600) ,
                    child:  RepTextFiled(
                      controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                        text: 'New Password',
                        sufIcon:  PharmacyRegisterCubit.get(context).suffix)),
                 SizedBox(
                  height: 15.h,
                ),
                FadeInDown(
                    delay:const Duration(milliseconds: 600) ,
                    child:  RepTextFiled(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                        text: 'Confirm new Password',
                        sufIcon: null)),
                 SizedBox(
                  height: 50.h,
                ),
                FadeInDown(
                  delay: const Duration(microseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width:double.infinity ,
                    height:45.h ,
                    child: ElevatedButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>   LoginScreen()));

                      },
                      style:ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                        backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                      ) ,
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
