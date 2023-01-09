import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/global_widgets/dash_divider_item.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import '../../../global_presentation/pharmacy_layout/cubit/cubit.dart';
import '../data/cateogries_model.dart';


class CateogriesScreen extends StatelessWidget {

  const CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit = PharmacyCubit.get(context);
          return Scaffold(
            body:SizedBox(
              height: double.infinity,
              width: double.infinity,
               child:  ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildCatItem(cubit.category[index],context),
                  separatorBuilder:(context,index)=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FadeInLeft(delay:const Duration(milliseconds: 800), child: MySeparator(color:cubit.isDark ? ColorManager.white : ColorManager.black ,)),
                  ),
                  itemCount: cubit.category.length),
            ),
          );
        },
    );
  }
}

Widget buildCatItem(CategoruModel model,context)=> FadeInLeft(
  delay:const Duration(milliseconds:800 ) ,
  child:   InkWell(
    onTap: (){},
    child:   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image:AssetImage('${model.image}'),
            width:100.w ,
            height:80.h ,
          ),
          SizedBox(
            width:20.w ,
          ),
          Text(
            '${model.name}',
            style:TextStyle(
              fontFamily:FontConstants.fontFamily ,
              fontSize:18.sp,
              fontWeight:FontWeightManager.bold,
            ) ,
          ),
          const Spacer(),
          Icon(
              Icons.arrow_forward_ios,
          color:PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.black,
          ),
        ],
      ),
    ),
  ),
);

