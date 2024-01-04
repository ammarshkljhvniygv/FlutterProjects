import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_states.dart';
import 'package:onroad/screens/customer_screens/customer_main_screen.dart';
import 'package:onroad/screens/lang_screen.dart';

class CustomerIsLoginScreen extends StatefulWidget {
  const CustomerIsLoginScreen({Key? key}) : super(key: key);

  @override
  State<CustomerIsLoginScreen> createState() => _CustomerIsLoginScreenState();
}

class _CustomerIsLoginScreenState extends State<CustomerIsLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoginFinishedSuccessfully) {
                return CustomerMainScreen(
                    customer: /*Customer(
                        id: '',
                        userName: '',
                        phoneNumber: '')*/
                        state.customer!);
              } else {
                return const ChooseScreen();
              }
            }),
      ),
    );
  }
}
