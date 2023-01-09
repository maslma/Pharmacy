import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/modules/home/viwes/product_screen.dart';
import '../../../global_presentation/global_features/font_manager.dart';
import '../../../global_presentation/global_widgets/navigateandfinish.dart';
import '../../../global_presentation/pharmacy_layout/cubit/cubit.dart';
import '../../../global_presentation/pharmacy_layout/cubit/state.dart';
import '../../add_product/data/product_model.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener:(context,state){} ,
      builder: (context,state)
      {
        var cubit = PharmacyCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics() ,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  FadeInDown(
                    delay:const Duration(milliseconds: 1800) ,
                    child: CarouselSlider(
                        items:cubit.CarouselSlider,
                        options: CarouselOptions(
                          height:200.h,
                          initialPage:0,
                          viewportFraction:1.0,
                          enableInfiniteScroll: true,
                          reverse:false,
                          autoPlay:true,
                          autoPlayInterval:const Duration(seconds:3 ),
                          autoPlayAnimationDuration:const Duration(seconds: 1),
                          autoPlayCurve:Curves.fastOutSlowIn,
                          scrollDirection:Axis.horizontal,
                        )),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  FadeInLeft(
                    delay:const Duration(milliseconds: 1600) ,
                    child: Text('Product Pharmacy',
                    style: TextStyle(
                      fontWeight:FontWeightManager.bold,
                      fontSize:25.sp,
                      fontFamily:FontConstants.fontFamily,
                      color:PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height:250.h,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection:Axis.horizontal ,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>productBuilder(cubit.products[index],context,index),
                        separatorBuilder:(context,index)=>SizedBox(width: 15.w,),
                        itemCount: cubit.products.length),
                  ),
                ],
              ),
            ),
          ) ,
        );
      },
    );
  }
}

Widget productBuilder(productModel model,context,index)=>FadeInLeft(
  delay:const Duration(milliseconds: 1400) ,
  child: InkWell(
    onTap: ()
    {
      navigateTo(context, ProductScreen(model));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: double.infinity ,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(30) ,
            boxShadow:  [
              BoxShadow(
                color: ColorManager.iconColor.withOpacity(0.9),
                spreadRadius: 4,
                blurRadius: 4,
                offset: const Offset(0,2),
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width:150.w,
              color: ColorManager.white,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  Image(image:NetworkImage('${model.productimage}'),
                    width:double.infinity ,
                    height:150.h ,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0 ),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        Text(
                          '${model.productname}',
                          maxLines:2 ,
                          overflow:TextOverflow.ellipsis,
                          style:TextStyle(
                              color:  ColorManager.black,
                              fontSize:15.sp,
                              fontWeight:FontWeightManager.regular,
                              fontFamily:FontConstants.fontFamily
                          ) ,
                        ),
                        const SizedBox(
                            height: 5),
                        Text(
                          '${model.pills} Pills',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color:  ColorManager.iconColor,

                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${model.price} Price',
                              style:const TextStyle(
                                fontSize:18.0,
                                color:ColorManager.iconColor,
                              ) ,
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: ()
                                {
                                  PharmacyCubit.get(context).favoriteProduct(PharmacyCubit.get(context).favoritesId[index]);
                                },
                                icon:  Icon(
                                    Icons.favorite,
                                    size:35.sp ,
                                    color:ColorManager.red ,

                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),
);
