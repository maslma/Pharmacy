// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import '../../../global_presentation/global_features/font_manager.dart';
import '../../../global_presentation/pharmacy_layout/cubit/cubit.dart';
import '../../../global_presentation/pharmacy_layout/cubit/state.dart';
import '../../add_product/data/product_model.dart';



class ProductScreen extends StatelessWidget {

  late productModel model;
  ProductScreen(this.model, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = PharmacyCubit.get(context);

       return Scaffold(
          body: FadeInDown(
            delay:const Duration(milliseconds: 1200) ,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:NetworkImage(model.productimage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 45.0,
                        horizontal: 15
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: ()
                          {
                            Navigator.pop(context);
                          },
                          icon:  Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 320,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 500,
                      decoration:  BoxDecoration(
                        color: PharmacyCubit.get(context).isDark ? ColorManager.scaffoldDarkColor :ColorManager.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0 , horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInLeft(
                              delay: const Duration(milliseconds: 1400),
                              child: Text(
                                model.productname!,
                                maxLines:2 ,
                                overflow:TextOverflow.ellipsis,
                                style:TextStyle(
                                    color:  PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                                    fontSize:25.sp,
                                    fontWeight:FontWeightManager.regular,
                                    fontFamily:FontConstants.fontFamily
                                ) ,
                              ),
                            ),
                            const SizedBox(height: 5),
                            FadeInLeft(
                              delay: const Duration(milliseconds: 1600),
                              child:  Text(
                                model.pills!,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color:  ColorManager.iconColor,

                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            FadeInLeft(
                              delay: const Duration(milliseconds: 1800),
                              child: Text(
                                'Product Details',
                                maxLines:2 ,
                                overflow:TextOverflow.ellipsis,
                                style:TextStyle(
                                    color:  PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                                    fontSize:20.sp,
                                    fontWeight:FontWeightManager.regular,
                                    fontFamily:FontConstants.fontFamily
                                ) ,
                              ),
                            ),
                            const SizedBox(height: 15),
                            FadeInLeft(
                              delay:const Duration(milliseconds: 2000) ,
                              child: Text(
                                model.details!,
                                style:TextStyle(
                                  fontSize: 12.sp,
                                  height: 1.2,

                                ) ,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 80.h),
                            FadeInLeft(
                              delay:const Duration(milliseconds: 2200) ,
                              child: Row(
                                children: [
                                  Text(
                                    'Number of Portions',
                                    style:TextStyle(
                                        color:  PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                                        fontSize:14,
                                        fontWeight:FontWeightManager.bold,
                                        fontFamily:FontConstants.fontFamily
                                    ) ,
                                  ),
                                  const Spacer(),
                                  Container(
                                    width:65,
                                    height:40.0 ,
                                    clipBehavior:Clip.antiAliasWithSaveLayer,
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(40.0),
                                    ) ,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStateProperty.all(ColorManager.buttonColor),
                                      ),
                                      onPressed: ()
                                      {
                                        PharmacyCubit.get(context).minus();

                                      },
                                      child: const Icon(
                                          Icons.remove
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                      height: 40,
                                      width: 65,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: ColorManager.buttonColor,  // red as border color
                                              width: 2
                                          ),
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                      child:  Center(child: Text('${PharmacyCubit.get(context).counter}'))
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width:65,
                                    height:40.0 ,
                                    clipBehavior:Clip.antiAliasWithSaveLayer,
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(40.0),
                                    ) ,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:MaterialStateProperty.all(ColorManager.buttonColor),
                                      ),
                                      onPressed: ()
                                      {
                                        PharmacyCubit.get(context).plus();

                                      },
                                      child: const Icon(
                                          Icons.add
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            FadeInUp(
                              delay:const Duration(milliseconds: 2400) ,
                              child: Center(
                                child: Container(
                                  padding:  const EdgeInsets.symmetric(horizontal: 5),
                                  width:200.w,
                                  height:45.h ,
                                  child: ElevatedButton(
                                    onPressed: ()
                                    {
                                      cubit.addCart(
                                        cartId: model.productId,
                                        cartImage:model.productimage,
                                        cartName: model.productname,
                                        cartPrice: model.price,
                                        cartQuantity:PharmacyCubit.get(context).counter,
                                      );
                                    },
                                    style:ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) )),
                                      backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                                    ) ,
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.center ,
                                      children: [
                                        const Icon(Icons.add_shopping_cart),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        const Text('Add to Basket'),
                                      ],
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
                  Positioned(
                    top: 370,
                    right: 20,
                    child: FadeInRight(
                      delay: const Duration(milliseconds: 2600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Rs.${model.price}\$ ',
                            style:TextStyle(
                                color:  PharmacyCubit.get(context).isDark ? ColorManager.white :ColorManager.buttonColor,
                                fontSize:20.sp,
                                fontWeight:FontWeightManager.regular,
                                fontFamily:FontConstants.fontFamily
                            ) ,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}
