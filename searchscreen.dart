import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/screens/profileview.dart';
import 'package:general_market/screens/resultpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : black,
                borderRadius: const BorderRadius.all(Radius.circular(0))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: SizedBox(
                height: height,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ProfileView()));
                          // await FirebaseAuth.instance.signOut();
                          // setState(() {});
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            CupertinoIcons.person_crop_circle,
                          ),
                          // backgroundImage: AssetImage('images/image_processing20200402-11577-xz2e92.gif'),
                          maxRadius: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 150.0),
                      child: Column(
                        children: [
                          Center(
                              child: buildText(context,
                                  fontWeight: FontWeight.w900,
                                  size: 87,
                                  text: 'GORBES')),
                          SizedBox(height: height * 0.04),
                          SizedBox(
                              height: 50,
                              child: CupertinoSearchTextField(
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? black.withOpacity(1)
                                        : white.withOpacity(1),
                                    fontSize: 22),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical()),
                                placeholderStyle: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? black.withOpacity(0.5)
                                        : white.withOpacity(0.5)),
                                placeholder: 'What Job are you looking for...',
                              )),
                          const Divider(
                            indent: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: CupertinoButton.filled(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchResultScreen()));
                                  },
                                  child: buildText(
                                    context,
                                    text: 'Search',
                                    fontWeight: FontWeight.normal,
                                    size: 14,
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
