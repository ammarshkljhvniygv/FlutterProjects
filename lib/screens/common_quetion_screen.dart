import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/aboutas_cubit.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/common_question.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../StateManagement/blocs/aboutas_state.dart';

class CommonQuetionScreen extends StatefulWidget {
  const CommonQuetionScreen({Key? key}) : super(key: key);

  @override
  State<CommonQuetionScreen> createState() => _CommonQuetionScreenState();
}

class _CommonQuetionScreenState extends State<CommonQuetionScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SettingCubit settingCubit = SettingCubit.instance(context);
    settingCubit.getCommonQuestions();
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            languageCubit.FAQ!,
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
              BlocConsumer<SettingCubit, SettingStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetCommonQuestionStarted) {
                      return SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    else if (state is GetCommonQuestionFinishSuccess) {
                      List<CommonQuestion> questions = state.questions! ;

                      return Expanded(child:
                      ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Directionality(
                            textDirection:languageCubit.language=='AR'? TextDirection.rtl:TextDirection.ltr,
                            child: ExpansionTile(

                              title: Text(
                                  languageCubit.language=='AR'? questions[index].arQuestion:questions[index].enQuestion,
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: kPrimaryColor
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                      languageCubit.language=='AR'? questions[index].arAnswer:questions[index].enAnswer,
                                    style: GoogleFonts.cairo(
                                        fontSize: 15,
                                    ),

                                  ),
                                )
                              ],
                            ),
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


              /*     Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return ;
                  },
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
