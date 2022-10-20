import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(_onHomeInitializeEvent);
    on<HomeFetchingEvent>(_onTransactionFetchingEvent);
  }

  void _onHomeInitializeEvent(HomeEvent event, Emitter<HomeState> emit) {
    emit(HomeFetchingState());
  }

  void _onTransactionFetchingEvent(
      HomeEvent event, Emitter<HomeState> emit) async {
    //TODO: Remote config
    RemoteConfig _remoteConfig = await RemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await _remoteConfig.fetchAndActivate();
    Map<String, RemoteConfigValue> allconfig = _remoteConfig.getAll();
    bool showBanner = _remoteConfig.getBool('show_true_banner');

    var banner_response =
        json.decode(_remoteConfig.getValue('promo_banner').asString());
    print(banner_response['banner_list'].length);
    emit(HomeFetchedState());
  }
}
