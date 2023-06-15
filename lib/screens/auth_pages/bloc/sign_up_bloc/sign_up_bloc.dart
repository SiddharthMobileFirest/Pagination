import 'package:bloc_project_using_event/res/app_url/app_url.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/network/network_api_services.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpEvent>(
      (event, emit) => signUp(event, emit),
    );
  }
  signUp(SignUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    try {
      NetworkApiServices networkApiServices = NetworkApiServices();
      Map data = {"email": "eve.holt@reqres.in", "password": "pistol"};
      await networkApiServices
          .postApi(data, AppUrl.signUpApi)
          .then((value) => emit(SignUpSignUpDoneState()));
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }
}
