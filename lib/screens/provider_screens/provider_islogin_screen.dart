import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_states.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/models/user_data.dart';
import 'package:onroad/screens/provider_screens/provider_login_screen.dart';
import 'package:onroad/screens/provider_screens/provider_screen.dart';

class ProviderIsloginScreen extends StatefulWidget {
  const ProviderIsloginScreen({Key? key}) : super(key: key);

  @override
  State<ProviderIsloginScreen> createState() => _ProviderIsloginScreenState();
}

class _ProviderIsloginScreenState extends State<ProviderIsloginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoginProviderFinishedSuccessfully) {

              return ProviderScreen(
                provider: state.provider!,
              );
            } else {
              return const ProviderLoginScreen();
            }
          }),
    );
  }
}
