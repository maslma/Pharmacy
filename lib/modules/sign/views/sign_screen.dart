import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/broken_icon_icons.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_features/images_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/navigateandfinish.dart';
import 'package:pharmacy/global_presentation/global_widgets/primary_textfield.dart';
import 'package:pharmacy/modules/login/views/login_screen.dart';
import 'package:pharmacy/modules/sign/cubit/cubit.dart';
import 'package:pharmacy/modules/sign/cubit/state.dart';

import '../../menu_drawer/widget/menu_drawer_widget.dart';




class SignUpScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>PharmacyRegisterCubit() ,
      child: BlocConsumer<PharmacyRegisterCubit,PharmacyRegisterStates>(
        listener: (context,state)
        {
          if(state is PharmacyCreateUserSuccessState)
          {
            navigateAndFinish(context,  const MenuDrawer());

          }
        },
        builder:(context,state)
        {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
                physics:const BouncingScrollPhysics() ,
                child: Container(
                  padding:const EdgeInsets.all(10) ,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FadeInDown(
                          delay:const Duration(milliseconds: 2500) ,
                          child: SizedBox(
                            width: 250.w,
                            height:250.h,
                            child: Image.asset(ImagesManager.backgroundSign),
                          ),
                        ),
                        FadeInLeft(
                          delay:const Duration(milliseconds: 2100) ,
                          child:  Padding(
                            padding: const EdgeInsets.only( right:230 ),
                            child: Text('Sign Up',
                              style:TextStyle(
                                  fontSize:30.sp,
                                  fontWeight:FontWeightManager.bold,
                                  fontFamily:FontConstants.fontFamily
                              ) ,
                            ),
                          ),
                        ),
                        FadeInDown(
                            delay: const Duration(milliseconds: 1800),
                            child:  RepTextFiled(
                              controller: nameController,
                              keyboardType:TextInputType.text,
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              icon: IconBroken.User,
                              text: 'Full Name',
                              sufIcon: null,
                            )),
                        SizedBox(
                          height: 8.h,
                        ),
                        FadeInDown(
                            delay:const Duration(milliseconds: 1400) ,
                            child:  RepTextFiled(
                                controller:emailController ,
                                keyboardType:TextInputType.emailAddress ,
                                validate: (String? value)
                                {
                                  if(value!.isEmpty)
                                  {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                icon: Icons.email_outlined,
                                text: 'Email',
                                sufIcon: null)),
                        SizedBox(
                          height: 8.h,
                        ),
                        FadeInDown(
                            delay: const Duration(milliseconds:1200 ),
                            child:  RepTextFiled(
                              controller:passwordController ,
                              icon: IconBroken.Password,
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              text: 'Password',
                              sufIcon: PharmacyRegisterCubit.get(context).suffix,
                              isPassword:PharmacyRegisterCubit.get(context).isPassword ,
                              suffixPressed:()
                              {
                                PharmacyRegisterCubit.get(context).changePasswordVisibility();
                              } ,
                              keyboardType: TextInputType.visiblePassword,)),
                        SizedBox(
                          height: 8.h,
                        ),
                        FadeInDown(
                            delay: const Duration(milliseconds: 1000),
                            child:  RepTextFiled(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validate: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              icon: IconBroken.Call,
                              text: 'Mobile',
                              sufIcon: null,
                            )),
                        SizedBox(
                          height: 18.h,
                        ),
                        FadeInDown(
                          delay:const Duration(milliseconds:800 ) ,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            child: RichText(
                              text: TextSpan(
                                  text: "By siging up, you're agree to our",
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 90, 90, 90),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " Terms & Conditions",
                                      style: TextStyle(color: ColorManager.buttonColor),
                                    ),
                                    const TextSpan(
                                      text: " and ",
                                      style: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
                                    ),
                                    TextSpan(
                                      text: " Privacy Policy",
                                      style: TextStyle(color: ColorManager.buttonColor),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 400),
                          child: ConditionalBuilder(
                            condition: state is! PharmacyRegisterLoadingState,
                            builder: (BuildContext context)=>Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              width:double.infinity ,
                              height:45.h ,
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  if(formKey.currentState!.validate()) {
                                    PharmacyRegisterCubit.get(context)
                                        .userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                style:ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                                  backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                                ) ,
                                child: const Text('Sign Up'),
                              ),
                            ),
                            fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                          ),
                        ),
                        FadeInDown(
                          child: GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 200.w,
                              height: 15.h,
                              child: FittedBox(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Joined us before?",
                                    style: TextStyle(color: ColorManager.grey2),
                                    children: [
                                      TextSpan(
                                        text: "  Login",
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
            ),
          );
        } ,
      ),
    );
  }
}

