import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    // tabController = TabController(length: taps.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return FadeTransition(
      opacity: _animationController,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset('assets/images/img_1.png'),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async {
                  await Share.share('link', subject: 'my link');
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor.withOpacity(0.9))),
                child: Text(
                  languageCubit.shareLink!,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
