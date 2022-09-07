part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String username;
  final String password;
  final String status;
  final String? response;
  final Map<String, dynamic>? fBResponse;

  // LoginState copyWith({String? username, String? password, String? status}) {
  //   return LoginState._(
  //       username: username ?? this.username,
  //       password: password ?? this.password,
  //       status: password ?? this.status,
  //       );
  // }
  // const LoginState.unknown() : this._();
  // const LoginState() : this._();
  // const LoginState.login({required String username, required String password})
  //     : this._(username: username, password: password, status: status,errorMsg: errorMsg);
  // const LoginState.usernameChanged({required String username})
  //     : this._(username: username);
  // const LoginState.passwordChanged({required String password})
  //     : this._(password: password);
  // const LoginState.authenticated() : this._(status: true);
  // const LoginState.unauthenticated({required Map<String, dynamic>? errorMsg})
  //     : this._(status: false, errorMsg: errorMsg);
  const LoginState({
    this.status = '',
    this.username = "",
    this.password = "",
    this.response,
    this.fBResponse,
  });
  LoginState copyWith(
      {String? username,
      String? password,
      String? status,
      String? response,
      Map<String, dynamic>? fBResponse}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      response: response ?? this.response,
      fBResponse: fBResponse ?? this.fBResponse,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [username, password, status, response, fBResponse];
}
