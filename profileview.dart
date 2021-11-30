import 'dart:math' as math;
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/constants/locator.dart';
import 'package:general_market/profile/user_controller.dart';
import 'package:general_market/screens/userdetails.dart';
import 'package:general_market/services/usermodel.dart';

import '../profile/avatar.dart';

class ProfileView extends StatefulWidget {
  static String route = "profile-view";

  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  UserModel currentUser = locator.get<UserController>().currentUser;
  /* animation for the contacts container

  */
  late AnimationController controller;
  double get _maxHeight => MediaQuery.of(context).size.height;
  double imgStartSize = 45;
  double imgEndSize = 120;
  double verticalSpace = 25;
  double horizontalSpace = 15;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ///*
  /// lerp controller
  /// */
  double? lerp(double min, double max) {
    return lerpDouble(min, max, controller.value);
  }

  void toggle() {
    final bool isCompleted = controller.status == AnimationStatus.completed;
    controller.fling(velocity: isCompleted ? -1 : 1);
  }

  void verticalDragUpdate(DragUpdateDetails details) {
    controller.value -= details.primaryDelta! / _maxHeight;
  }

  void verticalDragEnd(DragEndDetails details) {
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) return;
/*
///fling partition construction for the container
 */
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _maxHeight;

    if (flingVelocity < 0) {
      controller.fling(velocity: math.max(1, -flingVelocity));
    } else if (flingVelocity > 0) {
      controller.fling(velocity: math.min(-1, -flingVelocity));
    } else {
      controller.fling(velocity: controller.value < 0.5 ? -1 : 1);
    }
  }

  double? gameTopMargin(int index) {
    return lerp(20, 10 + index * (verticalSpace + imgEndSize));
  }

  double? gameLeftMargin(int index) {
    return lerp(index * (horizontalSpace + imgStartSize), 0);
  }

  //
  //
  //
  //
  //////// Back end for the User ////////////////////////////////

//late final TextEditingController nameController;
//late  final TextEditingController addressController;
//late  final TextEditingController descriptionController;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var users = FirebaseAuth.instance.currentUser!;
    final size = MediaQuery.of(context).size;

    return Material(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Material(
          child: SizedBox(
            // color: Colors.red,
            height: size.height,
            child: GestureDetector(
              onLongPress: toggle,
              onVerticalDragEnd: verticalDragEnd,
              onVerticalDragUpdate: verticalDragUpdate,
              ///// the bg container/////////////////////////
              /*

                 */
              child: Stack(children: [
                /*
 user work pictures
 TODO: make it a carousel when to show multiple user pictures
                      */

                Positioned(
                  height: lerp(size.height * 0.7, size.height * 0.3),
                  width: lerp(size.width + 0, size.width),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30))),

                    // child: Image(
                    //   image: NetworkImage("${user?.photoURL}"),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),

/* User contact details and information

                      */
/*
Gradient layer/////////////////////////////////////////
 */
                Positioned(
                  bottom: lerp(size.height * .1, 0),
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border(top:BorderSide(color: Colors.white,width: 2)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),

                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          stops: const [
                            0.5,
                            1
                          ],
                          colors: [
                            Theme.of(context).brightness == Brightness.light
                                ? white
                                : black,
                            Colors.black38.withOpacity(0)
                          ]),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  ),
                ),
                /*
name and avatar outside
                   */
                Positioned(
                  bottom: 0,
                  left: 100,
                  right: 100,
                  top: lerp(size.height * .3, size.height * .3),
                  child: Container(
                      decoration: BoxDecoration(
                        //border: Border(top:BorderSide(color: Colors.white,width: 2)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                        ),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? white.withOpacity(0)
                            : white.withOpacity(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /*
                            Avatar of the user
                             */
                          Avatar(
                            radius: lerp(60, 0),
                            avatarUrl: (user?.photoURL).toString(),
                            onTap: () {},
                          ),
                          buildText(context,
                              /*
                                name of the user
                                 */
                              text: currentUser.displayName.toString(),
                              size: lerp(28, 0),
                              fontWeight: FontWeight.w700),
                          buildText(context,
                              text: 'Graphics Designer',
                              size: lerp(18, 0),
                              fontWeight: FontWeight.w400)
                        ],
                      )),
                ),
                /*
 Social media handles

                   */
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: lerp(size.height * .7, size.height * .24),
                  child: Container(
                      decoration: BoxDecoration(
                          //border: Border(top:BorderSide(color: Colors.white,width: 2)),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.transparent //white.withOpacity(0.4)
                              : Colors.transparent),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*
                            twitter not available for nigerian
                            SizedBox(width:30),Icon(FontAwesomeIcons.twitter),
                            */
                          const SizedBox(width: 5),
                          buildText(context,
                              text: "",
                              size: lerp(0, 36),
                              fontWeight: FontWeight.w800),
                        ],
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 100,
                  right: 100,
                  top: lerp(size.height * .5, size.height * .7),
                  child: Container(
                      decoration: BoxDecoration(
                          //border: Border(top:BorderSide(color: Colors.white,width: 2)),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.transparent //white.withOpacity(0.4)
                              : Colors.transparent),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.text_bubble_fill,
                              semanticLabel: 'Message',
                            ),
                            //TODO: Add user Phone number
                            onPressed: () {},
                          ),
                          /*
                            twitter not available for nigerian
                            SizedBox(width:30),Icon(FontAwesomeIcons.twitter),
                            */
                          const SizedBox(width: 20),
                          IconButton(
                              icon: const Icon(
                                CupertinoIcons.phone_solid,
                                semanticLabel: 'Call',
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                setState(() {});
                              }),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      maxRadius: 28,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.person, size: 28),
                          onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: const Duration(seconds: 1),
                                pageBuilder: (context, animation, _) {
                                  return FadeTransition(
                                      opacity: animation,
                                      child: const ProfileUpdate());
                                }));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
