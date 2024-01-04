import 'package:flutter/material.dart';
import '../StateManagement/blocs/aboutas_cubit.dart';
import '../StateManagement/blocs/aboutas_state.dart';
import '../StateManagement/blocs/language_cubit.dart';
import '../models/privacy_and_policy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivicyPolicyScreen extends StatefulWidget {
  const PrivicyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivicyPolicyScreen> createState() => _PrivicyPolicyScreenState();
}

class _PrivicyPolicyScreenState extends State<PrivicyPolicyScreen> {
  String ar = "";


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    SettingCubit settingCubit = SettingCubit.instance(context);
    //settingCubit.getPrivacyAndPolice();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          languageCubit.privacyPolicy!,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          textAlign: TextAlign.end,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                languageCubit.language == 'AR'? 'خصوصيتك مهمة بالنسبة لنا. فيما يتعلق بأي معلومات قد نجمعها منك عبر تطبيق ورشه اوت  والخدمات المرتبطة به.' : 'Your privacy is important to us. Regarding any information we may collect from you via our WarshaOut app, , and its associated services.',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? " ١ -  معلومات التعريف الشخصية تقوم ورشه اوت بجمع معلومات التعريف الشخصية من المستخدمين بطرق مختلفة ، بما في ذلك على سبيل المثال لا الحصر الأوقات التي يزور فيها المستخدم التطبيق ، والتسجيل في تطبيق ورشوت ، وملء الطلب ، ونموذج تحليل الاستبيان ، والأنشطة أو الخدمات أو الميزات أو الموارد الأخرى التي قد نقدمها على تطبيقنا . قد يطلب من المستخدمين توضيح الاسم الكامل وبيانات السيارة مثل طراز السيارة والعلامة التجارية واللون ورقم الهاتف وبيانات بطاقة الائتمان في حالة الدفع الإلكتروني من قبل المستخدم أو في حالة مقدم استرداد الحقوق المالية الناتجة عن خدماته." : '1. Personal identification information : WarshaOut collects personal identification information from users in various ways, including but not limited to the times the user visits the application, registration in the WarshaOut application, filling out the application, the questionnaire analysis form, and other activities, services, features or resources that we may provide on our application . Users may be asked to clarify the full name, vehicle data such as the car model, brand and color, phone number, and credit card data in the case of electronic payment by the user or in the case of the provider of recovering financial rights resulting from his services.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? "٢ -معلومات غير شخصيةتقوم ورشه اوت بجمع بعض المعلومات عن المستخدمين أينما تفاعلوا مع التطبيق ، وهذه المعلومات لا تتعلق بالهوية الشخصية ، بل قد تشمل نوع الهاتف الذكي والمعلومات الفنية حول طرق اتصال المستخدم مع التطبيق ، مثل الشركة المستخدمة في تقديم خدمة الإنترنت وغيرها من المعلومات المماثلة." : "2. Non-personally identifiable information : WarshaOut collects some information about users wherever they interact with the application, and this information is not related to personal identity, but may include the type of smartphone and technical information about the user's communication methods with the application, such as the company used to provide Internet service and other similar information.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? "٣ - كيف نستخدم المعلومات التي تم جمعها تقوم ورشه اوت بجمع واستخدام المعلومات الشخصية للمستخدمين للأغراض التالية: يجمع ورشة اوت بيانات الموقع الجغرافي لتفعيل ميزة تتبع المزود حتى اذا كان التطبيق مغلقا او لم يكن قيد الاستخدام يتم جمع المواقع الجغرافية للمستخدمين لتوفير مواقع مقدمي الخدمات للعملاء البحث أو تتبع الغرض في التطبيق والمستخدمين لديه القدرة على إيقاف / تسجيل الخروج حساب المستخدم له في التطبيق وبالتالي فإنه لن يظهر في خريطة التطبيق. تحسين جودة خدمة العملاء. تساعدنا معلوماتك على الاستجابة بسهولة أكبر لطلبات خدمة العملاء واحتياجات الدعم بشكل أكثر فعالية. لتحسين التطبيق. نحن نسعى باستمرار لتحسين العروض المقدمة من خلال التطبيق أو موقعنا الإلكتروني وفقا للمعلومات والتعليقات التي نتلقاها منك. إرسال الرسائل القصيرة على أساس منتظم لن يتم استخدام رقم الهاتف الذي يسجله المستخدمون لمعالجة طلباتهم إلا لإرسال المعلومات والتحديثات المتعلقة بطلبهم. يمكن استخدامه أيضا للرد على الاستفسارات أو الطلبات أو الأسئلة الأخرى. إذا قرر المستخدم الانضمام إلى قائمتنا البريدية ، فسوف يتلقى رسائل على بريده الإلكتروني او هاتفه قد تتضمن أخبار ورشاوت وآخر التحديثات والمعلومات المتعلقة بالتطبيق. بالإضافة إلى ذلك ، إذا أراد المستخدم في أي وقت إلغاء تسجيل تلقي أي رسائل مستقبلية ، فإننا نقدم له تعليمات مفصلة حول إلغاء التسجيل في نهاية كل رسالة على رقم هاتفه المحمول ، أو يمكن للمستخدم الاتصال بنا من  " : "3.  How we use the information collected : WarshaOut collects and uses users' personal information for the following purposes: *Warshot collects geolocation data to activate the provider tracking feature even if the application is closed or not in use. *Geographic Locations for users are Collected to Provide providers locations for customer searching or tracking  Purpose in the App however the users has ability to turn off /Log out his user account in App hence it wont shown in App map. * Improving the quality of customer service.Your information helps us to more easily respond to your customer service requests and support needs more effectively. * To improve the application.We constantly strive to improve the offers offered through the application or our website in accordance with the information and feedback we receive from you. * Send SMS on a regular basisThe phone number users register to process their order will only be used to send them information and updates related to their order. It may also be used to respond to inquiries, other requests or questions. If the user decides to join our mailing list, he will receive messages on his email that may include WarshaOut news, latest updates, and information regarding the application. In addition, if at any time the user wants to cancel the registration of receiving any future messages, we provide him with detailed instructions about canceling the registration at the end of each message on his mobile number, or the user can contact us through the application.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? "٤ - كيف نحمي معلوماتك نحن نتبع الإجراءات المناسبة ومعايير الأمان في جمع البيانات وحفظها ومعالجتها ، من أجل حماية تلك البيانات من التعامل غير المصرح به أو التعديل أو الكشف أو إتلاف بياناتك الشخصية واسم المستخدم وكلمة المرور ومعلومات حول معاملاتك والبيانات المخزنة على تطبيقنا. يتم تبادل البيانات الحساسة والخاصة بين ورشوت ومستخدميها من خلال قنوات اتصال آمنة ويتم تشفيرها وحمايتها من خلال طرق وأساليب رقمية معتمدة. " : "4. How we protect your information :  We follow proper procedures and security standards in collecting, preserving and handling data, in order to protect that data against unauthorized handling, modification, disclosure or destruction of your personal data, user name, password, information about your transactions and data stored on our application. Sensitive and private data is exchanged between WarshaOut and its users through secure communication channels and is encrypted and protected through approved digital methods and methods.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? '٥ - كيف نحمي معلوماتك نحن نتبع الإجراءات المناسبة ومعايير الأمان في جمع البيانات وحفظها ومعالجتها ، من أجل حماية تلك البيانات من التعامل غير المصرح به أو التعديل أو الكشف أو إتلاف بياناتك الشخصية واسم المستخدم وكلمة المرور ومعلومات حول معاملاتك والبيانات المخزنة على تطبيقنا. يتم تبادل البيانات الحساسة والخاصة بين ورشوت ومستخدميها من خلال قنوات اتصال آمنة ويتم تشفيرها وحمايتها من خلال طرق وأساليب رقمية معتمدة.' : "5. Sharing personal data : We do not sell, trade, or rent users' personal identification data to third parties, and we may share aggregated general demographic information that is not linked to any personal identification information of users, affiliates and advertisers for the purposes described above. We may use a third party service provider to help us operate our business and operate the Application or to administer activities on our behalf, such as sending out newsletters or surveys. We may share your data with this third party within the limits of those specific purposes if you have given us permission to do so.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? "٦ -  مواقع الطرف الثالثقد يجد المستخدمون إعلانات أو محتوى آخر على تطبيقنا يحتوي على روابط لمواقع الويب والخدمات الخاصة بشركائنا أو موردينا أو المعلنين أو الرعاة أو المرخصين أو كيانات الطرف الثالث الأخرى. يجب ملاحظة أننا لا نتحكم في المحتوى أو الروابط التي تظهر على تلك المواقع ولسنا مسؤولين عن ممارسات المواقع المرتبطة بموقعنا. بالإضافة إلى ذلك ، قد تتغير هذه المواقع أو الخدمات ، بما في ذلك محتواها وروابطها ، باستمرار. سيكون لهذه المواقع والخدمات سياسات الخصوصية وسياسات خدمة العملاء الخاصة بها. يخضع التصفح والتفاعل على أي موقع ويب آخر ، بما في ذلك مواقع الويب التي ترتبط بتطبيقنا ، للشروط والسياسات الخاصة بهذه المواقع." : "6. Third Party Websites : Users may find advertisements or other content on our App that contain links to the websites and services of our partners, suppliers, advertisers, sponsors, licensors, or other third party entities. You should note that we do not control the content or links that appear on those sites and are not responsible for the practices of sites linked to our site. In addition, those websites or services, including their content and links, may change constantly. These sites and services will have their own privacy policies and customer service policies. Browsing and interaction on any other website, including websites that link to our app, is subject to those websites' own terms and policies.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? '٧ - الموافقة على شروط الاستخدامباستخدام هذا التطبيق ، فإنك توافق على سياسة الخصوصية والشروط والأحكام التي تحكم استخدام هذا التطبيق. إذا كنت لا توافق على هذه السياسة ، يجب عدم استخدام التطبيق لدينا. أنت تقر بأن استخدامك المستمر للتطبيق بعد الإعلان عن التغييرات على هذه السياسة أو على شروط وأحكام استخدام التطبيق سيعتبر موافقتك على هذه التغييرات.' : '7. Agree to the terms of use : By using this application, you agree to our privacy policy and the terms and conditions that govern the use of this application. If you do not agree to this policy, you must not use our application. You acknowledge that your continued use of the Application after the announcement of changes to this policy or to the terms and conditions of use of the Application will be deemed your acceptance of such changes.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? " ٨ - الكوكيز تغطي سياسة الخصوصية الخاصة بنا استخدام ملفات تعريف الارتباط بين جهازك وخوادمنا. ملف تعريف الارتباط هو جزء صغير من البيانات التي قد يخزنها التطبيق على جهازك ، وعادة ما يحتوي على معرف فريد يسمح لخوادم التطبيق بالتعرف على جهازك عند استخدام التطبيق ؛ معلومات حول حسابك و/أو جلستك و / أو جهازك ؛ بيانات إضافية تخدم الغرض من ملف تعريف الارتباط ، وأي معلومات صيانة ذاتية حول ملف تعريف الارتباط نفسه.نحن نستخدم ملفات تعريف الارتباط لمنح جهازك إمكانية الوصول إلى الميزات الأساسية لتطبيقنا ، لتتبع استخدام التطبيق وأدائه على جهازك ، ولتكييف تجربتك مع تطبيقنا بناء على تفضيلاتك ، ولعرض الإعلانات على جهازك. أي اتصال بيانات ملفات تعريف الارتباط بين جهازك وخوادمنا يحدث في بيئة آمنة" : "8. Cookies : Our Privacy Policy covers the use of cookies between your device and our servers. A cookie is a small piece of data that an app may store on your device, and it typically contains a unique identifier that allows the app's servers to recognize your device when you use the app; information about your account, session, and/or device; Additional data that serves the purpose of the cookie, and any self-maintenance information about the cookie itself. We use cookies to give your device access to essential features of our app, to track app usage and performance on your device, to tailor your experience to our app based on your preferences, and to serve ads on your device. Any cookie data communication between your device and our servers takes place in a secure environment",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  languageCubit.language == 'AR'? '٩ -  استخدام تتبع التحويل في ورشه اوت ، يتم تتبع تصفح المستخدمين للموقع لتحسين الأداء وتطويره ، مع العلم أن هوية المستخدم أو مكان وجوده لا يتم مراقبته أو كشفه.' : "9.Use of conversion tracking : In WarshaOut, users' browsing of the site is tracked to improve performance and develop it, knowing that the user's identity or whereabouts are not monitored or exposed.",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: languageCubit.language == 'AR'?TextAlign.end:TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
