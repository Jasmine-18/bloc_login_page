import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_login_page/bloc/login/login_repository.dart';
import 'package:bloc_login_page/helper/app_preferences.dart';
import 'package:bloc_login_page/repository/user_repository.dart';
import 'package:bloc_login_page/utilities/authentication_google.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final LoginRepository _loginRepository = LoginRepository();

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState(status: '')) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    // on<LoginStatusChanged>(_onLoginStatusChanged);
    on<LoginSubmitted>(_onSubmitted);
    // on<LoginSubmitted>(_onSubmitted);
    on<FacebookLoginSubmitted>(_onFacebookLoginSubmitted);
    on<GoogleLoginSubmitted>(_onGoogleLoginSubmitted);
  }

  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username, status: ''));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, status: ''));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(status: 'pending'),
    );
    // Map<String, dynamic> response = await _userRepository.login(
    //   username: state.username,
    //   password: state.password,
    // );
    try {
      var response = await _loginRepository.getLoginResponse(
          username: state.username, password: state.password);

      String token = response.accessToken;
      await AppPreferences.setAccessToken(token);
      // Testing of getting token from shared preferences
      AppPreferences.getAccessToken();
      AppPreferences.setLoginProvider('local');
      emit(state.copyWith(status: 'success', response: 'token'));
    } catch (e) {
      emit(state.copyWith(response: e.toString(), status: 'failed'));
    }
  }

  void _onFacebookLoginSubmitted(
      FacebookLoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      emit(
        state.copyWith(status: 'pending'),
      );
      final Map<String, String> data = <String, String>{};
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        await AppPreferences.setAccessToken(result.accessToken.toString());
        FacebookAuth.instance.getUserData().then((userData) async {
          data['name'] = userData['name'];
          data['email'] = userData['email'];
          data['profilePic'] = userData['picture']['data']['url'];
          AppPreferences.setLoginProvider('facebook');
          await AppPreferences.setFacebookProfile(data);
          AppPreferences.getFacebookProfile()
              .then((value) => {log("Here is the ${value['name']}")});
        });
        emit(state.copyWith(status: 'success'));
      } else {
        emit(state.copyWith(status: 'failed'));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void _onGoogleLoginSubmitted(
      GoogleLoginSubmitted event, Emitter<LoginState> emit) async {
    FirebaseService service = FirebaseService();

    try {
      emit(
        state.copyWith(status: 'pending'),
      );
      await service.signInwithGoogle();
      AppPreferences.setLoginProvider('google');
      emit(state.copyWith(status: 'success'));
    } catch (e) {
      if (e is FirebaseAuthException) {
        log(e.message!);
      }
    }
  }
}
