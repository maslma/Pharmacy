abstract class PharmacyStates{}

class PharmacyInitialState extends PharmacyStates {}

class PharmacyChangeBottomNavState extends PharmacyStates{}
class PharmacyChangeZoomDrawerState extends PharmacyStates{}

class PharmacyGetUserLoadingState extends PharmacyStates {}
class PharmacyGetUserSuccessState extends PharmacyStates {}
class PharmacyGetUserErrorState extends PharmacyStates
{
  final String error;
  PharmacyGetUserErrorState(this.error);
}

class PharmacyProfileImagePickedSuccessState extends PharmacyStates{}
class PharmacyProfileImagePickedErrorState extends PharmacyStates{}

class PharmacyUserUpdateLoadingState extends PharmacyStates{}
class PharmacyUserUpdateErrorState extends PharmacyStates{}

class PharmacyUploadProfileImageSuccessState extends PharmacyStates{}
class PharmacyUploadProfileImageErrorState extends PharmacyStates{}

class PharmacyProductImagePickedSuccessState extends PharmacyStates{}
class PharmacyProductImagePickedErrorState extends PharmacyStates{}

class PharmacyGetProductLoadingState extends PharmacyStates {}
class PharmacyGetProductSuccessState extends PharmacyStates {}
class PharmacyGetProductErrorState extends PharmacyStates
{
  final String error;
  PharmacyGetProductErrorState(this.error);
}

class PharmacyFavoriteProductSuccessState extends PharmacyStates {}
class PharmacyFavoriteProductErrorState extends PharmacyStates
{
  final String error;
  PharmacyFavoriteProductErrorState(this.error);
}

class PharmacyCreateProductLoadingState extends PharmacyStates{}
class PharmacyCreateProductSuccessState extends PharmacyStates{}
class PharmacyCreateProductErrorState extends PharmacyStates{}

class PharmacyDeleteProductCartSuccessState extends PharmacyStates{}
class PharmacyDeleteProductCartErrorState extends PharmacyStates{}

class PharmacyRemovePostImageState extends PharmacyStates{}

class PharmacyChangeModeState extends PharmacyStates {}

class CounterPlusState extends PharmacyStates{
  final int counter;

  CounterPlusState(this.counter);
}
class CounterMinusState extends PharmacyStates{
  final int counter;

  CounterMinusState(this.counter);
}