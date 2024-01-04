import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_states.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/screens/canceled_order_screen.dart';
import 'package:onroad/screens/provider_screens/provider_acceptable_order_screen.dart';
import 'package:onroad/screens/provider_screens/provider_accepted_screen.dart';
import 'package:onroad/screens/provider_screens/provider_finish_order_screen.dart';
import 'package:onroad/screens/provider_screens/provider_pay_ckeck_screen.dart';
import 'package:onroad/screens/provider_screens/provider_pay_dosenot_check_screen.dart';
import 'package:onroad/screens/provider_screens/provider_rejected_screen.dart';

import '../../models/customer.dart';
import '../../models/provider.dart';

class ProviderOrderState extends StatefulWidget {
  const ProviderOrderState({Key? key, required this.orderId, required this.provider}) : super(key: key);
  final String? orderId;
  final Provider provider;

  @override
  State<ProviderOrderState> createState() => _ProviderOrderStateState();
}

class _ProviderOrderStateState extends State<ProviderOrderState> {
  fs.DocumentSnapshot<Map<String, dynamic>>? init;
  bool done = false;
 late Order order1 ;
  @override
  void initState() {
    order();
    super.initState();
  }

  Future<void> order() async {
    init = await fs.FirebaseFirestore.instance
        .collection("Orders")
        .doc(widget.orderId.toString())
        .get();
   await getOrder();

  }
  Future<void> getOrder() async {
    OrderCubit orderCubit = OrderCubit.instance(context);
    LoginCubit loginCubit = LoginCubit.instance(context);
    Order order = (await orderCubit.getOrder(widget.orderId.toString()))!;
    Customer customer =
    await loginCubit.getCustomerById2(order.customerId.toString());
    order.customer = customer;
    setState(() {
      order1 = order ;
      done = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<fs.DocumentSnapshot<Map<String, dynamic>>>(
          stream: fs.FirebaseFirestore.instance
              .collection("Orders")
              .doc(widget.orderId.toString())
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            OrderCubit order = OrderCubit.instance(context);
            //print(snapshot.data!.data());
            if (snapshot.data != null) {
              init = snapshot.data!;
            }
            if (init!.data()!['order_state'] == 'open') {

              order.makeOrderProviderAcceptAble(order1);
            }
            if (init!.data()!['order_state'] == 'rejected') {
              order.makeOrderRejected();
            }
            if (init!.data()!['order_state'] == 'accepted') {
              order.makeOrderProviderAccepted(order1);
            }
            if (init!.data()!['order_state'] == 'paychecked') {
              order.makeOrderFinishedSuccessfully();
            }
            if (init!.data()!['order_state'] == 'canceled') {
              order.makeOrderCanceled();
            }
            if (init!.data()!['order_state'] == 'paycheck') {
              order.makeOrderPayCheck();
            }
            if (init!.data()!['order_state'] == 'paynotcheck') {
              order.makeOrderPayDoesNotCheck();
            }


            return BlocConsumer<OrderCubit, OrderStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is OrderProviderAcceptAble) {
                    return ProviderAcceptableOrderScreen(
                      order: state.order,
                        provider: widget.provider

                    );
                  } else if (state is OrderProviderAccepted) {
                    return ProviderAcceptedScreen(
                      order: state.order,
                    );
                  } else if (state is OrderRejected) {
                    return ProviderRejectedOrderScreen();
                  } else if (state is OrderCanceled) {
                    return CanceledOrderScreen();
                  } else if (state is OrderFinishedSuccessfully) {
                    return ProviderFinishOrderScreen();
                  } else if (state is OrderPayCheck) {
                    return ProviderPayCheckScreen(orderId: widget.orderId.toString(),);
                  } else if (state is OrderPayDoesNotCheck) {
                    return ProviderPayDoesNotCheckScreen(orderId: widget.orderId.toString(),);
                  } else {
                    return const Text('eroooooooooooooooooooooooooor,,,,');
                  }
                });
          },
        ),
        done
            ? Container()
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              )
      ],
    );
  }
}
