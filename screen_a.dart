// import 'package:fluent_ui/fluent_ui.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:general_market/constants/konstants.dart';

class MyView extends StatelessWidget {
  const MyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff054455),
          automaticallyImplyLeading: true,
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(
                FontAwesomeIcons.barcode,
                color: white,
              ),
            )
          ],
        ),
        backgroundColor: white,
        body: Column(
          children: [
            /*

            Gradient
            background
             */
            Expanded(
              flex: 2,
              child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    // stops: [1, 0.4],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff054455),
                      Color(0xff095d72),
                    ],
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('images/images.jpg'),
                        maxRadius: 80,
                      ),
                      buildText(context,
                          text: 'Okoro Chisom',
                          size: 26,
                          color: white,
                          fontWeight: FontWeight.w600),
                      buildText(context,
                          text:
                              'Graphic Artist, Content Creator, Mobile App developer',
                          size: 16,
                          color: white,
                          fontWeight: FontWeight.w400),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 200,
                          minHeight: 50,
                        ),
                        child: SizedBox.shrink(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildFaIcon(
                                    FontAwesomeIcons.facebookF, () => null),
                                buildFaIcon(FontAwesomeIcons.facebookMessenger,
                                    () => null),
                                buildFaIcon(
                                    FontAwesomeIcons.whatsapp, () => null),
                                buildFaIcon(
                                    FontAwesomeIcons.twitter, () => null),
                                buildFaIcon(
                                    FontAwesomeIcons.instagram, () => null),
                              ]),
                        ),
                      )
                    ],
                  )),
            ),
            /*

            Second half
             */
            Expanded(
              flex: 3,
              child: SizedBox(
                  height: size.height,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        /*
 Identification
                         */
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: SizedBox(
                            width: size.width,
                            child: buildTextL(
                                Colors.grey.withOpacity(0.8), context,
                                text: "IDENTIFICATION",
                                size: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        buildListRows(size, context, 'Phone Number',
                            'Main Line', '0813-677-2107'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'Phone Number',
                            'Other number', '234-564-1655'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'Driver\'s License',
                            'Lagos Lekki-Ng', 'LKNG-5464-165-65'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'Passport ID', 'Canadian',
                            'CNDA-165-65'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'National ID', 'Nigeria',
                            'NGN-258-605'),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: SizedBox(
                            width: size.width,
                            child: buildTextL(
                                Colors.grey.withOpacity(0.8), context,
                                text: "PERSONAL INFORMATION",
                                size: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        /*
  Personal Information
                         */
                        SizedBox(
                          height: size.height * .3,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            children: [
                              buildGrid(context, 'Date of Birth', '25/11/2021',
                                  size, FontAwesomeIcons.babyCarriage),
                              buildGrid(context, 'Age', '28', size,
                                  FontAwesomeIcons.baby),
                              buildGrid(
                                  context, 'Gender', 'Male', size, Icons.wc),
                              buildGrid(
                                context,
                                'Race',
                                'Hispanic',
                                size,
                                FontAwesomeIcons.users,
                              ),
                              buildGrid(
                                context,
                                'Height',
                                '5ft 8\'',
                                size,
                                FontAwesomeIcons.textHeight,
                              ),
                              buildGrid(context, 'Eyes', 'Brown', size,
                                  CupertinoIcons.eye),
                              buildGrid(
                                context,
                                'Completion',
                                'Chocolate',
                                size,
                                FontAwesomeIcons.palette,
                              ),
                              buildGrid(context, 'Facial Marks', 'None', size,
                                  CupertinoIcons.strikethrough),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        /*
Medical Information
                         */
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8),
                          child: SizedBox(
                            width: size.width,
                            child: buildTextL(
                                Colors.grey.withOpacity(0.8), context,
                                text: "MEDICAL INFORMATION",
                                size: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        buildListRows(size, context, 'Blood Group',
                            'Positive/Negative', 'A+ (Positive)'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(
                            size, context, 'Genotype', 'Gene type', 'AB'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'Allergies',
                            'Allergic to...', 'Pollen'),
                        const SizedBox(
                          height: 1,
                        ),
                        buildListRows(size, context, 'Medical Conditions',
                            'other medical conditions', 'None'),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFaIcon(IconData kcon, Function() onPressed) => Material(
        child: InkResponse(
            splashColor: white,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Icon(
                kcon,
                color: white,
                size: 18,
              ),
            )),
        color: Colors.transparent,
      );

  Container buildGrid(BuildContext context, String text1, String text2,
      Size size, IconData icons) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black54.withOpacity(0.1),
              blurRadius: 1.0,
              offset: const Offset(0.0, 1.0))
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                context,
                text: text1,
                color: Colors.teal[800]!.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                size: 16,
              ),
              buildText(context,
                  text: text2,
                  size: 18,
                  color: const Color(0xff054455),
                  fontWeight: FontWeight.w600),
              SizedBox(
                width: size.width,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    icons,
                    color: Colors.teal,
                    size: 14,
                  ),
                ),
              )
            ]),
      ),
    );
  }

  Widget buildListRows(
      Size size, BuildContext context, String header, String sub, String farR) {
    return Column(
      children: [
        Container(
            width: size.width,
            height: size.height * .09,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54.withOpacity(0.1),
                    blurRadius: 1.0,
                    offset: Offset(0.0, 1.0))
              ],
              color: Colors.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildText(context,
                              color: Colors.teal[800],
                              text: header,
                              size: 18,
                              fontWeight: FontWeight.w600),
                          buildText(context,
                              text: sub,
                              size: 16,
                              color: Colors.teal[800]!.withOpacity(0.7),
                              fontWeight: FontWeight.w400)
                        ]),
                    buildText(context,
                        text: farR,
                        size: 17,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.w600)
                  ]),
            )),
      ],
    );
  }
}
