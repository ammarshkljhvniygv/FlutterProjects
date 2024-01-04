import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/screens/customer_screens/customer_registration_screen.dart';
// import 'package:onroad/screens/provider_screens/provider_islogin_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:moyasar/moyasar.dart';
class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  String lang = '';

  void initState() {
    getLanguage();
    super.initState();
  }

  Future<void> getLanguage() async {
    lang = (await CacheManager.getInstance()!.getLanguage())!;
    setState(() {});
  }
  Future<void> launch(String link) async {
    // String url = "whatsapp://send?phone=+$number";
    await launchUrlString(
      link,
      mode: LaunchMode.externalApplication
    );
  }

  Future<void> setLanguage(String lan) async {
    await CacheManager.getInstance()!.setLanguage(lan);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 35, left: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        if (lang == 'EN') {
                          lang = 'AR';
                          setLanguage(lang);
                          languageCubit.changeLanguage('AR');
                        } else {
                          lang = 'EN';
                          setLanguage(lang);
                          languageCubit.changeLanguage('EN');
                        }
                      });
                      setState(() {});
                    },
                    child: Container(
                      width: 64,
                      height: 33,
                      decoration: BoxDecoration(
                          border: Border.all(color: kPrimaryColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          lang == 'AR' ? 'EN' : 'ع',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: 350,
              height: size.width*0.75,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: const AssetImage('assets/images/Group 374.png'),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.03),
                        offset: const Offset(0, 0),
                        blurRadius: 20)
                  ]),
            ),
            // Image.asset('assets/images/Group-110.png',/*height: 335,*/fit: BoxFit.contain,width: 500,),
            SizedBox(
              height: size.height * 0.01,
            ),
            /*ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegistrationScreen();
                  }));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        kPrimaryColor.withOpacity(1))),
                child: Text(
                  languageCubit.askHelp!,
                  style: GoogleFonts.cairo(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),*/

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegistrationScreen();
                }));
              },
              child: Container(
                width: size.width * 0.75,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: kPrimaryColor,
                ),
                child: Center(
                  child: Text(
                    languageCubit.askHelp!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PaymentMethods();
                }));
              },
              child: Container(
                width: size.width * 0.6,
                height: 46,
                decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor2, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(7))),
                child: Center(
                  child: Text(
                    languageCubit.joinasprovider!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor2,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Text(
              languageCubit.knowMore!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: (){
                launch('https://www.warshaout.com');

             },
              child: Text(
              'www.warshaout.com',
              style: const TextStyle(
                fontSize: 16,
              ),
            ), )
          ],
        ),
      ),
    );
  }
}


class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_Zo82NxkNYDV5ZJ7vAKJacJ89ZLe1BVSSS9bjTwgi',
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
   applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME'),
  );

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {

        case PaymentStatus.initiated:
          // TODO: Handle this case.
          break;
        case PaymentStatus.paid:
          print('-----------------------paid');

          // TODO: Handle this case.
          break;
        case PaymentStatus.failed:
          print('-----------------------failed');

          // TODO: Handle this case.
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ApplePay(
              config: paymentConfig,
              onPaymentResult: onPaymentResult,
            ),
          ),
          const Text("or"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CreditCard(
              config: paymentConfig,
              onPaymentResult: onPaymentResult,
            ),
          )
        ],
      ),
    );
  }
}