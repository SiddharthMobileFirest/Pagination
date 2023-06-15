import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String password;
  const SignUpEvent(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}
