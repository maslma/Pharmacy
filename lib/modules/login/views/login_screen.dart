// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/broken_icon_icons.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/primary_textfield.dart';
import 'package:pharmacy/modules/login/cubit/state.dart';
import 'package:pharmacy/shared/network/local/cache_helper.dart';
import '../../../global_presentation/global_features/images_manager.dart';
import '../../../global_presentation/global_widgets/navigateandfinish.dart';
import '../../../global_presentation/global_widgets/showtoast_widget.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../menu_drawer/widget/menu_drawer_widget.dart';
import '../../sign/views/sign_screen.dart';
import '../cubit/cubit.dart';



class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>PharmacyLoginCubit(),
      child: BlocConsumer<PharmacyLoginCubit,PharmacyLoginStates>(
        listener:(context,state)
        {
          if(state is PharmacyLoginErrorState)
          {
            showToast(
                text: state.error ,
                state: ToastStatus.ERROR
            );
          }
          if(state is PharmacyLoginSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value:state.uId
            ).then((value){

              navigateAndFinish(context, const MenuDrawer());
            });
          }


        } ,
        builder:(context,state)
        {


          return  Scaffold(
            body:SingleChildScrollView(
              physics:const BouncingScrollPhysics() ,
              child: Container(
                padding:const EdgeInsets.all(10) ,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FadeInDown(
                        delay:const Duration(milliseconds: 3800) ,
                        child: SizedBox(
                          width: 250.w,
                          height:250.h,
                          child: Image.asset(ImagesManager.backgroundLogin),
                        ),
                      ),
                      FadeInLeft(
                        delay:const Duration(milliseconds: 3200) ,
                        child:  Padding(
                          padding: const EdgeInsets.only( right:250 ),
                          child: Text('LOGIN',
                            style:TextStyle(
                                fontSize:30.sp,
                                fontWeight:FontWeightManager.bold,
                                fontFamily:FontConstants.fontFamily,
                            ) ,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      FadeInDown(
                          delay:const Duration(milliseconds: 2900) ,
                          child: RepTextFiled(
                            icon: Icons.email_outlined,
                            text: 'Email',
                            sufIcon: null,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                          delay: const Duration(milliseconds: 2300),
                          child:  RepTextFiled(
                            controller:passwordController ,
                            icon: IconBroken.Password,
                            text: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            validate: (String? value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            sufIcon: PharmacyLoginCubit.get(context).suffix,
                            isPassword:PharmacyLoginCubit.get(context).isPassword ,
                            suffixPressed:()
                            {
                              PharmacyLoginCubit.get(context).changePasswordVisibility();
                            } ,
                          )),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1800),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top:20 ,left: 200),
                            child: Text('Forgot Password?',
                              style:TextStyle(
                                  color:ColorManager.buttonColor,
                                  fontWeight:FontWeightManager.bold
                              ) ,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1400),
                        child: ConditionalBuilder(
                          condition: state is! PharmacyLoginLoadingState,
                          builder: (BuildContext context)=>Container(
                            padding:  const EdgeInsets.symmetric(horizontal: 5),
                            width:double.infinity ,
                            height:45.h ,
                            child: ElevatedButton(
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  PharmacyLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }

                              },
                              style:ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                                backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                              ) ,
                              child: const Text('Login'),
                            ),
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 1000),
                        child: SizedBox(
                          width:double.infinity ,
                          child: Center(
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                              children: [
                                Container(width: 150.w, height: 0.5.h , color:ColorManager.iconColor ,),
                                const Text('  OR  ',
                                  style:TextStyle(
                                      color:ColorManager.iconColor,
                                      fontWeight:FontWeightManager.bold
                                  ) ,
                                ),
                                Container(width: 150.w, height: 0.5.h , color:ColorManager.iconColor ,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      FadeInDown(
                        delay: const Duration(milliseconds: 600),
                        child: Container(
                          padding:  const EdgeInsets.symmetric(horizontal: 5),
                          width:double.infinity ,
                          height:45.h ,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                ColorManager.buttonColor.withOpacity(0.2),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),),
                              backgroundColor:  MaterialStateProperty.all(const Color.fromARGB(255, 220, 220, 220)),
                            ),
                            onPressed: ()async
                            {
                                PharmacyLoginCubit.get(context).signInWithGoogle(context,);

                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30.w,
                                ),
                                SizedBox(
                                  width: 40.w,
                                  height: 40.h,
                                  child: Image.asset(ImagesManager.googleLogo),
                                ),
                                SizedBox(
                                  width: 40.w,
                                ),
                                Text(
                                  "Login with Google",
                                  style: TextStyle(
                                      color: ColorManager.grey2
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FadeInDown(
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUpScreen()));

                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 200.w,
                            height: 15.h,
                            child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                  text: "New to Logistic?",
                                  style: TextStyle(color: ColorManager.grey2),
                                  children: [
                                    TextSpan(
                                      text: "  Register",
                                      style: TextStyle(
                                        color:ColorManager.buttonColor,
                                        fontWeight: FontWeightManager.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
