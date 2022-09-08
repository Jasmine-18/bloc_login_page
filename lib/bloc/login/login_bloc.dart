import 'dart:convert';

import 'package:bloc/bloc.dart';
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
    print("onuserchanged: ${state.password}");
    emit(state.copyWith(username: event.username, status: ''));
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password, status: ''));
  }

  void _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    try {
      // print("Event username: ${event.username}");
      // print("State username: ${state}");
      emit(
        state.copyWith(status: 'pending'),
      );
      print("Start pending");
      Future.delayed(const Duration(milliseconds: 6000), () {
        print("pending...");
      });
      Map<String, dynamic> response = await _userRepository.login(
        username: state.username,
        password: state.password,
      );
      print("End pending");
      if (response.containsKey('token')) {
        String token = response['token']['access_token'];
        await AppPreference.setAccessToken(token);
        // Testing of getting token from shared preferences
        AppPreference.getAccessToken().then((value) => {
              print("Here is the  ${value}"),
            });
        AppPreference.setLoginProvider('local');
        emit(state.copyWith(status: 'success', response: token));
      } else {
        emit(state.copyWith(
            response: response['error']['message'], status: 'failed'));
      }
    } catch (e) {
      print(e);
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
        await AppPreference.setAccessToken(result.accessToken.toString());
        FacebookAuth.instance.getUserData().then((userData) async {
          print(userData);
          data['name'] = userData['name'];
          data['email'] = userData['email'];
          data['profilePic'] = userData['picture']['data']['url'];
          AppPreference.setLoginProvider('facebook');
          await AppPreference.setFacebookProfile(data);
          AppPreference.getFacebookProfile()
              .then((value) => {print("Here is the ${value['name']}")});
        });
        emit(state.copyWith(status: 'success'));
      } else {
        emit(state.copyWith(status: 'failed'));
      }
      // await FacebookAuth.instance
      //     .login(permissions: ['public_profile', 'email']).then((value) {
      //   print("this is valei: ${value.accessToken}");

      // });

    } catch (e) {
      print(e);
    }
  }

  void _onGoogleLoginSubmitted(
      GoogleLoginSubmitted event, Emitter<LoginState> emit) async {
    FirebaseService service = new FirebaseService();

    try {
      emit(
        state.copyWith(status: 'pending'),
      );
      await service.signInwithGoogle();
      AppPreference.setLoginProvider('google');
      emit(state.copyWith(status: 'success'));
    } catch (e) {
      if (e is FirebaseAuthException) {
        print(e.message!);
      }
    }
  }
}
