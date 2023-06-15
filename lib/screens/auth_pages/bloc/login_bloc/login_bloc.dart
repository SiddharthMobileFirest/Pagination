import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_event.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/network/network_api_services.dart';
import '../../../../res/app_url/app_url.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInInitialState()) {
    on<LogInEvent>(
      (event, emit) => logIn(event, emit),
    );
  }
  logIn(LogInEvent event, Emitter<LogInState> emit) async {
    emit(LogInLoadingState());
    try {
      NetworkApiServices networkApiServices = NetworkApiServices();
      Map data = {"email": "eve.holt@reqres.in", "password": "pistol"};
      await networkApiServices
          .postApi(data, AppUrl.signUpApi)
          .then((value) => emit(LogInDoneState()));
    } catch (e) {
      emit(LogInErrorState(e.toString()));
    }
  }
}
