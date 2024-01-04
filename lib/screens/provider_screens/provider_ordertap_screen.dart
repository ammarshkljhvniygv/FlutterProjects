import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/provider_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_state.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/provider_screens/provider_home_screen.dart';
import 'package:onroad/screens/provider_screens/provider_order_state.dart';

class ProviderOrderTapScreen extends StatefulWidget {
  const ProviderOrderTapScreen({Key? key, required this.provider})
      : super(key: key);
  final Provider provider;
  @override
  State<ProviderOrderTapScreen> createState() => _ProviderOrderTapScreenState();
}

class _ProviderOrderTapScreenState extends State<ProviderOrderTapScreen>
     {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
   /* _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderHomeCubit, ProviderHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeScreenStates) {
            return ProviderHomeScreen(provider: widget.provider);
          } else if (state is OrderTapScreenStates) {
            return ProviderOrderState(
              orderId: state.orderId!,
                provider: widget.provider
            );
          } else {
            return const Text('eroooooooooooooooooooooooooor');
          }
        });
  }
}
