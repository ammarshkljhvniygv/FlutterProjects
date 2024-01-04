import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(GetLanguageState(lang: 'AR'));

  static LanguageCubit instance(BuildContext context) =>
      BlocProvider.of(context);

  String? language = 'AR';
  String? askHelp = 'أطلب مساعدة';
  String? joinasprovider = 'انضم كمزود';
  String? skip = 'تخطي';
  String? Continue = 'استمر';
  String? DHaveaccount = 'ليس لديك حساب ؟      ';
  String? Ahaveanaccount = 'مسجل من قبل ؟';
  String? Createanaccount = 'إنشاء حساب';
  String? UserName = "اسم المستخدم";
  String? Password = "كلمة المرور";
  String? Email = "البريد الإلكتروني";
  String? Mobile = "رقم الهاتف";
  String? Yourcarnumber = "رقم لوحة سيارة مزود الخدمة";
  String? youHaveTo = " يجب عليك إدخال ";
  String? youHaveToAcceptPrivacy = "يجب عليك الموافقة على الشروط و الأحكام";
  String? login = "تسجيل الدخول";
  String? LDiscover = "لنكتشف معاً ";
  String? wwhtoday = "من سنساعد اليوم";
  String? addCard = 'إضافة بطاقة إلكترونية';
  String? AcceptPrivacy = 'الموافقة على الشروط والأحكام';
  String? ContinueRegistration = "استكمل التسجيل";
  String? t1r = 'يسعدنا إنضمامك معنا كـمزود';
  String? t2r = 'من فضلك قم بتسجيل بياناتك';
  String? t1r2 = 'تبقى القليل';
  String? t2r2 = 'وتصبح أحد مزودينا';
  String? tq1r2 = 'هل يوجد ورشة إصلاح ؟';
  String? tq2r2 = 'يرجى إضافة عنوان الورشة';
  String? tq3r2 = 'هل لديك رخصة مزاولة المهنة ؟';
  String? tq4r2 = 'ما هي نوعية العمل ؟';
  String? tq5r2 = 'يرجى تحديد الخدمات التي تقدمها';
  String? yes = 'نعم';
  String? no = 'لا';
  String? Independent = 'فردي';
  String? Company = 'تابع لشركة';
  String? Customerservices = 'خدمة العملاء';
  String? SignUp = 'أنشئ الحساب';
  String? WriteAddress = ' العنوان';
  String? rsuccessfully = 'تم اكتمال التسجيل بنجاح';
  String? trs1 = 'سيتم مراجعة طلبك ';
  String? trs2 = 'و التواصل معك لتفعيل الحساب';
  String? trclose = 'إغلاق';
  String? carMade = 'صنع السيارة';
  String? carModel = 'موديل السيارة';
  String? carColor = 'لون السيارة';
  String? t1rc = 'يسعدنا تسجيل بيانات سيارتك';
  String? t2rc = 'حتى نتمكن من المساعدة ';
  String? sendCode = 'إرسال كود التحقق';
  String? regyourcar = 'سجل السيارة';
  String? t1lc = 'مرحـباً بك';
  String? t2lc = 'يـرجى إدخـال رقـم الجـوال';
  String? Verification = 'تأكيد';
  String? t1otp =
      'من فضلك قم بإدخال كود التحقق المكوَن من 6 أرقام الذي تم إرساله إلى الجوال';
  String? otp = 'كود التحقق';
  String? resend = 'إعادة إرسال';
  String? t2otp = 'لم يصلك الكود؟';
  String? Batteryservices = 'خدمة البطارية';
  String? Carlocked = 'فتح السيارة ';
  String? Repairtire = 'خدمة الاطارات ';
  String? Emptyfuel = 'توصيل وقود';
  String? Towing = 'خدمة سحب وانقاذ';
  String? otherServ = 'خدمات اخرى';
  String? chooseServ = 'اختر الخدمة';
  String? hcwHelp = 'كيف يمكننا مساعدتك اليوم ؟';
  String? AboutUs = 'من نحن';
  String? FAQ = 'الأسئلة شائعة';
  String? TermsConditions = 'الشروط والاحكام';
  String? Contactus = 'تواصل معنا';
  String? Reviewourapp = 'تقييم التطبيق';
  String? Logout = 'تسجيل خروج';
  String? home = 'الرئيسية';
  String? profile = 'حسابي';
  String? share = 'مشاركة';
  String? offers = 'أخر العروض';
  String? chatUs = 'خدمة العملاء';
  String? Replacetire = 'تبديل الإطار';
  String? Replacetire2 = 'تبديل الإطار';
  String? Repairtire2 = 'تصليح الإطار (رقعة خارجية)';
  String? Repairtire3 = 'تصليح الإطار ';
  String? tireServ = 'خدمة الإطارات';
  String? batteryServ = 'خدمة البطارية';
  String? chserv = 'يرجى اختيار الخدمة';
  String? batteryCable = 'وصلة بطارية';
  String? changeBattery = 'تبديل البطارية';
  String? location = 'حدد موقعك الحالي ';
  String? edit = 'تعديل';
  String? show = 'عرض';
  String? deleteAccount = 'حذف الحساب ';
  String? deleteAccount2 = 'سيتم حذف الحساب  و محتوياته ';
  String? addNewCar = 'إضافة سيارة جديدة';
  String? Save = 'حفظ';
  String? Car = 'سيارة';
  String? accept = 'قبول';
  String? cancel = 'إلغاء';
  String? shareLink = 'مشاركة الرابط';
  String? noOffers = 'لا توجد عروض  في الفترة الحالية تابعنا قريباً';
  String? t1Contactus = 'يمكنك التواصل معنا من خلال ';
  String? t2Contactus =
      'لأي استفسارات او إيضاحات من فضلك قم بالتواصل مع خدمه العملاء ';
  String? t3Contactus = 'وفريقنا سيقوم  بالرد عليكم  في اقرب وقت';
  String? t4Contactus = 'الرئيس التنفيذي لشركة ورشة أوت';
  String? logOut2 = "سيتم تسجيل الخروج ";
  String? locationt1 = "برجاء قم بتحديد موقعك";
  String? locationt2 = "تم التحديد";
  String? locationt3 = "البحث عن المزود الأقرب";
  String? locationt4 = "موقعي";
  String? locationt5 = 'قم بتحيد موقعك اولا';
  String? choosept1 = ' عربة مزودي خدمات لمساعدتك';
  String? choosept1_2 = 'يوجد ';
  String? choosept2 = 'من فضلك اختر الأنسب أو الأقرب لك';
  String? choosept3 = 'المزودين المتاحين';
  String? choosept4 = 'دقائق';
  String? choosept5 = ' - الوقت المقدر للوصول';
  String? completeOrdert1 =
      'تحدد تكلفة خدمة السحب و الإنقاذ عند تواصلك مع مزود الخدمة أو "سائق الونش"، وذلك بعد الاتفاق على موقع الوصول، ومسافة السحب من نقطة الانطلاق لنقطة الوصول ';
  String? completeOrdert2_1 =
      '';
  String? completeOrdert2_2 =
      'تكلفة خدمة وصلة البطارية 3 دينار بدون أي مصاريف آخرى جانبية, تكلفه خدمة تبديل البطاريه تحدد من قبل المزود المختار';
  String? completeOrdert3 = 'تكلفة خدمة فتح السيارة تحدد من قبل المزود المختار';
  String? completeOrdert4_1 =
      '';
  String? completeOrdert4_2 =
      ' تكلفة  خدمة توصيل الوقود 7 دينار بدون أي.مصاريف آخرى جانبية يرجي الإنتباه أقصى حد للتزويد بالوقود 10 لتر، والتي تتيح لك الوصول لأقرب محطة وقود ';
  String? completeOrdert5_1 =
      'تكلفة  خدمة تبديل الإطار 7 دينار بدون أي مصاريف آخرى جانبية';
  String? completeOrdert5_2 =
      'تكلفة  خدمة تصليح الإطار 7 دينار بدون أي مصاريف آخرى جانبية';
  String? completeOrder = 'استكمال الطلب';
  String? copletOrdert7 =
      'برجاء الإنتباه  في حالة طلب أعمال آخرى غير مطلوبة، سيتم زيادة التكلفة';
  String? copletOrdert8 = 'برجاء قراءة الشروط و الأحكام';
  String? copletOrdert9 = 'إضغط موافقة، لإرسال الطلب والتحدث مع مزود الخدمة';
  String? acceptedOrderT1 = 'تم قبول طلبك بنجاح';
  String? acceptedOrderT2 = 'سيقوم مزود الخدمة بالإتجاه إليك ';
  String? acceptedOrderT3 = 'تتبع طريق المزود';
  String? acceptedOrderT4 = 'تواصل مع المزود';
  String? acceptedOrderT5 = 'يتم الدفع بعد تقديم الخدمة';
  String? pay = 'الــدفــع';
  String? cancelOrder = 'إلـغـاء الطـلـب';
  String? openMap = 'افتح الخريطة';
  String? orderState = 'حالة الطلب ';
  String? acceptedOrder = 'مقبول';
  String? cancelOrderT1 = 'يرجى تحديد سبب الإلغاء';
  String? cancelOrderT2 = 'تأخر المزود عن الوقت المتوقع';
  String? cancelOrderT3 = 'السعر غير مناسب للخدمة';
  String? cancelOrderT4 = 'وصلتنى خدمة آخرى';
  String? cancelOrderT5 = 'تم حل المشكلة ';
  String? cancelOrderT6 = 'آخرى';
  String? cancelOrderT7 = 'يتم هنا كتابة السبب او أي ملاحظات اخرى';
  String? cancelOrderT8 = ' العودة للطلب من جديد ';
  String? cancelOrderT9 = 'إرسال';
  String? cancelOrderT10 = 'ساعدنا على تحسين الخدمة';
  String? thanks = 'شكرا';
  String? thanksT1 = 'نحن سعداء حقاً بوجودك معنا';
  String? thanksT2 = 'الخروج';
  String? payT1 = 'الرجاء تحديد التكلفة ووسيلة الدفع';
  String? payT2 = 'تكلفة الخدمة';
  String? payT3 = 'نفس القيمة';
  String? payT4 = 'القيمه المدفوعه';
  String? payT5 = 'وسيلة الدفع';
  String? payT6 = 'بطاقة';
  String? payT7 = 'كاش';
  String? payT8 = 'إتمام الدفع';
  String? payT9 = ' تقييمك يهمنا ';
  String? payT10 = 'تقييم الخدمة';
  String? payT11 = 'السرعة';
  String? payT12 = 'التواصل';
  String? payT13 = 'السهولة';
  String? payT14 = 'تقييم المزود';
  String? payT15 = 'الكفاءة';
  String? payT16 = 'السلوك';
  String? payT17 = 'موافق';
  String? timerT = 'برجاء الانتظار حتي يتم اشعار مزود الخدمة والتاكيد علي طلبك';
  String? busyT1 = 'يبدو ان مزود الخدمة مشغول حالياً يرجى اختيار مزود خدمة اخر';
  String? busyT2 = 'اختيار مزود آخر';
  String? busyT3 = 'إلـغـاء الطـلـب';
  String? open = 'مفتوح';
  String? rejected = 'مرفوض';
  String? complete = 'مكتمل';
  String? orderNumber = 'رقم الطلب ';
  String? timeSend = 'وقت الإرسال';
  String? email = 'البريد الإلكتروني';
  String? acceptableT1 = 'تفاصيل طلب المساعدة';
  String? acceptableT2 = '    الوقت المتبقي لإمكانية قبول الطلب   ';
  String? reject = 'رفض';
  String? acceptableT3 = 'التكلفة المتوقعة للخدمة';
  String? acceptableT4 = 'نوع الخدمة المطلوبة';
  String? acceptableT5 = 'موقع العميل';
  String? acceptableT6 = 'صنع سيارة العميل';
  String? acceptableT7 = 'موديل سيارة العميل';
  String? acceptableT8 = 'لون سيارة العميل';
  String? acceptedPT1 = 'جاري تنفيذ الطلب';
  String? acceptedPT2 = 'تواصل مع العميل';
  String? acceptedPT3 = 'تأكيد إلغاء الطلب ';
  String? acceptedPT4 = 'رقم هاتف العميل';
  String? helpDon = 'تمت المساعدة ';
  String? rejectDon = 'تم رفض الطلب ';
  String? cancelDon = 'تم إلغاء المساعدة ';
  String? thanksP = 'شكراً لكونك من مزودينا الرائعين';
  String? payDon = 'تم تحويل المبلغ بنجاح ';
  String? checked = 'تم الإستلام';
  String? doesNotCheck = 'لم يتم الإستلام';
  String? payCheck2 = 'الرجاء التاكيد إن كنت قد استلمت المبلغ المتفق عليه';
  String? payCheck3 = 'الرجاء الإنتظار حتى يتم تاكيد عمليه الدفع من قبل المزود';
  String? addCardT1 = 'من فضلك قم بإدخال بيانات البطاقة';
  String? addCardT2 = 'رقم البطاقة';
  String? addCardT3 = 'رمز الأمان';
  String? addCardT4 = 'تاريخ الإنتهاء';
  String? addCardT5 = 'الإسم';
  String? addCardT6 = 'أضف البطاقة';
  String? r2t1 = 'يجب عليك تحديد خدمة واحدة على الأقل لتقدمها ';
  String? chooseLanguage = 'اختر اللغة';
  String? notification = 'إشعارات و تنبيهات';
  String? privacyPolicy = 'سياسة الخصوصية';
  String? canceled = 'ملغي';
  String? timeout = 'فائت';
  String? payCheck = 'تاكيدالإستلام';
  String? choosePFirst = 'قم باختيار مزود خدمة أولا';
  String? phoneDNotE =
      'للأسف لم يتم العثور على حساب مسجل باستخدام الرقم الذي قمت بإدخاله, يمكنك انشاء حساب جديد';
  String? phoneUsed =
      'تم انشاء حساب مسبقا باستخدام رقم الهاتف الذي قمت بإدخاله, يمكنك تسجيل دخول باستخدامه';
  String? notificationSetting = 'إعدادات الإشعارات';
  String? notificationSound= 'نغمه الإشعارات ';
  String? sound= 'نغمه';
  String? chooseSound= 'اختر نغمه ';
  String? knowMore= 'اعرف عنا أكثر؟';
  String? or= 'او';
  String? sendToUs= 'راسلنا لطلب الخدمه';
  String? chatSupport= 'رجاء قم بالتواصل مع الدعم الفني لتوضيح سبب عدم استلام المبلغ من العميل ';
  String? chatSupport2= 'رجاء قم بالتواصل مع الدعم الفني لتوضيح سبب عدم تأكيد المزود لعمليه استلام المبلغ  ';
  String? addOneCarAtlest= 'يجب عليك ادخال معلومات سياره واحده علـى الأقل';




  void changeLanguage(String? lang) {
    language = lang;
    emit(GetLanguageState(lang: language));

    if (language == 'AR') {
      chatSupport2= 'رجاء قم بالتواصل مع الدعم الفني لتوضيح سبب عدم تأكيد المزود لعمليه استلام المبلغ  ';
      chatSupport= 'رجاء قم بالتواصل مع الدعم الفني لتوضيح سبب عدم استلام المبلغ من العميل ';
      payCheck3 = 'الرجاء الإنتظار حتى يتم تاكيد عمليه الدفع من قبل المزود';
      payCheck = 'تاكيدالإستلام';
       checked = 'تم الإستلام';
       doesNotCheck = 'لم يتم الإستلام';
       payCheck2 = 'الرجاء التاكيد إن كنت قد استلمت المبلغ المتفق عليه';
      addOneCarAtlest= 'يجب عليك ادخال معلومات سياره واحده علـى الأقل';
      sendToUs= 'راسلنا لطلب الخدمه';
      or= 'او';
      knowMore= 'اعرف عنا أكثر؟';
      notificationSound= 'نغمه الإشعارات ';
      sound= 'نغمه';
      chooseSound= 'اختر نغمه ';
      notificationSetting = 'إعدادات الإشعارات';
      canceled = 'ملغي';
      timeout = 'فائت';
      phoneUsed =
          'تم انشاء حساب مسبقا باستخدام رقم الهاتف الذي قمت بإدخاله, يمكنك تسجيل دخول باستخدامه';
      phoneDNotE =
          'للأسف لم يتم العثور على حساب مسجل باستخدام الرقم الذي قمت بإدخاله, يمكنك انشاء حساب جديد';
      choosePFirst = 'قم باختيار مزود خدمة أولا';
      privacyPolicy = 'سياسة الخصوصية';
      notification = 'إشعارات و تنبيهات';
      chooseLanguage = 'اختر اللغة';
      AboutUs = 'من نحن';
      r2t1 = 'يجب عليك تحديد خدمة واحدة على الأقل لتقدمها ';
      addCardT1 = 'من فضلك قم بإدخال بيانات البطاقة';
      addCardT2 = 'رقم البطاقة';
      addCardT3 = 'رمز الأمان';
      addCardT4 = 'تاريخ الإنتهاء';
      addCardT5 = 'الإسم';
      addCardT6 = 'أضف البطاقة';
      helpDon = 'تمت المساعدة ';
      rejectDon = 'تم رفض الطلب ';
      cancelDon = 'تم إلغاء المساعدة ';
      thanksP = 'شكراً لكونك من مزودينا الرائعين';
      payDon = 'تم تحويل المبلغ بنجاح ';
      acceptedPT4 = 'رقم هاتف العميل';
      acceptedPT1 = 'جاري تنفيذ الطلب';
      acceptedPT2 = 'تواصل مع العميل';
      acceptedPT3 = 'تأكيد إلغاء الطلب ';
      acceptableT3 = 'التكلفة المتوقعة للخدمة';
      acceptableT4 = 'نوع الخدمة المطلوبة';
      acceptableT5 = 'موقع العميل';
      acceptableT6 = 'صنع سيارة العميل';
      acceptableT7 = 'موديل سيارة العميل';
      acceptableT8 = 'لون سيارة العميل';
      reject = 'رفض';
      acceptableT1 = 'تفاصيل طلب المساعدة';
      acceptableT2 = '    الوقت المتبقي لإمكانية قبول الطلب   ';
      email = 'البريد الإلكتروني';
      timeSend = 'وقت الإرسال';
      open = 'مفتوح';
      rejected = 'مرفوض';
      complete = 'مكتمل';
      orderNumber = 'رقم الطلب ';
      busyT1 = 'يبدو ان مزود الخدمة مشغول حالياً يرجى اختيار مزود خدمة اخر';
      busyT2 = 'اختيار مزود آخر';
      busyT3 = 'إلـغـاء الطـلـب';

      timerT = 'برجاء الانتظار حتي يتم اشعار مزود الخدمة والتاكيد علي طلبك';
      payT17 = 'موافق';
      payT1 = 'الرجاء تحديد التكلفة ووسيلة الدفع';
      payT2 = 'تكلفة الخدمة';
      payT3 = 'نفس القيمة';
      payT4 = 'القيمه المدفوعه';
      payT5 = 'وسيلة الدفع';
      payT6 = 'بطاقة';
      payT7 = 'كاش';
      payT8 = 'إتمام الدفع';
      payT9 = ' تقييمك يهمنا ';
      payT10 = 'تقييم الخدمة';
      payT11 = 'السرعة';
      payT12 = 'التواصل';
      payT13 = 'السهولة';
      payT14 = 'تقييم المزود';
      payT15 = 'الكفاءة';
      payT16 = 'السلوك';
      thanks = 'شكرا';
      thanksT1 = 'نحن سعداء حقاً بوجودك معنا';
      thanksT2 = 'الخروج';
      cancelOrderT1 = 'يرجى تحديد سبب الإلغاء';
      cancelOrderT2 = 'تأخر المزود عن الوقت المتوقع';
      cancelOrderT3 = 'السعر غير مناسب للخدمة';
      cancelOrderT4 = 'وصلتنى خدمة آخرى';
      cancelOrderT5 = 'تم حل المشكلة ';
      cancelOrderT6 = 'آخرى';
      cancelOrderT7 = 'يتم هنا كتابة السبب او أي ملاحظات اخرى';
      cancelOrderT8 = ' العودة للطلب من جديد ';
      cancelOrderT9 = 'إرسال';
      cancelOrderT10 = 'ساعدنا على تحسين الخدمة';
      acceptedOrderT1 = 'تم قبول طلبك بنجاح';
      acceptedOrderT2 = 'سيقوم مزود الخدمة بالإتجاه إليك ';
      acceptedOrderT3 = 'تتبع طريق المزود';
      acceptedOrderT4 = 'تواصل مع المزود';
      acceptedOrderT5 = 'يتم الدفع بعد تقديم الخدمة';
      pay = 'الــدفــع';
      cancelOrder = 'إلـغـاء الطـلـب';
      openMap = 'افتح الخريطة';
      orderState = 'حالة الطلب ';
      acceptedOrder = 'مقبول';
      completeOrdert1 =
          'تحدد تكلفة خدمة السحب و الإنقاذ عند تواصلك مع مزود الخدمة أو "سائق الونش"، وذلك بعد الاتفاق على موقع الوصول، ومسافة السحب من نقطة الانطلاق لنقطة الوصول ';
      completeOrdert2_1 =
          'تكلفة خدمة وصلة البطارية 3 دينار بدون أي مصاريف آخرى جانبية';
      completeOrdert2_2 =
          'تكلفة خدمة تبديل البطارية 3 دينار بدون أي مصاريف آخرى جانبية';
      completeOrdert3 =
          'تكلفة خدمة فتح السيارة 7  دينار بدون أي مصاريف آخرى جانبية';
      completeOrdert4_1 =
          'تكلفة  خدمة توصيل الوقود 7 دينار بدون أي.مصاريف آخرى جانبية';
      completeOrdert4_2 =
          'يرجي الإنتباه أقصى حد للتزويد بالوقود 10 لتر، والتي تتيح لك الوصول لأقرب محطة وقود';
      completeOrdert5_1 =
          'تكلفة  خدمة تبديل الإطار 7 دينار بدون أي مصاريف آخرى جانبية';
      completeOrdert5_2 =
          'تكلفة  خدمة تصليح الإطار 7 دينار بدون أي مصاريف آخرى جانبية';
      completeOrder = 'استكمال الطلب';
      copletOrdert7 =
          'برجاء الإنتباه  في حالة طلب أعمال آخرى غير مطلوبة، سيتم زيادة التكلفة';
      copletOrdert8 = 'برجاء قراءة الشروط و الأحكام';
      copletOrdert9 = 'إضغط موافقة، لإرسال الطلب والتحدث مع مزود الخدمة';
      choosept1 = ' عربة مزودي خدمات لمساعدتك';
      choosept1_2 = 'يوجد ';
      choosept2 = 'من فضلك اختر الأنسب أو الأقرب لك';
      choosept3 = 'المزودين المتاحين';
      choosept4 = 'دقائق';
      choosept5 = ' - الوقت المقدر للوصول';
      locationt5 = 'قم بتحيد موقعك اولا';
      locationt1 = "برجاء قم بتحديد موقعك";
      locationt2 = "تم التحديد";
      locationt3 = "البحث عن المزود الأقرب";
      locationt4 = "موقعي";
      logOut2 = "سيتم تسجيل الخروج ";
      t1Contactus = 'يمكنك التواصل معنا من خلال ';
      t2Contactus =
          'لأي استفسارات او إيضاحات من فضلك قم بالتواصل مع خدمه العملاء  ';
      t3Contactus = 'وفريقنا سيقوم  بالرد عليكم  في اقرب وقت';
      t4Contactus = 'الرئيس التنفيذي لشركة ورشة أوت';
      noOffers = 'لا توجد عروض  في الفترة الحالية تابعنا قريباً';
      shareLink = 'مشاركة الرابط';
      accept = 'قبول';
      cancel = 'إلغاء';
      deleteAccount2 = 'سيتم حذف الحساب  و محتوياته ';
      edit = 'تعديل';
      show = 'عرض';
      deleteAccount = 'حذف الحساب ';
      addNewCar = 'إضافة سيارة جديدة';
      Save = 'حفظ';
      Car = 'سيارة';
      Replacetire = 'تبديل الإطار';
      Replacetire2 = 'تبديل الإطار';
      Repairtire2 = 'تصليح الإطار (رقعة خارجية)';
      Repairtire3 = 'تصليح الإطار ';
      tireServ = 'خدمة الإطارات';
      batteryServ = 'خدمة البطارية';
      chserv = 'يرجى اختيار الخدمة';
      batteryCable = 'وصلة بطارية';
      changeBattery = 'تبديل البطارية';
      location = 'حدد موقعك الحالي ';
      home = 'الرئيسية';
      profile = 'حسابي';
      share = 'مشاركة';
      offers = 'أخر العروض';
      chatUs = 'خدمة العملاء';
      FAQ = 'الأسئلة شائعة';
      TermsConditions = 'الشروط والاحكام';
      Contactus = 'تواصل معنا';
      Reviewourapp = 'تقييم التطبيق';
      Logout = 'تسجيل خروج';
      otherServ = 'خدمات اخرى';
      chooseServ = 'اختر الخدمة';
      hcwHelp = 'كيف يمكننا مساعدتك اليوم ؟';
      Batteryservices = 'خدمة البطارية';
      Carlocked = 'فتح السيارة';
      Repairtire = 'خدمة الاطارات';
      Emptyfuel = 'توصيل وقود';
      Towing = 'خدمة سحب وانقاذ';
      Verification = 'تأكيد';
      t1otp =
          'من فضلك قم بإدخال كود التحقق المكوَن من 6 أرقام الذي تم إرساله إلى الجوال';
      otp = 'كود التحقق';
      resend = 'إعادة إرسال';
      t2otp = 'لم يصلك الكود؟';
      t1lc = 'مرحـباً بك';
      t2lc = 'يـرجى إدخـال رقـم الجـوال';
      regyourcar = 'سجل السيارة';
      t1rc = 'يسعدنا تسجيل بيانات سيارتك';
      t2rc = 'حتى نتمكن من المساعدة ';
      sendCode = 'إرسال كود التحقق';
      carMade = 'صنع السيارة';
      carModel = 'موديل السيارة';
      carColor = 'لون السيارة';
      rsuccessfully = 'تم اكتمال التسجيل بنجاح';
      trs1 = 'سيتم مراجعة طلبك ';
      trs2 = 'و التواصل معك لتفعيل الحساب';
      trclose = 'إغلاق';
      askHelp = 'أطلب مساعدة';
      joinasprovider = 'انضم كمزود';
      skip = 'تخطي';
      Continue = 'استمر';
      DHaveaccount = 'ليس لديك حساب ؟      ';
      Createanaccount = 'إنشاء حساب';
      UserName = " اسم المستخدم ";
      Password = " كلمة المرور ";
      Email = " البريد الإلكتروني ";
      Mobile = " رقم الهاتف ";
      Yourcarnumber = " رقم لوحة سيارة مزود الخدمة ";
      youHaveTo = " يجب عليك إدخال ";
      login = "تسجيل الدخول";
      LDiscover = "لنكتشف معاً ";
      wwhtoday = "من سنساعد اليوم";
      addCard = 'إضافة بطاقة إلكترونية';
      AcceptPrivacy = 'الموافقة على الشروط والأحكام';
      ContinueRegistration = "استكمل التسجيل";
      Ahaveanaccount = 'مسجل من قبل ؟';
      youHaveToAcceptPrivacy = "يجب عليك الموافقة على الشروط و الأحكام";
      t1r = 'يسعدنا إنضمامك معنا كـمزود';
      t2r = 'من فضلك قم بتسجيل بياناتك';
      t1r2 = 'تبقى القليل';
      t2r2 = 'وتصبح أحد مزودينا';
      tq1r2 = 'هل يوجد ورشة إصلاح ؟';
      tq2r2 = 'يرجى إضافة عنوان الورشة';
      tq3r2 = 'هل لديك رخصة مزاولة المهنة ؟';
      tq4r2 = 'ما هي نوعية العمل ؟';
      tq5r2 = 'يرجى تحديد الخدمات التي تقدمها';
      yes = 'نعم';
      no = 'لا';
      Independent = 'فردي';
      Company = 'تابع لشركة';
      Customerservices = 'خدمة العملاء';
      SignUp = 'أنشئ الحساب';
      WriteAddress = ' العنوان';
    }
    else {
      chatSupport= ' Please contact  WarshaOut Team';
      chatSupport2 = 'Provider not receive the payment , Please contact  WarshaOut Team';
      payCheck3 = 'Please wait until the provider confirm receive the payment ';
      checked = 'received';
      doesNotCheck = "Payment not receive";
      payCheck2 = 'Please confirm that you have received the agreed amount ';
      payCheck = 'Confirm Payment';
      addOneCarAtlest= 'you have to add one car at least';
      sendToUs= 'contact us to get service';
      or= 'or';
      knowMore= 'know more about us?';
      notificationSound= 'Notification sound';
      sound= 'Sound';
      chooseSound= 'Choose Sound';
      notificationSetting = 'Notification setting';
      canceled = 'canceled';
      timeout = 'missed';
      phoneUsed = 'phone number used , you can login with it';
      phoneDNotE =
          "phone number doesn't exist , you can Signup with this number";
      choosePFirst = 'choose provider first';
      privacyPolicy = 'Privacy policy';
      notification = 'Notifications';
      chooseLanguage = 'Choose language';
      r2t1 = 'You have to select on service at least to be provide';
      addCardT1 = 'Please enter your visa details';
      addCardT2 = 'Card number';
      addCardT3 = 'CVV';
      addCardT4 = 'EX.date';
      addCardT5 = 'Name';
      addCardT6 = 'Add Card';
      helpDon = 'Help Done';
      rejectDon = 'Rejected Done';
      cancelDon = 'Cancel Done';
      thanksP = 'Thank you for being one of our great providers';
      payDon = 'The amount has been transferred successfully';
      acceptedPT4 = 'Client phone number';
      acceptedPT1 = 'Following the request';
      acceptedPT2 = 'Contact Client';
      acceptedPT3 = 'Confirm order cancellation';
      acceptableT3 = 'Service Cost';
      acceptableT4 = 'Service Type';
      acceptableT5 = 'Client Location';
      acceptableT6 = 'Client car make';
      acceptableT7 = 'Client car model';
      acceptableT8 = 'Client car color';
      reject = 'Reject';
      acceptableT1 = 'Request Details';
      acceptableT2 = 'Remaining time to accept request';
      email = 'Email';
      timeSend = 'sending time';
      open = 'open';
      rejected = 'rejected';
      complete = 'complete';
      orderNumber = 'order number';
      busyT1 =
          'It seems that the service provider is busy now,  Please choose another service provider';
      busyT2 = 'Choose another provider';
      busyT3 = 'Cancel Request';
      timerT =
          'Please wait until provider is notified and confirm of your request';
      payT17 = 'Agree';
      payT1 = 'Please select service cost & payment method';
      payT2 = 'Cost of service';
      payT3 = 'same cost';
      payT4 = 'Payment amount';
      payT5 = 'Payment method';
      payT6 = 'Card';
      payT7 = 'Cash';
      payT8 = 'Proceed Payment';
      payT9 = 'Your rating is important to us';
      payT10 = 'Service`s Review';
      payT11 = 'fast';
      payT12 = 'Communication';
      payT13 = 'Easy';
      payT14 = 'Provider`s Review';
      payT15 = 'Quality';
      payT16 = 'Behavior';
      thanks = 'Thank you ';
      thanksT1 = 'We really happy to have with us';
      thanksT2 = 'Exit';
      cancelOrderT1 = 'please select the reason';
      cancelOrderT2 = 'provider is late';
      cancelOrderT3 = 'service is not good';
      cancelOrderT4 = 'wrong services';
      cancelOrderT5 = 'problem solved';
      cancelOrderT6 = 'Other';
      cancelOrderT7 = '... please write your reasons here';
      cancelOrderT8 = 'Back to request again';
      cancelOrderT9 = 'Send';
      cancelOrderT10 = 'Help us to improve our services';
      acceptedOrderT1 = 'Request accepted';
      acceptedOrderT2 = 'The provider will turn to help you immediately';
      acceptedOrderT3 = 'Track Provider';
      acceptedOrderT4 = 'Contact provider';
      acceptedOrderT5 = 'Payment is made after service provided';
      pay = 'Payment';
      cancelOrder = 'Cancel Request';
      openMap = 'Open Map';
      orderState = 'Request statue';
      acceptedOrder = 'accepted';
      completeOrdert1 =
          'The cost of the towing service set after contact with provider or The winch driver, and agreeing to Arrival location, towing distance from The starting point for the arrival point';
      completeOrdert2_1 =
          'The battery cable service cost is 3 riyals without any other side expenses';
      completeOrdert2_2 =
          'The replace battery service cost is 3 riyals without any other side expenses';
      completeOrdert3 =
          'Open locked car service cost is 8 riyals without any other side expenses';
      completeOrdert4_1 =
          '';
      completeOrdert4_2 =
          ' The fuel delivery service cost 7 riyals without Any other side expenses ,Please attention the maximum fuel supply 10 liters, which allows you to get to the nearest Petrol station';
      completeOrdert5_1 =
          'The replace tire service cost is 3 riyals without any other side expenses';

      completeOrdert5_2 =
          'The repair tire service cost is 3 riyals without any other side expenses';
      completeOrder = 'Continue Request';
      copletOrdert7 =
          'Please attention in case of another services are not required, the cost will be increased';
      copletOrdert8 = 'Please read the terms and conditions';
      copletOrdert9 =
          'Click accept to send your request, and taking with provider';
      choosept1 = ' provider`s car to help you';
      choosept1_2 = 'there are ';
      choosept2 = 'please choose the best or nearest';
      choosept3 = 'Available providers';
      choosept4 = 'min';
      choosept5 = ' - Estimated time arrival';
      locationt5 = 'You have to select your location first';
      locationt1 = "Please select your location";
      locationt2 = "Selected";
      locationt3 = "Search nearest provider";
      locationt4 = "My location";
      logOut2 = "You will  log out";
      t1Contactus = 'You can contact us';
      t2Contactus =
          'For any inquiries or clarifications, please contact customer service';
      t3Contactus = 'Our team will respond to you as soon as possible';
      t4Contactus = 'CEO of Warsha out';
      noOffers = 'There are no offer now follow us soon';
      shareLink = 'Share Link';
      accept = 'Accept';
      cancel = 'Cancel';
      deleteAccount2 = 'The account and all contents will be deleted';
      edit = 'Edit';
      show = 'Show';
      deleteAccount = 'Delete Account';
      addNewCar = 'Add New Car';
      Save = 'Save';
      Car = 'Car';
      Replacetire = 'Replace with spare tire';
      Replacetire2 = 'Replace tire';
      Repairtire2 = 'Repair tire (outage repair) ';
      Repairtire3 = 'Repair tire  ';

      tireServ = 'Tire services';
      batteryServ = 'Battery service';
      chserv = 'Please choose a service';
      batteryCable = 'Jump start';
      changeBattery = 'Replace Battery';
      location = 'Select Your Current Location';
      home = 'Home';
      profile = 'Profile';
      share = 'Share';
      offers = 'Offers';
      chatUs = 'Chat Us';
      AboutUs = 'About Us';
      FAQ = 'FAQ';
      TermsConditions = 'Terms & Conditions';
      Contactus = 'Contact Us';
      Reviewourapp = 'Review our app';
      Logout = 'Log out';
      otherServ = 'other service';
      chooseServ = 'Choose  Service';
      hcwHelp = ' ? How can we help you today';
      Batteryservices = 'Battery services';
      Carlocked = 'Car locked';
      Repairtire = 'Tire Services';
      Emptyfuel = 'Fuel delivery';
      Towing = 'Towing';
      Verification = 'Verification';
      t1otp =
          'Please enter the 6-digit verification code which was sent to the mobile';
      otp = 'OTP';
      resend = 'send again';
      t2otp = '? Didn`t receive a code';
      t1lc = 'Welcome Back ';
      t2lc = 'Please write your mobile number';
      regyourcar = 'register your car';
      t1rc = 'Happy to register your car information';
      t2rc = 'So, we can help you';
      sendCode = 'Send OTP';
      carMade = 'Car Made';
      carModel = 'Car Model';
      carColor = 'Car Color';
      rsuccessfully = 'Info registered successfully';
      trs1 = 'We will review your application, ';
      trs2 = 'and contact you to activate the account';
      trclose = 'Close';
      WriteAddress = ' Address';
      askHelp = ' Need Assistant';
      joinasprovider = 'Join as provider';
      skip = 'skip';
      Continue = 'continue';
      DHaveaccount = '? Don`t Have an account';
      Createanaccount = 'Create an account';
      UserName = "User Name";
      Password = "Password";
      youHaveTo = "you have to enter ";
      login = "Login";
      LDiscover = " Let`s Discover";
      wwhtoday = "who will help today";
      Email = "Email";
      Mobile = "Mobile";
      Yourcarnumber = "Your car number";
      addCard = 'Add Card';
      AcceptPrivacy = 'Accept terms and conditions ';
      ContinueRegistration = "Continue Registration";
      Ahaveanaccount = ' ? Already have an account';
      youHaveToAcceptPrivacy = "You Have To Accept terms and conditions ";
      t1r = 'Happy to join with us as provider';
      t2r = 'Please fill your details';
      t1r2 = 'Just little';
      t2r2 = 'and will be one of our providers';
      tq1r2 = '? Do you have a repair shop';
      tq2r2 = 'Please add your shop location';
      tq3r2 = '? Do you have a license to practice the work';
      tq4r2 = '? What is the type of work';
      tq5r2 = 'Please select services';
      yes = 'Yes';
      no = 'No';
      Independent = 'Independent';
      Company = 'Company';
      Customerservices = 'Customer services';
      SignUp = 'Sign Up';
    }
  }

/*  String? AskHelp() {
    if (language == 'AR') {
      askHelp = 'أطلب مساعدة';
    } else {
      askHelp = 'Ask Help';
    }
    return askHelp;
  }
*/
}
