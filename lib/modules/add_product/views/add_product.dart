import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/cubit.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';

import '../../../global_presentation/global_widgets/primary_textfield.dart';


class AddProduct extends StatelessWidget {

  var nameController =TextEditingController();
  var pillsController =TextEditingController();
  var detailsController =TextEditingController();
  var priceController =TextEditingController();

   AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit,PharmacyStates>(
      listener: (context,state) {},
      builder:(context,state)
      {

        return Scaffold(
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(PharmacyCubit.get(context).productImage != null)
                    FadeInDown(
                      delay:const Duration(milliseconds: 1000) ,
                      child: Stack(
                        children:[
                          Container(
                            height:200.0 ,
                            width:double.infinity ,
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image:DecorationImage(
                                  image:FileImage(PharmacyCubit.get(context).productImage!),
                                  fit:BoxFit.cover
                              ),
                            ) ,
                          ),
                          IconButton(
                            onPressed: ()
                            {
                              PharmacyCubit.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                              child: Icon(Icons.close,
                                size:20 ,
                              ),
                              radius:25.0 ,

                            ),
                          ),
                        ],
                      ),
                    ),
                   SizedBox(
                    height: 10.h,
                  ),
                  FadeInDown(
                    delay:const Duration(milliseconds: 1200) ,
                    child: TextButton(
                      onPressed: ()
                      {
                        PharmacyCubit.get(context).getProductImage();
                      },
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children:  [
                          Icon(
                              Icons.image,
                          color:ColorManager.buttonColor ,
                          ),
                          const SizedBox(
                            width:10.0 ,
                          ),
                          Text(
                            'add photo',
                            style:TextStyle(
                              fontSize:18.sp,
                              fontWeight:FontWeightManager.bold,
                              color:ColorManager.buttonColor,
                              fontFamily:FontConstants.fontFamily
                            ) ,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height:20.h ,
                  ),
                  FadeInDown(
                      delay: const Duration(milliseconds: 1400),
                      child: RepTextFiled(
                        controller: nameController,
                        keyboardType:TextInputType.text,
                        icon: Icons.production_quantity_limits,
                        text: ' Name Product',
                        sufIcon: null,
                      )),
                  SizedBox(
                    height:10.h ,
                  ),
                  FadeInDown(
                      delay: const Duration(milliseconds: 1500),
                      child:   RepTextFiled(
                        controller: pillsController,
                        keyboardType:TextInputType.text,
                        icon: Icons.add_box,
                        text: 'Add Pills',
                        sufIcon: null,
                      )),
                  SizedBox(
                    height:10.h ,
                  ),
                  FadeInDown(
                      delay: const Duration(milliseconds: 1600),
                      child:   RepTextFiled(
                        controller: priceController,
                        keyboardType:TextInputType.number,
                        icon: Icons.price_change,
                        text: 'Add Pric',
                        sufIcon: null,
                      )),
                  SizedBox(
                    height:10.h ,
                  ),
                  FadeInDown(
                      delay: const Duration(milliseconds: 1700),
                      child:   RepTextFiled(
                        controller: detailsController,
                        keyboardType:TextInputType.text,
                        icon: Icons.details,
                        text: 'Add details',
                        sufIcon: null,
                      )),
                  SizedBox(
                    height:30.h ,
                  ),
                  FadeInDown(
                    delay: const Duration(milliseconds: 1800),
                    child: ConditionalBuilder(
                      condition: true,
                      builder: (BuildContext context)=>Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        width:double.infinity ,
                        height:45.h ,
                        child: ElevatedButton(
                          onPressed: ()
                          {
                            PharmacyCubit.get(context).addProduct(
                              productname: nameController.text,
                              pills: pillsController.text,
                              details: detailsController.text,
                              price: priceController.text
                            );
                          },
                          style:ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) )),
                            backgroundColor: MaterialStateProperty.all(ColorManager.buttonColor),
                          ) ,
                          child: const Text('Add Product'),
                        ),
                      ),
                      fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                    ),
                  ),
                ],
              ),
            ) ,

          ),
        );
      } ,
    );
  }
}
