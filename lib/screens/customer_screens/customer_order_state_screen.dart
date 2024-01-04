import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_states.dart';
import 'package:onroad/models/order.dart';
import 'package:onroad/models/provider.dart';
import 'package:onroad/screens/busy_provider_screen.dart';
import 'package:onroad/screens/customer_screens/customer_accepted_order_screen.dart';
import 'package:onroad/screens/customer_screens/customer_rate_screen.dart';
import 'package:onroad/screens/wait_screen.dart';

import 'customer_pay_check_screen.dart';
import 'customer_pay_doesnot_check_screen.dart';

class CustomerOrderStateScreen extends StatefulWidget {
  const CustomerOrderStateScreen({Key? key, required this.order, required this.provider})
      : super(key: key);
  final Order order;
  final Provider provider ;
  @override
  State<CustomerOrderStateScreen> createState() =>
      _CustomerOrderStateScreenState();
}

class _CustomerOrderStateScreenState extends State<CustomerOrderStateScreen> {
  String initial = 'open';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<fs.DocumentSnapshot<Map<String, dynamic>>>(
      stream: fs.FirebaseFirestore.instance
          .collection("Orders")
          .doc(widget.order.id
              .toString()) /*where('order_id', isEqualTo: widget.order.id)*/
          .snapshots(),
      builder: (context, snapshot) {
        OrderCubit orderCubit = OrderCubit.instance(context);

        if (snapshot.data != null) {
          print(snapshot.data!.data()!['order_state']);
          print(snapshot.data!);
          print('--------------------------------------------------');
          initial = snapshot.data!.data()!['order_state'];
        }
        if (initial == 'open') {
          orderCubit.makeOrderAcceptAble(widget.order.id.toString());
        }
        if (initial == 'accepted') {
          orderCubit.makeOrderAccepted();
        }
        if (initial == 'rejected') {
          orderCubit.makeOrderRejected();
        }
        if (initial == 'canceled') {
          orderCubit.makeOrderCanceled();
        }
        if (initial == 'timeout') {
          orderCubit.makeOrderTimeOut();
        }
        if (initial == 'paycheck') {
          orderCubit.makeOrderPayCheck();
        }
        if (initial == 'paychecked') {
          orderCubit.makeOrderPayChecked();
        }
        if (initial == 'paynotcheck') {
          orderCubit.makeOrderPayDoesNotCheck();
        }

        return BlocConsumer<OrderCubit, OrderStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is OrderStateInitial) {
                return Container();
              } else if (state is OrderAcceptAble) {
                return WaitScreen(
                  orderId: widget.order.id.toString(),
                );
              } else if (state is OrderAccepted) {
                return CustomerAcceptedOrderScreen(order: widget.order,provider: widget.provider,);
              } else if (state is OrderRejected) {
                return BusyProviderScreen();
              } else if (state is OrderCanceled) {
                return BusyProviderScreen();
              } else if (state is OrderTimeOut) {
                return BusyProviderScreen();
              } else if (state is OrderPayCheck) {
                return CustomerPayCheckScreen();
              } else if (state is OrderPayChecked) {
                return CustomerRateScreen(order: widget.order,);
              } else if (state is OrderPayDoesNotCheck) {
                return CustomerPayDoesNotCheckScreen(orderId: widget.order.id.toString(),);
              } else {
                return const Text('10');
              }
            });
      },
    );
  }
}
