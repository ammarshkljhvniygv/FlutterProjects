import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onroad/StateManagement/blocs/car_cubit.dart';
import 'package:onroad/StateManagement/blocs/car_state.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/update_profile_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/models/car.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/screens/add_card_screen.dart';
import 'package:onroad/screens/provider_screens/provider_profil_screen.dart';
import 'package:onroad/widget/edit_form.dart';
import 'package:onroad/widget/field.dart';
import 'package:onroad/widget/field2.dart';
import 'package:onroad/widget/show_form.dart';
import 'package:pinput/pinput.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key? key, required this.customer})
      : super(key: key);
  final Customer customer;

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  int? carNumber;
  int? pagenumber;
  String? lang = 'عربي';
  String? paymentWay = 'master card';
  bool? edit = false;
  bool filter = false;
  bool openFilter = false;
  bool model = false;
  String? makeId;
  List<dynamic>? filterModels;
  List<dynamic>? models;
  bool addCard = false;
  String? countryNumber;
  bool phone = false;
  String? make = '';
  String? modelCar = '';
  final TextEditingController makeController1 = TextEditingController();
  final TextEditingController modelController1 = TextEditingController();
  final TextEditingController colorController1 = TextEditingController();
  final TextEditingController makeController2 = TextEditingController();
  final TextEditingController modelController2 = TextEditingController();
  final TextEditingController colorController2 = TextEditingController();
  final TextEditingController makeController3 = TextEditingController();
  final TextEditingController modelController3 = TextEditingController();
  final TextEditingController colorController3 = TextEditingController();
  final TextEditingController makeController4 = TextEditingController();
  final TextEditingController modelController4 = TextEditingController();
  final TextEditingController colorController4 = TextEditingController();
  final TextEditingController _textEditingController4 = TextEditingController();
  final TextEditingController _textEditingController5 = TextEditingController();
  late TabController tabController;
  late PageController pageController = PageController();

  List<Widget> forms = [];
  List<Widget> taps = [];
  late AnimationController _animationController;
  @override
  void initState() {
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    carNumber = widget.customer.cars!.length;
    pagenumber = widget.customer.cars!.length;
    if (pagenumber! > 0) {
      taps.add(Text(
        languageCubit.language=='AR'? 'سيارة 1':'Car 1',
        style: const TextStyle(color: kPrimaryColor),
      ));
    }
    if (pagenumber! > 1) {
      taps.add(Text(
        languageCubit.language=='AR'? 'سيارة2':'Car 2',
        style: const TextStyle(color: kPrimaryColor),
      ));
    }
    if (pagenumber! > 2) {
      taps.add(Text(
        languageCubit.language=='AR'? 'سيارة 3':'Car 3',
        style: const TextStyle(color: kPrimaryColor),
      ));
    }
    if (pagenumber! > 3) {
      taps.add(Text(
        languageCubit.language=='AR'? 'سيارة 4':'Car 4',
        style: const TextStyle(color: kPrimaryColor),
      ));
    }

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    _textEditingController5.setText(widget.customer.userName);
    _textEditingController4
        .setText(widget.customer.phoneNumber.toString().substring(3));
    countryNumber = widget.customer.phoneNumber;
    // tabController = TabController(length: taps.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    LanguageCubit languageCubit = LanguageCubit.instance(context);
    UpdateProfileCubit updateProfileCubit =
        UpdateProfileCubit.instance(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (edit!) {
                          edit = false;
                        } else {
                          edit = true;
                        }
                      });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(7)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Center(
                          child: Text(
                              edit! ? languageCubit.show! : languageCubit.edit!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              )),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Theme(
                              data: ThemeData(
                                dialogTheme: const DialogTheme(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(20))),
                                ),
                              ),
                              child: AlertDialog(
                                content: SizedBox(
                                  width: 350,
                                  height: 150,
                                  child: Column(
                                    children: [
                                      Text(languageCubit.deleteAccount2!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          )),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: size.width * 0.3,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(7)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Center(
                                                  child: Text(
                                                      languageCubit.cancel!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              UpdateProfileCubit
                                                  updateProfileCubit =
                                                  UpdateProfileCubit.instance(
                                                      context);
                                              LoginCubit loginCubit =
                                                  LoginCubit.instance(context);
                                              if (await updateProfileCubit
                                                  .updateCustomerAccountState(widget
                                                      .customer.id
                                                      .toString(),false)) {
                                                await CacheManager
                                                        .getInstance()!
                                                    .logout();
                                                loginCubit.logout();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Container(
                                              width: size.width * 0.3,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: kPrimaryColor),
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    const Radius.circular(7)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Center(
                                                  child: Text(
                                                      languageCubit.accept!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kPrimaryColor,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor2),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(7)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Center(
                          child: Text(languageCubit.deleteAccount!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor2,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Material(
                elevation: 4,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: size.width * 0.8,
                  // height: size.height * 0.57,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        edit!
                            ? Field(
                                obscureText: false,
                                text: languageCubit.UserName!,
                                validatText: languageCubit.youHaveTo! +
                                    languageCubit.UserName!,
                                readOnly: false,
                                suffixIcon: Container(
                                  width: 0,
                                  height: 0,
                                ),
                                controller: _textEditingController5,
                                maxWidth: 49,
                              )
                            : ProfileItem(
                                text: languageCubit.UserName!,
                                val: widget.customer.userName,
                                dropdown: false,
                                icon: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                       /* edit!
                            ? Directionality(
                                textDirection: languageCubit.language == 'AR'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: IntlPhoneField2(
                                  phone: phone,
                                  cursorHeight: 25,
                                  cursorColor: kPrimaryColor,
                                  controller: _textEditingController4,
                                  validator: (text) {
                                    if (text == null || text == "") {
                                      return languageCubit.youHaveTo! +
                                          languageCubit.Mobile!;
                                    }
                                    return null;
                                  },
                                  disableLengthCheck: true,
                                  textAlign: languageCubit.language == 'AR'
                                      ? TextAlign.right
                                      : TextAlign.left,
                                  style: const TextStyle(height: 0.9),
                                  decoration: InputDecoration(
                                      // labelStyle: const TextStyle(height: 10,),

                                      hintStyle: const TextStyle(
                                          color: kPrimaryColor2),
                                      label: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0, bottom: 12, right: 12),
                                        child: Text(languageCubit.Mobile!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 191, 191, 191),
                                            )),
                                      )),
                                  initialValue:
                                      "+${widget.customer.phoneNumber.toString().substring(0, 3)}",
                                  onChanged: (phone) {
                                    print(phone.completeNumber);
                                    setState(() {
                                      countryNumber = phone.completeNumber;
                                    });
                                  },
                                  onCountryChanged: (country) {
                                    print(
                                        'Country changed to: ${country.name}');
                                  },
                                ),
                              )
                            :*/ ProfileItem(
                                text: languageCubit.Mobile!,
                                val: "+" +
                                    widget.customer.phoneNumber
                                        .toString()
                                        .substring(0, 3) +
                                    '-' +
                                    widget.customer.phoneNumber
                                        .toString()
                                        .substring(3),
                                dropdown: false,
                                icon: Row(
                                  children: [
                                    /*  const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                      size: 30,
                                    ),*/
                                    /* Image.asset(
                                      'packages/intl_phone_field/assets/flags/kw.png',
                                      width: 30,
                                    )*/
                                  ],
                                )),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Material(
                elevation: 4,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: size.width * 0.8,
                  // height: size.height * 0.57,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (pagenumber! < 4) {
                                pagenumber = pagenumber! + 1;
                                taps.add(Text(
                                  '${languageCubit.Car!} ${taps.length + 1}',
                                  style: const TextStyle(color: kPrimaryColor),
                                ));

                                pageController.animateToPage(taps.length - 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear);

                                print(
                                    '---------------------------------------------');

                                print(tabController.length);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        margin: EdgeInsets.all(10),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'لا يمكنك إضافة اكثر من أربع سيارات',
                                          textAlign: TextAlign.center,
                                        )));
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(languageCubit.addNewCar!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    )),
                                const Icon(
                                  Icons.add,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 235,
                            child: PageView(
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: [
                                carNumber! > 0
                                    ? ShowForm(
                                        customer: widget.customer,
                                        carNumber: 0,
                                      )
                                    : pagenumber! > 0
                                        ? EditForm(
                                            textEditingController1:
                                                makeController1,
                                            textEditingController2:
                                                modelController1,
                                            textEditingController3:
                                                colorController1,
                                            onTap1: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit.getCarMakes();
                                              setState(() {
                                                filter = false;
                                                model = false;
                                                openFilter = true;
                                              });
                                            },
                                            onTap2: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit
                                                  .getCarModelsByCarMake(
                                                      makeId!);
                                              setState(() {
                                                filter = false;
                                                model = true;
                                                openFilter = true;
                                              });
                                            },
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                carNumber! > 1
                                    ? ShowForm(
                                        customer: widget.customer,
                                        carNumber: 1,
                                      )
                                    : pagenumber! > 1
                                        ? EditForm(
                                            textEditingController1:
                                                makeController2,
                                            textEditingController2:
                                                modelController2,
                                            textEditingController3:
                                                colorController2,
                                            onTap1: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit.getCarMakes();
                                              setState(() {
                                                filter = false;
                                                model = false;
                                                openFilter = true;
                                              });
                                            },
                                            onTap2: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit
                                                  .getCarModelsByCarMake(
                                                      makeId!);
                                              setState(() {
                                                filter = false;
                                                model = true;
                                                openFilter = true;
                                              });
                                            },
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                carNumber! > 2
                                    ? ShowForm(
                                        customer: widget.customer,
                                        carNumber: 2,
                                      )
                                    : pagenumber! > 2
                                        ? EditForm(
                                            textEditingController1:
                                                makeController3,
                                            textEditingController2:
                                                modelController3,
                                            textEditingController3:
                                                colorController3,
                                            onTap1: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit.getCarMakes();
                                              setState(() {
                                                filter = false;
                                                model = false;
                                                openFilter = true;
                                              });
                                            },
                                            onTap2: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit
                                                  .getCarModelsByCarMake(
                                                      makeId!);
                                              setState(() {
                                                filter = false;
                                                model = true;
                                                openFilter = true;
                                              });
                                            },
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                carNumber! > 3
                                    ? ShowForm(
                                        customer: widget.customer,
                                        carNumber: 3,
                                      )
                                    : pagenumber! > 3
                                        ? EditForm(
                                            textEditingController1:
                                                makeController4,
                                            textEditingController2:
                                                modelController4,
                                            textEditingController3:
                                                colorController4,
                                            onTap1: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit.getCarMakes();
                                              setState(() {
                                                filter = false;
                                                model = false;
                                                openFilter = true;
                                              });
                                            },
                                            onTap2: () {
                                              CarDataCubit carDataCubit =
                                                  CarDataCubit.instance(
                                                      context);
                                              carDataCubit
                                                  .getCarModelsByCarMake(
                                                      makeId!);
                                              setState(() {
                                                filter = false;
                                                model = true;
                                                openFilter = true;
                                              });
                                            },
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TabBar(
                            indicatorColor: kPrimaryColor,
                            tabs: taps,
                            controller: tabController = TabController(
                                initialIndex: currentIndex,
                                length: taps.length,
                                vsync: this),
                            onTap: (index) {
                              pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.linear);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  List<Car> cars = [];
                  if (colorController1.text != '' &&
                      makeController1.text != '' &&
                      modelController1.text != '') {
                    cars.add(Car(
                      carColor: colorController1.text,
                      carModel: modelController1.text,
                      carMake: makeController1.text,
                      id: '1',
                    ));
                  }
                  if (colorController2.text != '' &&
                      makeController2.text != '' &&
                      modelController2.text != '') {
                    cars.add(Car(
                      carColor: colorController2.text,
                      carModel: modelController2.text,
                      carMake: makeController2.text,
                      id: '2',
                    ));
                  }
                  if (colorController3.text != '' &&
                      makeController3.text != '' &&
                      modelController3.text != '') {
                    cars.add(Car(
                      carColor: colorController3.text,
                      carModel: modelController3.text,
                      carMake: makeController3.text,
                      id: '3',
                    ));
                  }
                  if (colorController4.text != '' &&
                      makeController4.text != '' &&
                      modelController4.text != '') {
                    cars.add(Car(
                      carColor: colorController4.text,
                      carModel: modelController4.text,
                      carMake: makeController4.text,
                      id: '4',
                    ));
                  }
                  UpdateProfileCubit updateProfileCubit =
                      UpdateProfileCubit.instance(context);
                  updateProfileCubit.updateCustomerProfile(
                      widget.customer.id.toString(),
                      _textEditingController5.text,
                      countryNumber.toString().substring(0),
                      cars);
                },
                child: Container(
                  width: size.width * 0.8,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Center(
                      child: Text(languageCubit.Save!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        openFilter
            ? Scaffold(
                backgroundColor: Colors.black12,
                resizeToAvoidBottomInset: false,
                body: Center(
                  child: Container(
                    width: 325,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(20)),
                      border: Border.all(width: 1, color: kPrimaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            "من فصلك قم باختيار موديل السيارة",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              // color: kPrimaryColor2
                            ),
                          ),
                          TextField(
                            onChanged: (val) {
                              setState(() {
                                filter = true;
                                if (val == "") {
                                  filterModels = models;
                                } else {
                                  if (model) {
                                    filterModels = models!
                                        .where((element) => element
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(val))
                                        .toList();
                                  } else {
                                    filterModels = models!
                                        .where((element) => element.name
                                            .toString()
                                            .toLowerCase()
                                            .startsWith(val))
                                        .toList();
                                  }
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              hintText: "Search car brand",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                // color: kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 350,
                            height: size.height * 0.465,
                            child: BlocConsumer<CarDataCubit, CarDataStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is GetCarModelsStarted) {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ));
                                  } else if (state
                                      is GetCarModelsFinishedSuccessfully) {
                                    if (model) {
                                      models = state.carModels;
                                    } else {
                                      models = state.carMakes;
                                    }
                                    if (!filter) {
                                      filterModels = models;
                                    }
                                    return ListView.builder(
                                        itemCount: filterModels!.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (model) {
                                                if (currentIndex == 0) {
                                                  modelController1.setText(
                                                      filterModels![index]
                                                          .toString());
                                                }
                                                if (currentIndex == 1) {
                                                  modelController2.setText(
                                                      filterModels![index]
                                                          .toString());
                                                }
                                                if (currentIndex == 2) {
                                                  modelController3.setText(
                                                      filterModels![index]
                                                          .toString());
                                                }
                                                if (currentIndex == 3) {
                                                  modelController4.setText(
                                                      filterModels![index]
                                                          .toString());
                                                }
                                              } else {
                                                setState(() {
                                                  makeId =
                                                      filterModels![index]
                                                          .id
                                                          .toString();
                                                });

                                                if (currentIndex == 0) {
                                                  makeController1.setText(
                                                      filterModels![index]
                                                          .name
                                                          .toString());
                                                }
                                                if (currentIndex == 1) {
                                                  makeController2.setText(
                                                      filterModels![index]
                                                          .name
                                                          .toString());
                                                }
                                                if (currentIndex == 2) {
                                                  makeController3.setText(
                                                      filterModels![index]
                                                          .name
                                                          .toString());
                                                }
                                                if (currentIndex == 3) {
                                                  makeController4.setText(
                                                      filterModels![index]
                                                          .name
                                                          .toString());
                                                }
                                              }
                                              setState(() {
                                                openFilter = false;
                                              });
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  border: const Border
                                                          .symmetric(
                                                      horizontal: BorderSide(
                                                          color: Colors.black,
                                                          width: 0.5))),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    model
                                                        ? filterModels![index]
                                                            .toString()
                                                        : filterModels![index]
                                                            .name
                                                            .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.w300,
                                                      // color: kPrimaryColor,
                                                    ),
                                                  )),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Center(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 100,
                                        child: const Text(
                                          'Error occurred while loading lessons,\nplease try again later ..',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            // color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  if (model) {
                                    setState(() {
                                      modelCar = '';
                                    });
                                  } else {
                                    setState(() {
                                      make = '';
                                    });
                                  }
                                  setState(() {
                                    openFilter = false;
                                  });
                                },
                                child: const Text(
                                  "ألغاء",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // fontWeight: FontWeight.w400,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
        addCard
            ? AddCardScreen(onTap: () {
                setState(() {
                  addCard = false;
                });
              })
            : Container(),
      ],
    );
  }
}
