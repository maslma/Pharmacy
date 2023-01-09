// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/cubit/state.dart';
import 'package:pharmacy/global_presentation/pharmacy_layout/views/pharmacy_layout_screen.dart';
import 'package:pharmacy/modules/add_cart/data/cart_model.dart';
import 'package:pharmacy/modules/add_product/data/product_model.dart';
import 'package:pharmacy/modules/cateogries/viwes/cateogries_screen.dart';
import 'package:pharmacy/modules/cateogries/data/cateogries_model.dart';
import 'package:pharmacy/modules/location/views/location_screen.dart';
import 'package:pharmacy/modules/login/views/login_screen.dart';
import 'package:pharmacy/modules/profile/profile_screen.dart';
import 'package:pharmacy/modules/sign/data/sign_model.dart';
import 'package:pharmacy/modules/theme/theme_screen.dart';
import 'package:pharmacy/shared/network/local/cache_helper.dart';
import '../../../modules/add_product/views/add_product.dart';
import '../../../modules/home/viwes/home_screen.dart';
import '../../../shared/component/constant/constant.dart';
import '../../global_features/images_manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../global_widgets/navigateandfinish.dart';


class PharmacyCubit extends Cubit<PharmacyStates>
{
  PharmacyCubit () : super(PharmacyInitialState());

  static PharmacyCubit get(context) => BlocProvider.of(context);


  int zoomDrawerIndex = 0;
  PharmacyUserModel ? userModel;
  List<Widget> zoomDrawerScreen=
  [
    const PharmacyLayoutScreen(),
     ProfileScreen(),
    const ThemeScreen(),
  ];



  void changeZoomDrawerIndex(int index){
    zoomDrawerIndex = index;
    emit(PharmacyChangeZoomDrawerState());
  }

  int currentIndex = 0;


  List<Widget> bottomScreens = [
    const HomeScreen(),
     const CateogriesScreen(),
      AddProduct(),
     const LocationScreen(),
  ];

  List<String> titles = [
    'Home Pharmacy',
    'Cateogries',
    'Add Product',
    'Location',
    'Setting'
  ];

  void changeCurrentIndex(int index){
    currentIndex = index;
    emit(PharmacyChangeBottomNavState());
  }

  List<Widget> CarouselSlider = [
     Image.asset(ImagesManager.carouselSlider1),
     Image.asset(ImagesManager.carouselSlider2),
     Image.asset(ImagesManager.carouselSlider3),
     Image.asset(ImagesManager.carouselSlider4),
  ];



  void getUserData()
  {
    emit(PharmacyGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {

      userModel = PharmacyUserModel.fromJson(value.data()!);
      emit(PharmacyGetUserSuccessState());
    }).catchError((error)
    {
      emit(PharmacyGetUserErrorState(error.toString()));
    });

  }


