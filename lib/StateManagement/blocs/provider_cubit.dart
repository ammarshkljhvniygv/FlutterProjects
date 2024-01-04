import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/provider_state.dart';
import 'package:onroad/models/order.dart';

class ProviderHomeCubit extends Cubit<ProviderHomeStates> {
  ProviderHomeCubit() : super(HomeScreenStates());

  static ProviderHomeCubit instance(BuildContext context) =>
      BlocProvider.of(context);
  void makeHomeScreenStates() {
    emit(HomeScreenStates());
  }

  void makeOrderTapScreenStates(String? orderId) {
    emit(OrderTapScreenStates(orderId: orderId));
  }
}
