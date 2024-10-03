part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final LoginModel data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGetProfile extends AuthEvent {}

class AuthLogout extends AuthEvent {}

class AuthUpdatePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  const AuthUpdatePassword(this.oldPassword, this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [oldPassword, newPassword, confirmPassword];
}

