import 'package:equatable/equatable.dart';

import '../../../model/data_model.dart';

abstract class DataState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataInitialState extends DataState {
  @override
  List<Object?> get props => [];
}

class DataLoadingState extends DataState {
  final List<Datum> oldData;
  final bool isFirstFetch;
  DataLoadingState(this.oldData, {this.isFirstFetch = false});
  @override
  List<Object?> get props => [oldData, isFirstFetch];
}

class DataLoadedState extends DataState {
  final List<Datum> data;

  DataLoadedState(this.data);
  @override
  List<Object?> get props => [data];
}

class DataErrorState extends DataState {
  final String errorMessage;
  DataErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
