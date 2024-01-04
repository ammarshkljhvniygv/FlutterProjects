import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/widget/profile_item.dart';

class ShowForm extends StatelessWidget {
  const ShowForm({Key? key, required this.customer, required this.carNumber})
      : super(key: key);
  final Customer customer;
  final int carNumber;
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ProfileItem(
            text: languageCubit.carMade!,
            val: customer.cars![carNumber].carMake,
            dropdown: false,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 30,
            ),
          ),
          ProfileItem(
            text: languageCubit.carModel!,
            val: customer.cars![carNumber].carModel,
            dropdown: false,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 30,
            ),
          ),
          ProfileItem(
            text: languageCubit.carColor!,
            val: customer.cars![carNumber].carColor,
            dropdown: false,
            icon: SizedBox(
              width: 0,
              height: 0,
            ),
          ),
          GestureDetector(
            onTap: () {
              UpdateProfileCubit updateProfileCubit =
                  UpdateProfileCubit.instance(context);
              updateProfileCubit.deleteCustomerCar(customer.id.toString(),
                  customer.cars![carNumber].id.toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('حذف معلومات السيارة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
