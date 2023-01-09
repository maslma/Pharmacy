abstract class PharmacyLoginStates{}

class PharmacyLoginInitialState extends PharmacyLoginStates{}
class PharmacyLoginLoadingState extends PharmacyLoginStates{}
class PharmacyLoginSuccessState extends PharmacyLoginStates{
  final String uId;
  PharmacyLoginSuccessState(this.uId);
}
class PharmacyLoginErrorState extends PharmacyLoginStates{
  final String error;
  PharmacyLoginErrorState(this.error);
}
class PharmacyChangePasswordVisibilityState extends PharmacyLoginStates{}