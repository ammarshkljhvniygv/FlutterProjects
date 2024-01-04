


import '../../models/aboutusitem.dart';
import '../../models/common_question.dart';
import '../../models/offer.dart';
import '../../models/privacy_and_policy.dart';
import '../../models/rulesandcondition.dart';

abstract class SettingStates {
  const SettingStates();
}

class AboutAsInit extends SettingStates {}

class GetDataFinishSuccess extends SettingStates {
  List<AboutAsItem>? items;
  GetDataFinishSuccess({ this.items});
}


class GetDataFinishWithError extends SettingStates {}

class GetDataStarted extends SettingStates {}

////////////////////////

class CommonQuestionInit extends SettingStates {}

class GetCommonQuestionFinishSuccess extends SettingStates {
  List<CommonQuestion>? questions;
  GetCommonQuestionFinishSuccess({ this.questions});
}
class GetCommonQuestionFinishWithError extends SettingStates {}

class GetCommonQuestionStarted extends SettingStates {}

////////////////////////

class RulesAndConditionInit extends SettingStates {}

class GetRulesAndConditionFinishSuccess extends SettingStates {
  List<RuleAndConditions>? rulesAndConditions;
  GetRulesAndConditionFinishSuccess({ this.rulesAndConditions});
}
class GetRulesAndConditionFinishWithError extends SettingStates {}

class GetRulesAndConditionStarted extends SettingStates {}

////////////////////////

class PrivacyAndPolicyInit extends SettingStates {}

class GetPrivacyAndPolicyFinishSuccess extends SettingStates {
  List<PrivacyAndPolicy>? privacyAndPolicy;
  GetPrivacyAndPolicyFinishSuccess({ this.privacyAndPolicy});
}

class GetPrivacyAndPolicyFinishWithError extends SettingStates {}

class GetPrivacyAndPolicyStarted extends SettingStates {}
////////////////////////

class OffersInit extends SettingStates {}

class GetOffersFinishSuccess extends SettingStates {
  List<Offer>? offers;
  GetOffersFinishSuccess({ this.offers});
}
class GetOfferFinishWithError extends SettingStates {}

class GetOfferStarted extends SettingStates {}
