abstract class LanguageStates {
  const LanguageStates();
}

class LanguageInitial extends LanguageStates {}

class GetLanguageState extends LanguageStates {
  String? lang;

  GetLanguageState({required this.lang});
}
