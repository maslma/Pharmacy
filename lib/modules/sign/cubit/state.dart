abstract class PharmacyRegisterStates{}

class PharmacyRegisterInitialState extends PharmacyRegisterStates{}
class PharmacyRegisterLoadingState extends PharmacyRegisterStates{}
class PharmacyRegisterSuccessState extends PharmacyRegisterStates{}
class PharmacyRegisterErrorState extends PharmacyRegisterStates{
  final String error;
  PharmacyRegisterErrorState(this.error);
}
class PharmacyCreateUserSuccessState extends PharmacyRegisterStates{}
class PharmacyCreateUserErrorState extends PharmacyRegisterStates{
  final String error;
  PharmacyCreateUserErrorState(this.error);
}
class PharmacyRegisterChangePasswordVisibilityState extends PharmacyRegisterStates{}
