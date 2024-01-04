import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';

class MyDirectionality extends StatelessWidget {
  const MyDirectionality({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Directionality(
      textDirection: languageCubit.language == 'AR'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: child,
    );
  }
}
