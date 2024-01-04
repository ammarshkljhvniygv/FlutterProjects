import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:onroad/StateManagement/blocs/language_cubit.dart';
import 'package:onroad/models/car_make.dart';
import 'package:onroad/widget/field.dart';

class EditForm extends StatefulWidget {
  EditForm({
    Key? key,
    required this.onTap1,
    required this.onTap2,
    required this.textEditingController1,
    required this.textEditingController2,
    required this.textEditingController3,
  }) : super(key: key);
  VoidCallback onTap1, onTap2;

  final TextEditingController textEditingController1;
  final TextEditingController textEditingController2;
  final TextEditingController textEditingController3;
  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  // var controller = MaskedTextController(mask: '0000/0000', text: '12345678');

  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  bool model = false;
  String? makeId;
  List<CarMake>? carMakes = [];
  List<String> models = [];
  bool? edit = false;
  bool filter = false;
  bool openFilter = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LanguageCubit languageCubit = LanguageCubit.instance(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Field(
              text: languageCubit.carMade!,
              validatText: languageCubit.youHaveTo! + languageCubit.carMade!,
              readOnly: true,
              suffixIcon: Icon(Icons.arrow_drop_down),
              controller: widget.textEditingController1,
              onTap: widget.onTap1,
              maxWidth: 100,
              obscureText: false),
          SizedBox(
            height: size.height * 0.01,
          ),
          Field(
            text: languageCubit.carModel!,
            validatText: languageCubit.youHaveTo! + languageCubit.carModel!,
            readOnly: true,
            suffixIcon: Icon(Icons.arrow_drop_down),
            maxWidth: 110,
            obscureText: false,
            controller: widget.textEditingController2,
            onTap: widget.onTap2,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Field(
            text: languageCubit.carColor!,
            validatText: languageCubit.youHaveTo! + languageCubit.carColor!,
            readOnly: false,
            controller: widget.textEditingController3,
            // keyboardType: TextInputType.number,
            // maxLength: 4,
            obscureText: false,

            // controller: controller,
            maxWidth: 100,
            suffixIcon: Container(
              width: 0,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
/*
          Directionality(
            textDirection: TextDirection.rtl,
            child: GestureDetector(
              onTap: () {
                CarDataCubit carDataCubit = CarDataCubit.instance(context);
                carDataCubit.getCarMakes();
                setState(() {
                  filter = false;
                  model = false;
                  openFilter = true;
                });
              },
              child: BlocConsumer<CarDataCubit, CarDataStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is GetCarModelsStarted) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ));
                    } else if (state is GetCarModelsFinishedSuccessfully) {
                      if (model) {
                        // models = state.carModels!;
                      } else {}
                      return CustomDropdown.search(
                        borderSide: BorderSide(color: kPrimaryColor, width: 1),
                        hintText: 'صنع السيارة ',
                        items: state.carMakes!
                            .map((element) => element.name.toString())
                            .toList(),
                        controller: textEditingController1,
                        onChanged: (val) {
                          textEditingController1.setText(val);
                        },
                      );
                    } else {
                      return Center(
                        child: Container(
                          color: Colors.transparent,
                          height: 100,
                          child: Text(
                            'Error occurred while loading lessons,\nplease try again later ..',
                            style: GoogleFonts.cairo(
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
          ),
*/
