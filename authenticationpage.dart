import 'dart:math' as math;
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/screens/profileview.dart';
import 'package:general_market/screens/userdetails.dart';
import 'package:general_market/services/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String errorMessage = '';

  /*
//                     //
//                     //
// sign Up uses errorMessage2 //
//                     //
//                     //
//                     //
//                     //
/////////////////////////
   */
  late String errorMessage2 = '';
  bool isLoading = false;

  /* animation for the contacts container

  */
  late AnimationController _controller;

  double get _maxHeight => MediaQuery.of(context).size.height;
  double imgStartSize = 45;
  double imgEndSize = 120;
  double verticalSpace = 25;
  double horizontalSpace = 15;
  bool isChanged = false;

  bool _obscureText = true;
  void _togglepwd() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///*
  ///
  ///
  ///
  /// lerp controller
  /// */

  double? lerp(double min, double max) {
    return lerpDouble(min, max, _controller.value);
  }

  void toggle() {
    final bool isCompleted = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isCompleted ? -1 : 1);
  }

  void verticalDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta! / _maxHeight;
  }

  void verticalDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;
/*
/////////////////////////////////////////////
////////////////////////////////////////////
/
///////////////////////
//
//
/
///fling partition construction for the container
 */
    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _maxHeight;

    if (flingVelocity < 0) {
      _controller.fling(velocity: math.max(1, -flingVelocity));
    } else if (flingVelocity > 0) {
      _controller.fling(velocity: math.min(-1, -flingVelocity));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -1 : 1);
    }
  }

  double? gameTopMargin(int index) {
    return lerp(20, 10 + index * (verticalSpace + imgEndSize));
  }

  double? gameLeftMargin(int index) {
    return lerp(index * (horizontalSpace + imgStartSize), 0);
  }

  /*Google sign in function implementation

  there are plenty other API's
  most need additional verification by google

  you can add them here as required
   */
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Form(
      key: _key,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: buildText(context,
                text: 'Get Started', size: 22, fontWeight: FontWeight.w800),
          ),
          resizeToAvoidBottomInset: false,
          body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => GestureDetector(
              onLongPress: toggle,
              onVerticalDragEnd: verticalDragEnd,
              onVerticalDragUpdate: verticalDragUpdate,
              child: Stack(children: [
                // Opacity(
                //     opacity: lerp(0.2, 0)!.toDouble(),
                //     child: const Image(
                //       image: AssetImage('images/01.png'),
                //     )),
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const SizedBox(
                      height: 200,
                      child: Image(
                        image: AssetImage('images/2853458.png'),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: buildText(context,
                                text: 'Sign in',
                                size: 32,
                                fontWeight: FontWeight.w900)),
                        Center(
                            child: buildText(context,
                                text: 'Sign in to your account',
                                size: 18,
                                fontWeight: FontWeight.w300)),

                        /*

                         */

                        CupertinoTextField(
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? black.withOpacity(1)
                                  : white.withOpacity(1),
                              fontSize: 18),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical()),
                          cursorHeight: 18,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          minLines: null,
                          maxLines: 1,
                          controller: emailController,
                          placeholder: 'Email',
                          onSubmitted: validateEmail,
                        ),
                        buildDivider(context),
                        /*+

                         */
                        const SizedBox(height: 20),
                        CupertinoTextField(
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? black.withOpacity(1)
                                  : white.withOpacity(1),
                              fontSize: 18),
                          expands: false,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical()),
                          cursorHeight: 18,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp('[ ]'))
                          ],
                          obscureText: true,
                          minLines: null,
                          maxLines: 1,
                          controller: passwordController,
                          onSubmitted: validatePassword,
                          placeholder: 'Password',
                        ),
                        buildDivider(context),
                        /*

                         */
                        Center(
                            child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                        )),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /* The sign in form field
                            where we implement the firebase Sign In methods
                             */
                            CupertinoButton.filled(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                        color: white,
                                        strokeWidth: 1.5,
                                        backgroundColor: black,
                                      )
                                    : const Text('Sign In'),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_key.currentState!.validate()) {
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                    } on FirebaseAuthException catch (error) {
                                      errorMessage = error.message!;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: black,
                                        content: Text(
                                          errorMessage,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? black
                                                  : white),
                                        ),
                                      ));
                                    }
                                  }

                                  setState(() => isLoading = false);
                                }),

                            /* The sign Up button migration
                            where we implement the firebase Sign UP methods
                          /// User data is created and stored in the firebase cloud
                          //
                          //
                          //we can use this method to add the user profile pictures
                          // and address, and name later, after a successful sign up
                             */
                            CupertinoButton(
                                child: const Text('Sign Up'),
                                onPressed: triggerIcon),

                            /* The sign Up form field
                            where we implement the firebase SIgn OUT methods
                             */
                            // CupertinoButton(
                            //     child: const Text('Sign Out'),
                            //     onPressed: () async {
                            //       await FirebaseAuth.instance.signOut();
                            //       setState(() {});
                            //     }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      // implement
                      onPressed: () {
                        final provider =
                            Provider.of<AuthRepo>(context, listen: false);
                        provider.googleLogin();
                      },
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.green.shade500
                            : black,
                      ),
                      label: buildText(context,
                          text: 'Sign in with Google',
                          size: 18,
                          fontWeight: FontWeight.w800))
                ]),

                /*
 Sign up slider column
                */
                Positioned(
                  top: 200,
                  bottom: 0,
                  right: 0,
                  left: lerp(width, 0),
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white.withOpacity(1)
                        : Colors.black12.withOpacity(1),
                    child: Center(
                      child: Column(
                        children: [
                          /*

                           */
                          Column(
                            children: [
                              buildText(context,
                                  text: 'Create an Account',
                                  fontWeight: FontWeight.w800,
                                  size: 40),
                              buildText(context,
                                  text:
                                      'Create an account to access all features',
                                  fontWeight: FontWeight.w300,
                                  size: 16)
                            ],
                          ),
                          SizedBox(
                            height: height * 0.6,
                            child: ListView(children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildText(context,
                                              text: 'FullName',
                                              fontWeight: FontWeight.w700,
                                              size: 16),
                                          CupertinoTextField(
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? black.withOpacity(1)
                                                    : white.withOpacity(1),
                                                fontSize: 18),
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.vertical()),
                                            cursorHeight: 18,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            textCapitalization:
                                                TextCapitalization.words,
                                            obscureText: false,
                                            minLines: null,
                                            maxLines: 1,
                                            prefix: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.person,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? black.withOpacity(0.5)
                                                      : white.withOpacity(0.2),
                                                ),
                                                const SizedBox(width: 15),
                                              ],
                                            ),
                                            controller: firstNameController,
                                            placeholder: 'First Name',
                                            onSubmitted: validateName,
                                          ),
                                          buildDivider(context),
                                          const SizedBox(height: 20),
                                          CupertinoTextField(
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? black.withOpacity(1)
                                                    : white.withOpacity(1),
                                                fontSize: 18),
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.vertical()),
                                            cursorHeight: 18,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(
                                                  RegExp('[ ]'))
                                            ],
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            textCapitalization:
                                                TextCapitalization.none,
                                            obscureText: false,
                                            minLines: null,
                                            maxLines: 1,
                                            placeholder: 'Email',
                                            prefix: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.envelope,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? black.withOpacity(0.5)
                                                      : white.withOpacity(0.2),
                                                ),
                                                const SizedBox(width: 15)
                                              ],
                                            ),
                                            controller: emailController,
                                            suffixMode: OverlayVisibilityMode
                                                .notEditing,
                                            clearButtonMode:
                                                OverlayVisibilityMode.editing,
                                            onSubmitted: validateEmail,
                                          ),
                                          buildDivider(context),
                                          const SizedBox(height: 20),
                                          const SizedBox(height: 20),
                                          CupertinoTextField(
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? black.withOpacity(1)
                                                    : white.withOpacity(1),
                                                fontSize: 18),
                                            expands: false,
                                            decoration: const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.vertical()),
                                            cursorHeight: 18,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(
                                                  RegExp('[ ]'))
                                            ],
                                            obscureText: _obscureText,
                                            minLines: null,
                                            maxLines: 1,
                                            prefix: Row(
                                              children: [
                                                Icon(
                                                  CupertinoIcons.padlock,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? black.withOpacity(0.5)
                                                      : white.withOpacity(0.2),
                                                ),
                                                const SizedBox(width: 15),
                                              ],
                                            ),
                                            suffix: Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      _obscureText
                                                          ? CupertinoIcons.eye
                                                          : CupertinoIcons
                                                              .eye_slash,
                                                      color: Theme.of(context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? black
                                                              .withOpacity(0.5)
                                                          : white
                                                              .withOpacity(0.2),
                                                    ),
                                                    onPressed: () {
                                                      _togglepwd();
                                                    }),
                                                const SizedBox(width: 15),
                                              ],
                                            ),
                                            suffixMode:
                                                OverlayVisibilityMode.editing,
                                            clearButtonMode:
                                                OverlayVisibilityMode.never,
                                            controller: passwordController,
                                            onSubmitted: validatePassword,
                                            placeholder: 'Password',
                                          ),
                                          buildDivider(context),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: width,
                                            child: CupertinoButton.filled(
                                                child: isLoading
                                                    ? const CircularProgressIndicator(
                                                        color: white,
                                                        strokeWidth: 1.5,
                                                        backgroundColor: black,
                                                      )
                                                    : const Text('Next Step'),
                                                onPressed: () async {
                                                  setState(
                                                      () => isLoading = true);
                                                  if (_key.currentState!
                                                      .validate()) {
                                                    try {
                                                      UserCredential
                                                          userCredential =
                                                          await FirebaseAuth
                                                              .instance
                                                              .createUserWithEmailAndPassword(
                                                                  email:
                                                                      emailController
                                                                          .text,
                                                                  password:
                                                                      passwordController
                                                                          .text);

                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/profileUpdate');
                                                    } on FirebaseAuthException catch (error) {
                                                      errorMessage2 =
                                                          error.message!;
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        backgroundColor: Theme.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? black
                                                            : Colors.teal,
                                                        content: Text(
                                                          errorMessage2,
                                                          style: TextStyle(
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? white
                                                                  : white),
                                                        ),
                                                      ));
                                                    }
                                                  }

                                                  return setState(
                                                      () => isLoading = false);
                                                }),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  buildText(context,
                                                      size: 16,
                                                      text:
                                                          'Already have an Account? ',
                                                      fontWeight:
                                                          FontWeight.w300),
                                                  CupertinoButton(
                                                      child:
                                                          const Text('Sign In'),
                                                      onPressed: () {
                                                        triggerIcon();
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //
                                    //     child: Align(
                                    //         alignment: Alignment.bottomRight,
                                    //         child: Opacity(
                                    //             opacity: 0.05,
                                    //             child: const Image(image: AssetImage('images/lock-1330-470359.png'),)))
                                    // ),
                                  ]),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }

  void triggerIcon() {
    setState(() {
      isChanged = !isChanged;
      isChanged ? _controller.forward() : _controller.reverse();
    });
  }

/*
//
//
 */

/*

 */
//TODO: move to a new dart file
  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'Email address is required';
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format';

    return null;
  }

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Strong password is required';
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPassword)) {
      return '''
    Password must be at least 8 characters,
    include an uppercase letter, number and symbol
    ''';
    }

    return null;
  }
}