   File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future getProfileImage()async
  {
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(PharmacyProfileImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(PharmacyProfileImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(PharmacyUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        print(value);
        updateUser(name: name,
            phone: phone,
            email: email,
            image: value
        );
      }).catchError((error)
      {
        emit(PharmacyUploadProfileImageErrorState());
      });
    }).catchError((error)
    {
      emit(PharmacyUploadProfileImageErrorState());
    });
  }

  void updateUser(
      {required String name,
        required String phone,
        required String email,
        String? image,
      })
  {
   PharmacyUserModel model =PharmacyUserModel(
        name: name,
        phone: phone,
        email:userModel!.email ,
        image:image??userModel!.image ,
        uId:userModel!.uId,
        isEmailVerified: false
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    })
        .catchError((error)
    {
      emit(PharmacyUserUpdateErrorState());
    });
  }

  void signOut(context)
  {
    // FirebaseAuth.instance.signOut().then((value)
    CacheHelper.removeData(key: 'uId').then((value)

    {
      navigateAndFinish(context,LoginScreen());

    });
  }

  File? productImage;

  Future getProductImage()async
  {
    final pickedFile = await picker.pickImage(source:ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage = File(pickedFile.path);
      emit(PharmacyProductImagePickedSuccessState());
    }else
    {
      print('No image selected');
      emit(PharmacyProductImagePickedErrorState ());
    }
  }

  List<productModel> products=[];
  List<int> favorites = [];
  List<String> favoritesId = [];


  void getProduct()
  {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((value) {
      for (var element in value.docs) {
        products.add(productModel.fromJson(element.data()));
        favorites.add(value.docs.length);
        favoritesId.add(element.id);
      }
      // print(products);
      emit(PharmacyGetProductSuccessState());
    }
    ).catchError((error)
    {
      emit(PharmacyGetProductErrorState(error.toString()));
    });
  }
  void favoriteProduct(String favoritesId)
  {
    FirebaseFirestore.instance
        .collection('products')
        .doc(favoritesId)
        .collection('favorites')
        .doc(userModel!.uId)
        .set({'favorites' : true})
        .then((value)
    {
      emit(PharmacyFavoriteProductSuccessState());
    })
        .catchError((error)
    {
      emit(PharmacyFavoriteProductErrorState(error.toString()));
    });
  }

  void addProduct({
    String? productimage,
    required String productname,
    required String details,
    required String pills,
     required String price,


  })
  {
    emit(PharmacyCreateProductLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage!.path).pathSegments.last}')
        .putFile(productImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        productModel model = productModel(
          productId: userModel!.uId,
            productimage:value,
            productname:productname,
             price: price,
          details:details,
          pills:pills,


        );

        FirebaseFirestore.instance
            .collection('products')
            .add(model.toMap())
            .then((value)
        {
          products=[];
          getProduct();

        });
        emit(PharmacyCreateProductSuccessState());
      }).catchError((error)
      {
      });

    }).catchError((error)
    {
      emit(PharmacyCreateProductErrorState());
    });
  }

  void removePostImage()
  {
    productImage = null;
    emit(PharmacyRemovePostImageState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared, value})
  {
    if(fromShared != null) {
      isDark = fromShared;
      emit(PharmacyChangeModeState());
    }
    else {
      isDark = value;
      print('value:$value');
      CacheHelper.saveData(key: 'isDark', value: value).then((value) {
        emit(PharmacyChangeModeState());
      }).catchError((error)
      {
        print(error.toString());
      });
    }

  }

  int counter =0;

  void minus(){
    counter--;
    emit(CounterMinusState(counter));
  }
  void plus(){
    counter++;
    emit(CounterPlusState(counter));

  }

  List<CategoruModel> category = [
    CategoruModel(
        image:ImagesManager.Analgesics,
        name: 'Analgesics'
    ),
    CategoruModel(
        image:ImagesManager.Antacids,
        name: 'Antacids'
    ),
    CategoruModel(
        image: ImagesManager.Antidepressants,
        name: 'Antidepressants'
    ),
    CategoruModel(
        image: ImagesManager.Bronchodilators,
        name: 'Bronchodilators'
    ),
    CategoruModel(
        image: ImagesManager.CoughSuppressants,
        name: 'CoughSuppressants'
    ),
    CategoruModel(
        image: ImagesManager.Vitamins,
        name: 'Vitamins'
    ),
  ];

  void addCart({
    String? cartId,
    String? cartName,
    String? cartPrice,
    int? cartQuantity,
      String? cartImage,
  })async
  {
    FirebaseFirestore.instance
        .collection('Cart')
        .doc(userModel!.uId)
        .collection('YourCart')
        .doc(cartId)
        .set(
      {
        'cartId' : cartId,
        'cartName' : cartName,
        'cartPrice' : cartPrice,
        'cartQuantity' : cartQuantity,
        'cartImage' : cartImage,
        "isAdd":true,


      }
    );
  }

List<CartModel> cart= [];

  void getCartData()async
  {

    List<CartModel> newList=[];
   await FirebaseFirestore.instance
        .collection('Cart')
        .doc(userModel!.uId)
        .collection('YourCart')
        .get().then((value)
    {
      for (var element in value.docs)
      {
CartModel model = CartModel(
    cartId: element.get('cartId'),
    cartName: element.get('cartName'),
    cartPrice:element.get('cartPrice') ,
    cartQuantity: element.get('cartQuantity'),
    cartImage: element.get('cartImage'));

         newList.add(model);
      }
    });
   cart = newList;
  }

 List<CartModel> get getCartDataList
  {
    return cart;
  }

  getTotalPrice(){
      String total ='0.0';
    for (var element in cart) {
      total +=element.cartPrice * element.cartQuantity;
    }
    return total;
  }

  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    String? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(userModel!.uId)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd":true,
      },
    );
  }

 void cartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(userModel!.uId)
        .collection("YourCart")
        .doc(cartId)
        .delete().then((value)
    {
      emit(PharmacyDeleteProductCartSuccessState());
    }).catchError((error)
    {
      emit(PharmacyDeleteProductCartErrorState());
    });

  }

}