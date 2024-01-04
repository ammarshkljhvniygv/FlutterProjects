import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../../models/aboutusitem.dart';
import '../../models/common_question.dart';
import '../../models/offer.dart';
import '../../models/privacy_and_policy.dart';
import '../../models/rulesandcondition.dart';
import 'aboutas_state.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(AboutAsInit());

  static SettingCubit instance(BuildContext context) =>
      BlocProvider.of(context);


  Future<void> getData() async{
    emit(GetDataStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getAboutAsData',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> items =map;
      List<AboutAsItem> allItems =[];

      for(int i = 0 ; i < items.length ; i++){
        AboutAsItem? item = AboutAsItem.fromJsonArray(items[i]);
        allItems.add(item!);
      }

      emit(GetDataFinishSuccess(items: allItems));
    } else {
      print(response2.body);
      emit(GetDataFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

  Future<void> getCommonQuestions() async{
    emit(GetCommonQuestionStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getCommonQuestions1',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> questions =map;
      List<CommonQuestion> allQuestions =[];

      for(int i = 0 ; i < questions.length ; i++){
        CommonQuestion? question = CommonQuestion.fromJsonArray(questions[i]);
        allQuestions.add(question!);
      }

      emit(GetCommonQuestionFinishSuccess(questions: allQuestions));
    } else {
      print(response2.body);
      emit(GetCommonQuestionFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

  Future<void> getRulesAndConditions() async{
    emit(GetRulesAndConditionStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getRules',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> rules =map;
      List<RuleAndConditions> allRules =[];

      for(int i = 0 ; i < rules.length ; i++){
        RuleAndConditions? rule = RuleAndConditions.fromJsonArray(rules[i]);
        allRules.add(rule!);
      }

      emit(GetRulesAndConditionFinishSuccess(rulesAndConditions: allRules));
    } else {
      print(response2.body);
      emit(GetRulesAndConditionFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

  Future<void> getPrivacyAndPolice() async{
    emit(GetPrivacyAndPolicyStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getPrivacyAndPolice1',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> privacyAndPolicies =map;
      List<PrivacyAndPolicy> allPrivacyAndPolicy =[];

      for(int i = 0 ; i < privacyAndPolicies.length ; i++){
        PrivacyAndPolicy? privacyAndPolicy = PrivacyAndPolicy.fromJsonArray(privacyAndPolicies[i]);
        allPrivacyAndPolicy.add(privacyAndPolicy!);
      }

      emit(GetPrivacyAndPolicyFinishSuccess(privacyAndPolicy: allPrivacyAndPolicy));
    } else {
      print(response2.body);
      emit(GetRulesAndConditionFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

  Future<void> getOffers() async{
    emit(GetOfferStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getOffers1',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> offers =map;
      List<Offer> allOffers =[];

      for(int i = 0 ; i < offers.length ; i++){
        Offer? offer = Offer.fromJsonArray(offers[i]);
        allOffers.add(offer!);
      }

      emit(GetOffersFinishSuccess(offers: allOffers));
    } else {
      print(response2.body);
      emit(GetOfferFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }
///////////////////////////////////////////////////////////
  Future<List<String>> getOthers() async{
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getOthers1',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> links =map;
      List<String> allLinks =[];

      for(int i = 0 ; i < links.length ; i++){
        allLinks.add(links[i]['link']);
      }

      return allLinks;
    } else {
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }

}