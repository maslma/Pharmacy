import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/global_presentation/global_features/color_manager.dart';
import 'package:pharmacy/global_presentation/global_features/font_manager.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import 'package:pharmacy/modules/add_cart/data/cart_model.dart';
import '../../../global_presentation/global_widgets/showtoast_widget.dart';
import '../../../global_presentation/pharmacy_layout/cubit/cubit.dart';
import '../data/cart_model.dart';
import '../widget/cart_widget.dart';

class AddCartScreen extends StatelessWidget {
  const AddCartScreen({Key? key}) : super(key: key);


showAlertDialog(BuildContext context, CartModel model) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Yes"),
    onPressed: () {
      PharmacyCubit.get(context).cartDataDelete(model.cartId);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Cart Product"),
    content: const Text("Are you devete on cartProduct?"),
    actions: [
      cancelButton,
      continueButton,
    ],

  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


@override
Widget build(BuildContext context) {
  return BlocConsumer<PharmacyCubit,PharmacyStates>(
    listener:(context,state){} ,
    builder:(context,state)
    {
    var  cubit = PharmacyCubit.get(context);
    cubit.getCartData();
    return Scaffold(
        bottomNavigationBar: ListTile(
          title: Text("Total Aount",
          style:TextStyle(
            color:PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
            fontFamily:FontConstants.fontFamily
          ) ,
          ),
          subtitle: Text(
           '{\$${cubit.getTotalPrice()}',
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          trailing: SizedBox(
            width: 160,
            child: MaterialButton(
              color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30,),
              ),
              onPressed: () {
                if(cubit.getCartDataList.isEmpty){
                  return showToast(text: 'No Cart Data Found');
                }
              },
              child: Text('Submit',
                style: TextStyle(
                  color: PharmacyCubit.get(context).isDark ? ColorManager.black : ColorManager.white,),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            " Cart",
            style: TextStyle(
                color: PharmacyCubit.get(context).isDark ? ColorManager.white : ColorManager.black,
                fontSize: 18),
          ),
        ),
        body: PharmacyCubit.get(context).cart.isEmpty
            ? const Center(child: Text("NO DATA"),
        )
            : ListView.builder(
          itemCount: PharmacyCubit.get(context).getCartDataList.length,
          itemBuilder: (context, index) {
            CartModel data = PharmacyCubit.get(context).getCartDataList[index];
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SingleItem(
                  productImage: data.cartImage,
                  productName: data.cartName,
                  productPrice: data.cartPrice,
                  productId: data.cartId,
                  productQuantity: data.cartQuantity,
                  onDelete: ()
                  {
                    showAlertDialog(context, data);
                  },
                ),
              ],
            );
          },
        ),
      );
    } ,
  );
}
}
