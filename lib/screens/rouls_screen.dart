import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/aboutas_cubit.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/rulesandcondition.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../StateManagement/blocs/aboutas_state.dart';

class ConditionsScreen extends StatefulWidget {
  const ConditionsScreen({Key? key}) : super(key: key);

  @override
  State<ConditionsScreen> createState() => _ConditionsScreenState();
}

class _ConditionsScreenState extends State<ConditionsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<String> listText = [
    'شركة متخصصة  في تقديم خدمات النقل و المساعدة على الطريق، وذلك لكونها حلقة الوصل بين العميل و مزود الخدمة بشكل فوري',
    'باختيار العميل المزود ومعرفة التوقيت المتوقع لوصول مزود الخدمة المختار ثم انتظار المزود ،وفي حالة إلغاء مزود الخدمة للطلب، يحق للعميل العودة لصفحة مزودي الخدمة وطلب مزود خدمه اخر',
    'يسمح للعميل أن يتواصل مع مزود الخدمة بعد طلبه للخدمة المطلوبة، والتطبيق غير مسئول عن التواصل مع المزود خارجها',
    'في حالة طلب العميل خدمة وِنش من خلال التطبيق، ستجد أقرب ونش لحمل سيارتك للمكان المحدد من طرف العميل، ويتم حساب تكلفته بناء على طول المشوار والاتفاق مع عربة الونش وتستثني الخدمة في الحوادث',
    'إذا تم إلغاء الخدمة من قبل العميل يجب كتابه سبب الإلغاء في المكان الذي يظهر له عند عمل إلغاء  وإلا سوف يتم حذفه من التطبيق ولم يتمكن من طلب الخدمة من خلال التطبيق مره اخري.',
  ];
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    SettingCubit settingCubit = SettingCubit.instance(context);
    settingCubit.getRulesAndConditions();

    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            languageCubit.TermsConditions!,
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
              ),


              BlocConsumer<SettingCubit, SettingStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetRulesAndConditionStarted) {
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (state is GetRulesAndConditionFinishSuccess) {
                      List<RuleAndConditions> rules = state.rulesAndConditions! ;

                      return Expanded(
                        child: ListView.builder(
                          itemCount: rules.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.75,
                                    child: Text(
                                     languageCubit.language == 'AR'? rules[index].arText : rules[index].enText,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.info,
                                      color: kPrimaryColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is GetRulesAndConditionFinishWithError) {
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

            ],
          ),
        ),
      ),
    );
  }
}
