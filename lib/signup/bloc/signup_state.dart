const String SIGNUP_INIT = "SIGNUP_INIT";
const String LOADING = "LOADING";

class SignupState {}

class SignupInitState extends SignupState {
  @override
  String toString() {
    return SIGNUP_INIT;
  }
}

class SignupLoadingState extends SignupState {
  @override
  String toString() {
    return LOADING;
  }
}

class SignupSuccessState extends SignupState {
  final String message;

  SignupSuccessState(this.message);
}

class SignupFailState extends SignupState {
  final String errorMessage;

  SignupFailState(this.errorMessage);

  @override
  String toString() {
    return errorMessage;
  }
}
