import 'package:shop_bloc_firebase/common/model/user.dart';
import 'package:shop_bloc_firebase/signup/model/signup_provider.dart';

class SignupService {
  /// Return true : if insert success, else false
  Future<bool> insertUser(User user) async {
    final result = await SignUpProvider().insertUser(user);
    return Future.value(result.documentID.isNotEmpty);
  }
}
