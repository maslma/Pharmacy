// ignore_for_file: avoid_print

import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/navigateandfinish.dart';

import '../../login/views/login_screen.dart';
import '../data/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  List<ConcentricModel> concentrics = [
    ConcentricModel(
      lottie: "https://assets8.lottiefiles.com/packages/lf20_0Drkxs.json",
      text: "Get appointment",
    ),
    ConcentricModel(
      lottie: "https://assets6.lottiefiles.com/packages/lf20_otmfyizb.json",
      text: "Find the doctor",
    ),
    ConcentricModel(
      lottie: "https://assets8.lottiefiles.com/packages/lf20_pk5mpw6j.json",
      text: "Feel healthy",
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: ConcentricPageView(
          itemCount: concentrics.length,
          curve:Curves.linearToEaseOut ,
          onChange: (int index)
          {
            if(index == concentrics.length - 1)
            {
              setState(()
              {
                isLast = true;
              });
              print('Last');
            }else{
              print(' not Last');
              setState(()
              {
                isLast = false;
              });
            }
          },
          onFinish:()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          } ,
          colors:<Color>
            [
              ColorManager.blue,
              ColorManager.greenAccent,
              ColorManager.green

            ],
          itemBuilder: (int index)
          {
            return Column(
              children:[
                Align(
                  alignment:Alignment.topRight ,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20 , right: 20),
                    child: GestureDetector(
                      onTap: ()
                      {
                        navigateTo(context, LoginScreen());
                      },
                      child: Text('SKIP',
                      style:TextStyle(
                        color:ColorManager.black,
                        fontSize:20,
                        fontWeight:FontWeightManager.bold,
                      ) ,
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  height: 350.h,
                  width: 250.w,
                  child:
                  Lottie.network(concentrics[index].lottie,animate: true),
                ),
                Text(concentrics[index].text,
                textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    color:ColorManager.black,
                    fontSize: 30.sp,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 15.0),
                child: Text('${index + 1 } / ${concentrics.length}',
                style:GoogleFonts.rubik(
                    color:ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeightManager.medium
                ) ,
                ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
