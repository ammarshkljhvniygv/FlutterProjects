import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/widget/mydirection.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../StateManagement/blocs/aboutas_cubit.dart';

class ConnectUsScreen extends StatefulWidget {
  const ConnectUsScreen({Key? key}) : super(key: key);

  @override
  State<ConnectUsScreen> createState() => _ConnectUsScreenState();
}

class _ConnectUsScreenState extends State<ConnectUsScreen> {
bool done = false ;
  @override
  void initState() {
    getOthers();
    // TODO: implement initState
    super.initState();
  }
List<String> links = [];
  Future<void> getOthers()async{
    SettingCubit settingCubit = SettingCubit.instance(context);
    links = await settingCubit.getOthers();
    setState(() {
      done = true ;
    });
  }
Future<void> launchingWhatsApp(String number) async {
  String url = "whatsapp://send?phone=+$number";
  await launchUrlString(url);
}
Future<void> launching(String link) async {
//  String url = "whatsapp://send?phone=+$number";
  await launchUrlString(
    link,
      mode: LaunchMode.externalApplication
  );

}
  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    return MyDirectionality(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            languageCubit.Contactus!,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body:done? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Image.asset('assets/images/Group 338.png'),
              Text(
                languageCubit.t1Contactus!,
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                languageCubit.t2Contactus!,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              /*Text(
                'Support@Warshaout.com  ',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),*/
              Text(
                languageCubit.t3Contactus!,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              /*Text(
                languageCubit.t4Contactus!,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),*/
        /*      Text(
               languageCubit.language=='AR'? 'م / محمد شحاته':'Eng.Mohamed Shehata',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),*/
            /*  Text(
                'Moshehata@Warshaout.com',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),*/
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    GestureDetector(
                      onTap: ()async{
                        await  launching(links[1]);
                      },
                      child: Icon(Icons.facebook,
                        size: 65,
                        color: Colors.indigo,),
                    ),
                   /* Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: ()async{
                        await  launching(links[2]);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width:60,
                              height:60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue,
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 0,
                              child: Text('e',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontSize: 40),),
                            ),
                          ],
                        )
                      ),
                    ),*/
                      GestureDetector(
                        onTap: ()async{
                          await  launching(links[6]);
                        },
                        child: Image.asset(
                        'assets/images/png-clipart-icon-logo-twitter-logo-twitter-logo-blue-social-media-thumbnail-removebg-preview.png',
                        width: 68,
                    ),
                      ),
                    GestureDetector(
                      onTap: ()async{
                       await launchingWhatsApp(links[0]);
                      },
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green),
                        child: Icon(
                          Icons.facebook,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    /*  Image.asset(
                      'assets/images/145807-removebg-preview.png',
                      width: 55,
                    ),*/
                  ],
                ),
              ),
              TextButton(
                onPressed: (){
                  launching('https://www.warshaout.com');

                },
                child: Text(
                  'www.warshaout.com',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ), )
            ],
          ),
        ):Center(child: CircularProgressIndicator(color: kPrimaryColor,),),
      ),
    );
  }
}
