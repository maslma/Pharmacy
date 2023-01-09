import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/sign_model.dart';
import 'state.dart';

class PharmacyRegisterCubit extends Cubit<PharmacyRegisterStates> {

  PharmacyRegisterCubit() : super(PharmacyRegisterInitialState());

  static PharmacyRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(PharmacyRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error)
    {
      emit(PharmacyRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

  })
  {
    PharmacyUserModel model = PharmacyUserModel(
        uId: uId,
        name: name,
        email: email,
        phone: phone,
        image:'https://img.freepik.com/premium-photo/amazed-young-european-man-keeps-mouth-opened-has-eyes-popped-out-holds-breath-fromm-shock-wears-stereo-headphones-ears-listens-audio-track-radio-finds-out-surprising-news-poses-indoor_273609-60466.jpg?w=996' ,
        isEmailVerified: false
    );

    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(PharmacyCreateUserSuccessState());
    }).catchError((error){
      emit(PharmacyCreateUserErrorState(error.toString()));
    });

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility (){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(PharmacyRegisterChangePasswordVisibilityState());

  }
}