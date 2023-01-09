import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';

import '../pharmacy_layout/cubit/cubit.dart';

class RepTextFiled extends StatelessWidget {
  final IconData icon;
  final IconData? sufIcon;
  final String? text;
   final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function? validate;
  final Function? suffixPressed;
 final bool isPassword;
 final bool isClikable;




  const RepTextFiled({
    required this.icon,
    required this.text,
    required this.sufIcon,
    required this.controller,
    required this.keyboardType,
      this.validate,
    this.suffixPressed,
    this.isPassword=false,
     this.isClikable = true,



  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              icon,
              color: ColorManager.buttonColor,
              size: 25.h,
            ),
             SizedBox(width: 10.w),
            SizedBox(
              height: 50.h,
              width: 300.w,
              child: TextFormField(
                validator:(s){
                  validate!(s);
               },
                enabled:isClikable ,
                obscureText:isPassword ,
                controller:controller ,
                keyboardType:keyboardType ,
                cursorColor: Colors.black,
                style: TextStyle(color: PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.black),
                decoration: InputDecoration(
                  suffixIcon: sufIcon !=null ?IconButton(onPressed: (){suffixPressed!();}, icon: Icon(sufIcon,color:ColorManager.buttonColor,)):null,
                  focusedBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(color:PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.black),
                  ),
                  enabledBorder:  UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.buttonColor, width: 2.w),
                  ),
                  labelText: text,
                  labelStyle:  TextStyle(
                      color: PharmacyCubit.get(context).isDark ? ColorManager.buttonColor :ColorManager.buttonColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeightManager.medium),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