/*
Cards start here

                   */
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: lerp(size.height * .6, size.height * .3),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border(top:BorderSide(color: Colors.white,width: 2)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),

                      //gradient to blend
                      gradient: LinearGradient(
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                          stops: const [
                            0.5,
                            1
                          ],
                          colors: [
                            Theme.of(context).brightness == Brightness.light
                                ? white.withOpacity(1)
                                : black.withOpacity(1),
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.white.withOpacity(1)
                                : Colors.black.withOpacity(1)
                          ]),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Positioned(
                      height: lerp(size.height * 0.4, size.height),
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? white.withOpacity(1)
                                              : black.withOpacity(1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: (2),
                                                color: Colors.black
                                                    .withOpacity(0.4))
                                          ],
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? black
                                                    : white,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            buildText(
                                              context,
                                              size: 18,
                                              text: 'ABOUT MY PAGE',
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const SizedBox(height: 10),
                                            buildText(
                                              context,
                                              text: (currentUser.description),
                                              fontWeight: FontWeight.w300,
                                              maxLines: 10,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    indent: 30,
                                    endIndent: 30,
                                    thickness: 1,
                                  ),
                                  /*  /Second card///////////////////////////////////////////////////////////////////////////////////

                                       */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      /* size of the second container

                                           */
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? black
                                              : white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: (2),
                                                color: Colors.black
                                                    .withOpacity(0.4))
                                          ],
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : white,
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                buildText(
                                                  context,
                                                  size: 18,
                                                  text: 'MUTUAL FRIENDS',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                buildText(
                                                  context,
                                                  size: 18,
                                                  text: 'VIEW MORE',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 80,
                                            child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        Avatar(
                                                            avatarUrl: '',
                                                            onTap: () {},
                                                            radius: 36),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        Avatar(
                                                            avatarUrl: '',
                                                            onTap: () {},
                                                            radius: 36),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        Avatar(
                                                            avatarUrl: '',
                                                            onTap: () {},
                                                            radius: 36),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        Avatar(
                                                            avatarUrl: '',
                                                            onTap: () {},
                                                            radius: 36),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    indent: 30,
                                    endIndent: 30,
                                    thickness: 1,
                                  ),
                                  /*
THIRD CARD FOR CONTACT INFORMATION
                                       */
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
/* size of the third container

                                           */
                                      height: 300,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? black
                                              : white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: (2),
                                                color: Colors.black
                                                    .withOpacity(0.4))
                                          ],
                                          border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.white
                                                    : white,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                buildText(
                                                  context,
                                                  size: 18,
                                                  text: 'ACCOUNT INFORMATION',
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 220,
                                              child: ListView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          buildText(context,
                                                              text:
                                                                  'Phone number',
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              maxLines: 1),
                                                          buildText(context,
                                                              text:
                                                                  "${user!.phoneNumber}",
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              maxLines: 1)
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 14),
                                                    const Divider(),
                                                    const SizedBox(height: 14),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          buildText(context,
                                                              text: 'E-mail',
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              maxLines: 1),
                                                          buildText(context,
                                                              text:
                                                                  "${user!.email}",
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              maxLines: 1)
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 14),
                                                    Divider(),
                                                    const SizedBox(height: 14),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          buildText(context,
                                                              text: 'Address',
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              maxLines: 1),
                                                          SizedBox(
                                                            width: 150,
                                                            child: buildText(
                                                                context,
                                                                text:
                                                                    '36 Elekwerenwa street warri, Rivers state',
                                                                size: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                maxLines: 2),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 14),
                                                    Divider(),
                                                    const SizedBox(height: 14),
                                                    SizedBox(
                                                      width: 100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          buildText(context,
                                                              text:
                                                                  'Other Contact',
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              maxLines: 1),
                                                          buildText(context,
                                                              text:
                                                                  "${user!.phoneNumber}",
                                                              size: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              maxLines: 1)
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 14),
                                                  ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void triggerIcon() {
    setState(() {
      isChanged = !isChanged;
      isChanged ? controller.forward() : controller.reverse();
    });
  }
}

