import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  final String errorMessage;
  SignUpErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}

class SignUpSignUpDoneState extends SignUpState {
  @override
  List<Object?> get props => [];
}
