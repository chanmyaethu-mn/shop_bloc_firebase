import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_firebase/common/constants.dart';
import 'package:shop_bloc_firebase/signup/bloc/signup_event.dart';
import 'package:shop_bloc_firebase/signup/bloc/signup_state.dart';
import 'package:shop_bloc_firebase/signup/model/signup_provider.dart';

class SignupBloc extends Bloc<SignupBtnEvent, SignupState> {
  @override
  SignupState get initialState => SignupInitState();

  @override
  Stream<SignupState> mapEventToState(SignupBtnEvent event) async* {
    if (event is SignupBtnEvent) {
      yield* _mapEventToState(event);
    }
  }

  Stream<SignupState> _mapEventToState(SignupBtnEvent event) async* {
    yield SignupLoadingState();

    try {
      final result = await SignUpProvider().insertUser(event.user);

      if (result.documentID.isNotEmpty) {
        yield SignupSuccessState(SUCCESS);
      } else {
        yield SignupSuccessState(FAIL);
      }
    } catch (e) {
      yield SignupFailState(FAIL);
    }
  }

  @override
  void onTransition(Transition<SignupBtnEvent, SignupState> transition) {
    super.onTransition(transition);
    print(transition.currentState);
    print(transition.event);
    print(transition.nextState);
  }
}