String? validateName(String? formName) {
  if (formName == null || formName.isEmpty) {
    return 'Fill Out the empty fields';
  }

  return null;
}

String? validateBName(String? formBName) {
  if (formBName == null || formBName.isEmpty) {
    return 'Your Business name is required';
  }

  return null;
}

/*

//////////////////////
chere godi fes
Stack(
                  children: [
                    Column(children: [
                      Column(
                        children: [
                          Avatar(
                            avatarUrl: currentUser.avatarUrl, onTap: ()  async {
                              //TODO: open gallery select an image
                            await ImagePicker().pickImage(source: ImageSource.gallery);

                            //Todo: Upload the image to firebase storage
                            locator.get<UserController>().uploadProfilePicture();
                            // setState update the current user
                          },),
                          Text('Hi, ${currentUser.displayName}')
                        ],
                      ),
                      // SizedBox(
                      //   width: size.width * 0.6,
                      //   height: 25,
                      //   child: CupertinoTextField.borderless(
                      //     controller: nameController,
                      //     onSubmitted: validateName,
                      //     placeholder: "Your Name",
                      //   ),
                      // ),
                      SizedBox(
                        width: size.width * 0.6,
                        height: 25,
                        child: CupertinoTextField.borderless(
                         // controller: addressController,
                          onSubmitted: validateName,
                          placeholder: "Your Business Address",
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        height: 25,
                        child: CupertinoTextField.borderless(
                         // controller: descriptionController,
                          onSubmitted: validateName,
                          placeholder: "Describe Your Work",
                        ),
                      ),
                      CupertinoButton.filled(
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: white,
                            strokeWidth: 1.5,
                            backgroundColor: black,
                          )
                              : const Text('Sign Up'),
                          onPressed: () async {}
                          ),
                    ],)
                  ],
                ),




 */
