import 'package:shop_bloc_firebase/common/model/user.dart';

abstract class SignupEvent {}

class SignupBtnEvent extends SignupEvent {
  final User user;

  SignupBtnEvent(this.user);
}
