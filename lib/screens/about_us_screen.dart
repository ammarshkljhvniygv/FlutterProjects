import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/aboutusitem.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../StateManagement/blocs/aboutas_cubit.dart';
import '../StateManagement/blocs/aboutas_state.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    SettingCubit aboutAsCubit = SettingCubit.instance(context);
    aboutAsCubit.getData();

    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            languageCubit.AboutUs!,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
              ),/*
              Text(
                'شركة ورشة أوت ',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              Text(
                'شركة متخصصة  في تقديم خدمات النقل و المساعدة على الطريق، وذلك لكونها حلقة الوصل بين العميل و مزود الخدمة بشكل فوري',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                'يمكنك استخدام التطبيق دون اشتراك مسبق، ولا يتم دفع قيمة الخدمة ورسوم تقديمها إلا عند طلب المساعدة ',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                'لماذا ورشة أوت ',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),*/
              BlocConsumer<SettingCubit, SettingStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetDataStarted) {
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (state is GetDataFinishSuccess) {
                      List<AboutAsItem> items = state.items! ;

                      return Expanded(child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                             languageCubit.language=='AR'?items[index].arTitle:items[index].enTitle,/**/
                                style: GoogleFonts.roboto(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                languageCubit.language=='AR'?items[index].arBody:items[index].enBody,/*:سهولة التواصل*/

                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          );
                        },));
                    } else if (state is GetDataFinishWithError) {
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );;
                    } else {
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );;
                    }
                  }),





          /*    Text(
                ':خاصية التتبع',
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                'تتيح لك تتبع مزود الخدمة في طريقه إليك، بعد قبول طلبك من خلال جوجل ماب ',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),

              Text(
                ':مرونة الدفع',
                style: GoogleFonts.roboto(
                  decoration: TextDecoration.underline,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
              Text(
                'يمكنك دفع تكلفة الخدمة في موقع العميل  نفسه، بواسطة الفيزا من خلال التطبيق أو نقدا للمزود مباشرة بعد تنفيذ الخدمة المطلوبة',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
