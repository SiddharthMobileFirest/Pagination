import 'package:equatable/equatable.dart';

class LogInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LogInInitialState extends LogInState {
  @override
  List<Object?> get props => [];
}

class LogInLoadingState extends LogInState {
  @override
  List<Object?> get props => [];
}

class LogInErrorState extends LogInState {
  final String errorMessage;
  LogInErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class LogInDoneState extends LogInState {
  @override
  List<Object?> get props => [];
}
