import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/images_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/modules/on_boarding/views/on_boarding_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {




 @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value)
    {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>const OnBoardingScreen()));
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:PharmacyCubit.get(context).isDark ? ColorManager.scaffoldDarkColor :ColorManager.buttonColor,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            Image(image: AssetImage(ImagesManager.foregroundSplash),width:250.w ,),
             Container(
              height:100.h ,
            ),
            const SpinKitFadingCube(
              color: Colors.white,
              size: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
