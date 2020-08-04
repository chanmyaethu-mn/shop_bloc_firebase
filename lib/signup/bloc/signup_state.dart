import 'package:shop_bloc_firebase/common/model/user.dart';

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

class SignupRequestState extends SignupState {
  final User user;

  SignupRequestState(this.user);

  @override
  String toString() {
    return user.toJson();
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
