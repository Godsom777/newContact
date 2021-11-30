import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/profile/list.dart';
import 'package:general_market/screens/screen_a.dart';

import '../main.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late final Duration duration;
  // late final double width;
  // bool isTouched = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 1200));
  //
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  late AnimationController _controller;
  bool isChanged = false;
  double _width = 0;
  double _height = 0;
  late Animation<double> _animationDouble;
  late bool _isError = false;

  _updateState() {
    setState(() {
      _width = 250;
      _height = 120;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationDouble = CurvedAnimation(
        parent: _controller, curve: Curves.easeInOutCubicEmphasized);
  }

  _reverseState() {
    setState(() {
      _width = 0;
      _height = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                  width: _width,
                  height: _height,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: CupertinoSearchTextField(
                      backgroundColor: white,
                      prefixIcon: Text(''),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )),
            ],
          ),
          backgroundColor: const Color(0xff095d72),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8),
              child: InkWell(
                onTap: () {
                  _height == 0 ? _updateState() : _reverseState();
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.search_ellipsis,
                  progress: _controller,
                ),
              ),
              // color: black,
              // onPressed: () {
              //   _height == 0 ? _updateState() : _reverseState();
              // },
            ),
          ],
          elevation: 1,
        ),

        /*
        Body
         */
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(context,
                        text: 'Most Recently (${allContacts.length - 5})',
                        size: 15,
                        fontWeight: FontWeight.w600,
                        color: black.withOpacity(.3)),
                    Container(
                      color: Colors.white,
                      height: 80,
                      width: double.infinity,
                      child: Scrollbar(
                        scrollbarOrientation: ScrollbarOrientation.top,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      //TODO: implement onTap function here
                                      onTap: () {},
                                      child:
                                          // Container(
                                          //   height: 100,
                                          //   width: 100,
                                          //   decoration: BoxDecoration(),
                                          // )
                                          CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  allContacts[index].Image),
                                              onBackgroundImageError:
                                                  (context, index) {
                                                setState(([index]) {
                                                  _isError = true;
                                                });
                                              },
                                              /*
                                        Text on the Avatar
                                                                */
                                              maxRadius: 25,
                                              child: _isError == true
                                                  ? buildTextL(white, context,
                                                      text: allContacts[index]
                                                          .name,
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.normal)
                                                  : CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(
                                                              allContacts[index]
                                                                  .Image),
                                                      maxRadius: 50,
                                                    )),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: size.height,
                  child: Scrollbar(
                    radius: Radius.circular(25),
                    isAlwaysShown: false,
                    interactive: true,
                    thickness: 10,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: buildText(context,
                                  text:
                                      'All Contacts (${allContacts.length.toString()})',
                                  size: 15,
                                  fontWeight: FontWeight.w600,
                                  color: black.withOpacity(.3)),
                            ),
                          ),
                          SizedBox(
                            height: size.height,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: allContacts.length,
                                itemBuilder: (BuildContext context, index) {
                                  final contacts = allContacts[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MyView(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Slidable(
                                              startActionPane: ActionPane(
                                                motion: const StretchMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (context) {},
                                                    backgroundColor:
                                                        Color(0xffa6bfb6),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: 'Delete',
                                                  ),
                                                ],
                                              ),
                                              endActionPane: ActionPane(
                                                motion: const DrawerMotion(),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (context) {},
                                                    backgroundColor:
                                                        Color(0xFF00BA54),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: FontAwesomeIcons
                                                        .whatsapp,
                                                    label: '',
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (context) {},
                                                    backgroundColor:
                                                        Color(0xFF0392CF),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: FontAwesomeIcons
                                                        .facebookSquare,
                                                    label: '',
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (context) {},
                                                    backgroundColor:
                                                        Color(0xFFF31A71),
                                                    foregroundColor:
                                                        Color(0xffe7e7fc),
                                                    icon: FontAwesomeIcons
                                                        .instagram,
                                                    label: '',
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (context) {},
                                                    backgroundColor:
                                                        Color(0xFF007FBA),
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: FontAwesomeIcons
                                                        .twitter,
                                                    label: '',
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    contacts
                                                                        .Image),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                            width: 20,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              buildText(context,
                                                                  text: contacts
                                                                      .name,
                                                                  size: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              buildTextL(
                                                                  Colors.grey
                                                                      .withOpacity(
                                                                          .8),
                                                                  context,
                                                                  text: contacts
                                                                      .description,
                                                                  size: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ],
                                                          ),
                                                        ]),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'slide for more options',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[400]),
                                                        ),
                                                        Icon(Icons.arrow_right)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          const Divider(
                                            thickness: 0.5,
                                            endIndent: 35,
                                            indent: 75,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        /*
        Nav bar
         */
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    // stops: [1, 0.4],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff054455),
                      Color(0xff095d72),
                    ],
                  ),
                  borderRadius: BorderRadius.only(),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: white),
                      child: Center(child: Image(image: AssetImage(''))),
                    ),
                    buildTextL(white, context,
                        text: 'Godsom Okoro',
                        size: 20,
                        fontWeight: FontWeight.bold)
                  ],
                ),
              ),
              drawerListTile(context, 'Favourite', FontAwesomeIcons.solidHeart),
              const Divider(
                endIndent: 20,
                indent: 45,
              ),
              drawerListTile(context, 'Recent', FontAwesomeIcons.solidClock),
              const Divider(
                endIndent: 20,
                indent: 45,
              ),
              drawerListTile(context, 'Groups', FontAwesomeIcons.usersCog),
              const Divider(
                endIndent: 20,
                indent: 45,
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTextL(black, context,
                          text: 'Dark Mode', size: 18, fontWeight: FontWeight.normal),
                      IconButton(
                          icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                              ? Icons.dark_mode
                              : Icons.light_mode),
                          onPressed: () {
                            MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light;
                          })
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              )
              const Divider(
                endIndent: 20,
                indent: 45,
              ),
              drawerListTile(context, 'Settings', FontAwesomeIcons.cog),
            ],
          ),
        ),
      ),
    );
  }

  ListTile drawerListTile(BuildContext context, String text, IconData icon) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildTextL(black, context,
                text: text, size: 18, fontWeight: FontWeight.normal),
            Icon(
              icon,
              size: 16,
              color: black.withOpacity(0.7),
            )
          ],
        ),
      ),
      onTap: () {
        // Update the state of the app.
        // ...
      },
    );
  }

  searchField(Size size) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Row(
        children: const [
          Icon(CupertinoIcons.search),
          CupertinoSearchTextField()
        ],
      ),
    );
  }

  void triggerIcon() {
    setState(() {
      isChanged = !isChanged;
      isChanged ? _controller.forward() : _controller.reverse();
    });
  }
}
