import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import '../../../global_presentation/pharmacy_layout/cubit/cubit.dart';

class SingleItem extends StatefulWidget {

  String? productImage;
  String? productName;
  String? productPrice;
  String? productId;
  int? productQuantity;
  Function? onDelete;

   SingleItem(
      {Key? key,
        this.productQuantity,
        this.productId,
        this.onDelete,
        this.productImage,
        this.productName,
        this.productPrice,
        }) : super(key: key);

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
 late PharmacyCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = PharmacyCubit.get(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 90.h,
                  child: SizedBox(
                    width:100.w ,
                      height: 100.h,
                      child: Image(image: NetworkImage(
                      '${ widget.productImage}',
                    ),
                    fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              SizedBox(
                width:30.w ,),
              Expanded(
                child: SizedBox(
                  height: 90.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ widget.productName}',
                            maxLines: 1,
                            style: TextStyle(
                                color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
                                fontWeight: FontWeightManager.bold,
                                fontFamily:FontConstants.fontFamily ,
                                fontSize: 18.sp
                            ),
                          ),
                          Text(
                            '${widget.productQuantity}   Part ',
                            maxLines: 1,

                            style: TextStyle(
                                color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
                                fontWeight: FontWeightManager.bold,
                                fontFamily:FontConstants.fontFamily ,
                                fontSize: 15.sp),
                          ),
                          Text(
                            '${widget.productPrice}\$',
                            maxLines: 1,
                            style: TextStyle(
                                color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
                                fontWeight: FontWeightManager.bold,
                                fontFamily:FontConstants.fontFamily ,
                                fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90.h,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child:
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: ()
                          {
                            widget.onDelete;
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                            color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          height: 1,
          color:PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
        )
      ],
    );
  }
}