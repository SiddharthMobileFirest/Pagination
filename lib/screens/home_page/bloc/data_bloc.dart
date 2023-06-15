// ignore_for_file: unrelated_type_equality_checks

import 'package:bloc_project_using_event/model/data_model.dart';
import 'package:bloc_project_using_event/repository/data_repository.dart';
import 'package:bloc_project_using_event/screens/home_page/bloc/data_event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataInitialState()) {
    on<DataEvent>(
      (event, emit) => gettingData(event, emit),
    );
  }

  int page = 1;
  gettingData(DataEvent event, Emitter<DataState> emit) async {
    emit(DataLoadingState(event.oldData, isFirstFetch: page == 1));
    try {
      DataRepository dataRepository = DataRepository();
      final List<Datum> data = await dataRepository.dataApi(page.toString());
      page++;
      emit(DataLoadedState(event.oldData + data));
    } catch (e) {
      if (kDebugMode) {
        print("------------------Error in data api-----------------------$e");
      }
      emit(DataErrorState(e.toString()));
    }
  }
}
