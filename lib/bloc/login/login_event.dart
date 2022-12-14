part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);
  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginStatusChanged extends LoginEvent {
  const LoginStatusChanged(this.status);
  final String status;

  @override
  List<Object> get props => [status];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class FacebookLoginSubmitted extends LoginEvent{
  const FacebookLoginSubmitted();
}
class GoogleLoginSubmitted extends LoginEvent{
  const GoogleLoginSubmitted();
}

class LogoutRequested extends LoginEvent {}
