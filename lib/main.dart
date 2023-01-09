// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/theme_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import 'package:pharmacy/modules/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'modules/menu_drawer/widget/menu_drawer_widget.dart';
import 'shared/component/constant/constant.dart';
import 'shared/network/local/cache_helper.dart';



void main(context)async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await CacheHelper.init();
  Widget widget;
  CacheHelper.saveData(key: 'isDark', value: false);
  bool? isDark = CacheHelper.getData(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null)
  {
    widget=  const MenuDrawer();
  }else
  {
    widget=const SplashScreen();
  }
  await ScreenUtil.ensureScreenSize();
  runApp( MyApp
    (
    startWidget: widget,
    isDark: isDark!

  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  final bool isDark;


   const MyApp({
    required this.startWidget,
    required this.isDark
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: ( context)=>PharmacyCubit()..getUserData()..getProduct()..changeAppMode(fromShared: isDark)
          ),
        ],
        child: BlocConsumer<PharmacyCubit,PharmacyStates>(
          listener:(context,state){} ,
          builder:(context,state)
          {
            return MaterialApp(
              debugShowCheckedModeBanner:false ,
              home: startWidget,
              theme:getApplicationTheme() ,
              darkTheme:getDarkTheme() ,
              themeMode: PharmacyCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            );
          } ,
        ),
      ),

    );
  }
}

// StreamBuilder(
//     stream: FirebaseAuth.instance.authStateChanges(),
//     builder: (context, snapShot) {
//       if (snapShot.hasData) {
//         return;
//       }
//       return LoginScreen();}
// ),
