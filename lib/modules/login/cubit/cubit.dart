import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy/modules/login/cubit/state.dart';
import '../../../global_presentation/global_widgets/navigateandfinish.dart';
import '../../menu_drawer/widget/menu_drawer_widget.dart';






class PharmacyLoginCubit extends Cubit<PharmacyLoginStates> {

  PharmacyLoginCubit() : super(PharmacyLoginInitialState());

  static PharmacyLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
  required String email,
  required String password,
  })
  {
  emit(PharmacyLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
  ).then((value){
  emit(PharmacyLoginSuccessState(value.user!.uid));
  }).catchError((error)
  {
  emit(PharmacyLoginErrorState(error.toString()));
  });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility (){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(PharmacyChangePasswordVisibilityState());

  }

  // Future<void> signInWithGoogle(context) async {
  //   final signInWithGoogle = GoogleSignIn();
  //   final googleAccount = await signInWithGoogle.signIn();
  //   if(googleAccount != null){
  //     final  googleAuth = await googleAccount.authentication;
  //     if(googleAuth.accessToken != null && googleAuth.idToken != null ) {
  //       try {
  //         final authResult = await FirebaseAuth.instance.signInWithCredential(
  //           GoogleAuthProvider.credential(
  //             idToken: googleAuth.idToken,
  //             accessToken: googleAuth.accessToken,
  //           )
  //         );
  //         if(authResult.additionalUserInfo!.isNewUser)
  //         {
  //           await FirebaseFirestore
  //               .instance
  //               .collection('users')
  //               .doc(authResult.user!.uid)
  //               .set({
  //             'id': authResult.user!.uid,
  //             'name': authResult.user!.displayName,
  //             'email': authResult.user!.email,
  //             'createdAt' : Timestamp.now(),
  //
  //           });
  //         }
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (context)=> const MenuDrawer())
  //         );
  //       }
  //       catch(error){} finally{}
  //       }
  //
  //     }
  //
  //   }
  Future<UserCredential> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().then((value)
    {
      navigateAndFinish(context, const MenuDrawer());
    });

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}