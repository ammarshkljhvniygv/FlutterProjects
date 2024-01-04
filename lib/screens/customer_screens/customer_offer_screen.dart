import 'package:flutter/material.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onroad/widget/mydirection.dart';
import '../../StateManagement/blocs/aboutas_cubit.dart';
import '../../StateManagement/blocs/aboutas_state.dart';
import '../../constant.dart';
import '../../models/offer.dart';

class CustomerOfferScreen extends StatefulWidget {
  const CustomerOfferScreen({Key? key}) : super(key: key);

  @override
  State<CustomerOfferScreen> createState() => _CustomerOfferScreenState();
}

class _CustomerOfferScreenState extends State<CustomerOfferScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    // tabController = TabController(length: taps.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageCubit languageCubit = LanguageCubit.instance(context);
    SettingCubit aboutAsCubit = SettingCubit.instance(context);
    aboutAsCubit.getOffers();
    return Scaffold(
      appBar: AppBar(
        title: Text(languageCubit.offers!),
        centerTitle: true,
      ),
      body: MyDirectionality(
        child: Column(
          children: [
            BlocConsumer<SettingCubit, SettingStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetOfferStarted) {
                    return SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  else if (state is GetOffersFinishSuccess) {
                    List<Offer> offers = state.offers! ;


                    return offers.isEmpty?Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
                        Image.asset('assets/images/Group 290.png'),
                        const SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            languageCubit.noOffers!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ) :Expanded(child: ListView.builder(
                      itemCount: offers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyDirectionality(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      languageCubit.language=='AR'?offers[index].arOfferTitle:offers[index].enOfferTitle,/**/
                                      style: GoogleFonts.roboto(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                      textAlign:languageCubit.language=='AR'? TextAlign.end:TextAlign.start,
                                    ),
                                    Text(
                                      languageCubit.language=='AR'?offers[index].arOffer:offers[index].enOffer,/*:سهولة التواصل*/

                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      textAlign:languageCubit.language=='AR'? TextAlign.end:TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },));
                  } else if (state is GetDataFinishWithError) {
                    return const Text('eroooooooooooooooooooooooooor');
                  } else {
                    return const Text('eroooooooooooooooooooooooooor');
                  }
                }),


          ],
        ),
      ),
    );
  }
}
