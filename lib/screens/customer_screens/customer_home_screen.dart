import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/services_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/screens/customer_screens/choose_service.dart';
import 'package:onroad/screens/customer_screens/custmer_location_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../manager/background_container.dart';
import '../../models/service.dart';
import 'package:animations/animations.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({Key? key, required this.customer})
      : super(key: key);
  final Customer customer;

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen>
    with TickerProviderStateMixin {
  int newIndex = 0;
  bool shadow = false ;
  late AnimationController _animationController;

  List<String> homeSliderImages = [
    'assets/images/WhatsApp-Image-1.png',
    'assets/images/WhatsApp-Image-2.png',
    'assets/images/WhatsApp-Image-3.png',
    'assets/images/WhatsApp-Image-4.png',
    'assets/images/WhatsApp-Image-5.png',
    'assets/images/WhatsApp-Image-6.png',
    'assets/images/WhatsApp-Image-7.png',
    'assets/images/WhatsApp-Image-8.png',
  ];
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    getServices();
    // tabController = TabController(length: taps.length, vsync: this);
    super.initState();
  }

  Future<void> getServices()async{
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    ServiceCubit serviceCubit = ServiceCubit.instance(context);
    List<Services> services = await serviceCubit.getServices();
    for(int i = 0 ; i < services.length;i++){
      switch(services[i].id.toString()){
        case '1':
          if(languageCubit.language=='AR'){
            languageCubit.Batteryservices = services[i].arName;
            languageCubit.completeOrdert2_1 = services[i].arText;
          }else{
            languageCubit.Batteryservices = services[i].enName;
            languageCubit.completeOrdert2_1 = services[i].enText;
          }
          break;
        case '15':
          if(languageCubit.language=='AR'){
            languageCubit.Batteryservices = services[i].arName;
            languageCubit.completeOrdert2_2 = services[i].arText;
          }else{
            languageCubit.Batteryservices = services[i].enName;
            languageCubit.completeOrdert2_2 = services[i].enText;
          }
          break;
          case '2':
            if(languageCubit.language=='AR'){
              languageCubit.Carlocked = services[i].arName;
              languageCubit.completeOrdert3 = services[i].arText;

            }else{
              languageCubit.Carlocked = services[i].enName;
              languageCubit.completeOrdert3 = services[i].enText;

            }
          break;
          case '3':
            if(languageCubit.language=='AR'){
              languageCubit.Repairtire = services[i].arName;
              languageCubit.completeOrdert5_1 = services[i].arText;

            }else{
              languageCubit.Repairtire = services[i].enName;
              languageCubit.completeOrdert5_1 = services[i].enText;

            }
            break;
        case '16':
            if(languageCubit.language=='AR'){
              languageCubit.Repairtire = services[i].arName;
              languageCubit.completeOrdert5_2 = services[i].arText;

            }else{
              languageCubit.Repairtire = services[i].enName;
              languageCubit.completeOrdert5_2 = services[i].enText;

            }
          break;
          case '4':
            if(languageCubit.language=='AR'){
              languageCubit.Emptyfuel = services[i].arName;
              languageCubit.completeOrdert4_1 = services[i].arText;

            }else{
              languageCubit.Emptyfuel = services[i].enName;
              languageCubit.completeOrdert4_1 = services[i].enText;

            }
          break;
          case '11':
            if(languageCubit.language=='AR'){
              languageCubit.Towing = services[i].arName;
              languageCubit.completeOrdert1 = services[i].arText;

            }else{
              languageCubit.Towing = services[i].enName;
              languageCubit.completeOrdert1 = services[i].enText;

            }

          break;

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return FadeTransition(
      opacity: _animationController,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          color: kPrimaryColor.withOpacity(0.8),
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(languageCubit.chooseServ!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              // color: kPrimaryColor,
                            )),
                      ],
                    ),
                  ),
                               /*onTap: () {
                               /*     if(widget.customer.isActive){
                                      if (widget.customer.cars!.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 5),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            padding: const EdgeInsets.all(10),
                                            content: Text(
                                              languageCubit.addOneCarAtlest!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.cairo(),
                                            )));
                                      } else {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return CustomerLocationScreen(
                                                  serviceType: 1);
                                            }));
                                      }
                                    }else{
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          padding: const EdgeInsets.all(10),
                                          content: Text(
                                            languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cairo(),
                                          )));
                                    }*/
                                  },*/
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 16, left: 16, right: 16),
                      child: SizedBox(
                        width: size.width * 0.85,
                        height: size.height * 0.265,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          /* gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  childAspectRatio: 1.2),*/
                          controller: ScrollController(keepScrollOffset: false),
                          crossAxisCount: 3,
                          childAspectRatio: 0.9,
                          mainAxisSpacing: 0,
                          children: [

                            GestureDetector(

                              onTap: () {
                                if(widget.customer.isActive){
                                  if (widget.customer.cars!.length == 0) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 5),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            padding: const EdgeInsets.all(10),
                                            content: Text(
                                              languageCubit.addOneCarAtlest!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.cairo(),
                                            )));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CustomerLocationScreen(
                                          serviceType: 1);
                                    }));
                                  }
                                }else{
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 5),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                      padding: const EdgeInsets.all(10),
                                      content: Text(
                                        languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.cairo(),
                                      )));
                                }
                              },
                              child: Column(
                                children: [
                                  /*Container(
                                    width: 70,
                                    height: 70,

                                    decoration:BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(35)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/asset-1.png",
                                            )
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                          offset: Offset(1,1),
                                          color: kPrimaryColor.withOpacity(0.4),
                                          blurRadius: 5
                                        )
                                      ]
                                    ),

                                  ),*/
                                  Image.asset(
                                    "assets/images/asset-1.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Center(
                                      child: Text(languageCubit.Towing!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            // color: kPrimaryColor,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                    if(widget.customer.isActive){
                                  if (widget.customer.cars!.length == 0) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 5),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            padding: const EdgeInsets.all(10),
                                            content: Text(
                                              languageCubit.addOneCarAtlest!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.cairo(),
                                            )));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ChooseService(
                                        battery: false,
                                      );
                                    }));
                                  }
                                }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                padding: const EdgeInsets.all(10),
                                content: Text(
                                languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(),
                                )));
                                }
                              },
                              child: Column(
                                children: [

                                 /* Container(
                                    width: 70,
                                    height: 70,

                                    decoration:BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(35)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/Repeat Grid -2.png",
                                            )
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(1,1),
                                              color: kPrimaryColor.withOpacity(0.4),
                                              blurRadius: 5
                                          )
                                        ]
                                    ),

                                  ),*/

                                  Image.asset(
                                    "assets/images/Repeat Grid -2.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(languageCubit.Repairtire!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // color: kPrimaryColor,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(widget.customer.isActive){
                                  if (widget.customer.cars!.length == 0) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            duration: Duration(seconds: 5),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            padding: const EdgeInsets.all(10),
                                            content: Text(
                                              languageCubit.addOneCarAtlest!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.cairo(),
                                            )));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CustomerLocationScreen(
                                          serviceType: 3);
                                    }));
                                  }
                                }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                padding: const EdgeInsets.all(10),
                                content: Text(
                                languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(),
                                )));
                                }
                              },
                              child: Column(
                                children: [

                                  Image.asset(
                                    "assets/images/Repeat Grid -1.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(languageCubit.Carlocked!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // color: kPrimaryColor,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(widget.customer.isActive){
                                  if (widget.customer.cars!.length == 0) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        padding: const EdgeInsets.all(10),
                                        content: Text(
                                          languageCubit.addOneCarAtlest!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.cairo(),
                                        )));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return CustomerLocationScreen(
                                              serviceType: 4);
                                        }));
                                  }
                                }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                padding: const EdgeInsets.all(10),
                                content: Text(
                                languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(),
                                )));
                                }
                              },

                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/4.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Text(languageCubit.Emptyfuel!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        // color: kPrimaryColor,
                                      ))
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(widget.customer.isActive){
                                  if (widget.customer.cars!.length == 0) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        duration: Duration(seconds: 5),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        padding: const EdgeInsets.all(10),
                                        content: Text(
                                          languageCubit.addOneCarAtlest!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.cairo(),
                                        )));
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return ChooseService(
                                            battery: true,
                                          );
                                        }));
                                  }
                                }else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                padding: const EdgeInsets.all(10),
                                content: Text(
                                languageCubit.language=='AR'?'نأسف ، لكن حسابك غير مفعل':'Sorry,your account does not active',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(),
                                )));
                                }
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/Repeat Grid 10.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  Center(
                                    child: Text(languageCubit.Batteryservices!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          // color: kPrimaryColor,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/asset-2.png",
                                  height: 70,
                                  width: 70,
                                ),
                                Text(languageCubit.otherServ!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            /**/
            Column(
              children: [
/*
                  SizedBox(height: size.height*0.1),
*/
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, left: 16, bottom: 16, top: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            languageCubit.t1lc! +
                                " " +
                                widget.customer.userName,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(languageCubit.hcwHelp!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
                CarouselSlider.builder(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      aspectRatio: 10,
                      enlargeCenterPage: true,
                      height: size.height * 0.285,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          newIndex = index;
                        });
                      },
                      autoPlayAnimationDuration: const Duration(seconds: 2)),
                  itemCount: homeSliderImages.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Container(
                      height: size.height * 0.3,
                      width: size.width * 0.95,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(homeSliderImages[index]),
                              fit: BoxFit.fill,
                              alignment: Alignment.centerLeft),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor.withOpacity(0),
                                offset: const Offset(0,0),
                                blurRadius: 5)
                          ]),
                      /*  child: Image.asset(
                     "assets/images/homeimg1.jpg",
                     height: 200,
                     width: 380,
                     fit: BoxFit.fill,
                   ),*/
                    );
                  },
                ),
                SizedBox(height: size.height * 0.01),
                AnimatedSmoothIndicator(
                  activeIndex: newIndex,
                  count: 8,
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
