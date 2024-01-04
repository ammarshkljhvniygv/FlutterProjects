import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_animation/onboarding_animation.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/screens/lang_screen.dart';
import 'package:onroad/widget/page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  CarouselController controller = CarouselController();
  bool scrollAble = true;
  double pageNum = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    pageController.addListener(() {
      setState(() {
        pageNum = pageController.page!;
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          pageNum > 1.6
              ? GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChooseScreen();
                    }));
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        color: kPrimaryColor,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              languageCubit.Continue!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                )
              : Container(),
          Container(
            padding: pageNum > 1.6
                ? const EdgeInsets.only(bottom: 75)
                : const EdgeInsets.only(bottom: 0),
            child: Stack(
              children: [
                OnBoardingAnimation(
                  controller: pageController,
                  pages: [
                    BuildPage(
                      skip: true,
                      size: size,
                      img: 'assets/images/Group 107.png',
                      text1:languageCubit.language=='AR'? 'سيارتك بنشرت ..؟ ':'You have flat tire ?',
                      text2:
                      languageCubit.language=='AR'?
                      '،سهلناها عليك، تقدر تطلب الخدمة وتتبع المزود الأقرب لك، ويوصلك فين ما تكون':
                      'You can order the Service easily , nearest provider will reach you.',
                    ),
                    BuildPage(
                      skip: true,
                      size: size,
                      img: 'assets/images/Group 108.png',
                      text1:languageCubit.language=='AR'?'خلص البنزين ..؟':'Run out of petrol ...?',
                      text2:
                      languageCubit.language=='AR'?
                      'ادخل بيانات السيارة، ثم اختر الخدمة  المطلوبة، وتواصل مع المزود الأقرب':
                      'Just enter your car details and select your service,Nearest provider will reach you.',
                    ),
                    BuildPage(
                      skip: false,
                      size: size,
                      img: 'assets/images/Illustration.png',
                      text1: languageCubit.language=='AR'?'محتاج ونش ..؟':'Need towing ,, !',
                      text2:
                      languageCubit.language=='AR'?
                      '"ورشة أوت" بتوفرلك الوِنش، في مكان تواجدك بأسرع وقت، معانا لا تشيل هم السيارة':
                      'Warshaout will help you to get the towing service easily.Nearest towing vehicle will reach you.',
                    ),
                  ],
                  indicatorDotHeight: 0.0,
                  indicatorDotWidth: 0.0,
                  indicatorType: IndicatorType.expandingDots,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height * 0.075,
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                        ),
                        SizedBox(
                          height: size.height * 0.0,
                        ),
                      ],
                    ),
                  ),
                )
                /* PageView(
              onPageChanged: (page) {
                setState(() {
                  pageNum = page;
                });
                */ /* if(page==3){
                 */ /* */ /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return ChooseScreen();
                  }));*/ /* */ /*
                  // pageController.keepPage = true;
                  setState((){
                    scrollAble = false ;
                  });
                }*/ /*
              },
              physics: scrollAble
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                BuildPage(
                  skip: true,
                  size: size,
                  img: 'assets/images/Group 107.png',
                  text1: 'سيارتك بنشرت ..؟ ',
                  text2:
                      '،سهلناها عليك، تقدر تطلب الخدمة وتتبع المزود الأقرب لك، ويوصلك فين ما تكون',
                ),
                BuildPage(
                  skip: true,
                  size: size,
                  img: 'assets/images/Group 108.png',
                  text1: 'خلص البنزين ..؟',
                  text2:
                      'ادخل بيانات السيارة، ثم اختر الخدمة  المطلوبة، وتواصل مع المزود الأقرب',
                ),
                BuildPage(
                  skip: false,
                  size: size,
                  img: 'assets/images/Illustration.png',
                  text1: 'محتاج ونش ..؟',
                  text2:
                      '"ورشة أوت" بتوفرلك الوِنش، في مكان تواجدك بأسرع وقت، معانا لا تشيل هم السيارة',
                ),
              ],
            ),
            scrollAble
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: size.height * 0.12,
                      child: Column(
                        children: [
                          SmoothPageIndicator(
                            controller: pageController,
                            count: 3,
                          ),
                          SizedBox(
                            height: size.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            pageNum == 2
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: size.height * 0.145,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ChooseScreen();
                                      }));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Text(
                                            'استمر',
                                            style:
                                                GoogleFonts.cairo(fontSize: 20),
                                          ),
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.09,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
