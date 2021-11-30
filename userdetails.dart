import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:general_market/constants/konstants.dart';
import 'package:general_market/profile/avatar.dart';
import 'package:general_market/services/database.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController addressController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
final TextEditingController businessNameController = TextEditingController();
final TextEditingController firstNameController = TextEditingController();
final TextEditingController displayNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
bool isLoading = false;
late String errorMessage3 = '';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  State<ProfileUpdate> createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  int currentStep = 0;
  tapped(int step) {
    setState(() => currentStep = step);
  }

  static final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final isLastStep = currentStep == signUpSteps().length - 1;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: buildText(context,
              text: 'Account Information',
              size: 22,
              fontWeight: FontWeight.w700),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Stepper(
                type: StepperType.vertical,
                onStepTapped: (step) => tapped(step),
                steps: signUpSteps(),
                currentStep: currentStep,
                elevation: 1,
                onStepCancel: () {
                  currentStep == 0 ? null : setState(() => currentStep -= 1);
                },
                onStepContinue: () {
                  setState(() => currentStep += 1);
                }),
            if (currentStep != 0)
              if (currentStep != 1)
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CupertinoButton.filled(
                          child: buildText(context,
                              text: 'SAVE',
                              size: 16,
                              fontWeight: FontWeight.w700),
                          onPressed: () async {
                            FirebaseService().userSetup(
                                phoneNumberController.text.trim(),
                                firstNameController.text.trim(),
                                lastNameController.text.trim(),
                                businessNameController.text.trim(),
                                descriptionController.text.trim(),
                                addressController.text.trim(),
                                stateController.text.trim());
                          }

                          // Navigator.of(context).push(PageRouteBuilder(
                          //     transitionDuration: const Duration(seconds: 1),
                          //     pageBuilder: (context, animation, _) {
                          //       return FadeTransition(
                          //           opacity: animation,
                          //           child: const ProfileView());
                          //     }));

                          )),
                ),
          ],
        ));
  }

  /*
  ////////////////
  //   STEPS     //
  //  DEFINITION //
   ////////////////
   */
  List<Step> signUpSteps() {
    final size = MediaQuery.of(context).size;
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: buildText(context,
            text: 'Personal Information',
            size: 18,
            fontWeight: FontWeight.w700),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                radius: 60,
                avatarUrl: '',
                onTap: () async {
                  File image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery) as File;

                  //TODO: Upload the image to firebase storage
                },
              ),
              /*
...........Sign up...................NAME FIELD.....................
                                 */
              buildText(context,
                  text: 'FullName', fontWeight: FontWeight.w700, size: 16),
              CupertinoTextField(
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(1)
                        : white.withOpacity(1),
                    fontSize: 18),
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.vertical()),
                cursorHeight: 18,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                minLines: null,
                maxLines: 1,
                prefix: Row(
                  children: [
                    Icon(
                      CupertinoIcons.person,
                      color: Theme.of(context).brightness == Brightness.light
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
              CupertinoTextField(
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(1)
                        : white.withOpacity(1),
                    fontSize: 18),
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.vertical()),
                cursorHeight: 18,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                minLines: null,
                maxLines: 1,
                prefix: Row(
                  children: [
                    Icon(
                      CupertinoIcons.person_solid,
                      color: Theme.of(context).brightness == Brightness.light
                          ? black.withOpacity(0.5)
                          : white.withOpacity(0.2),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                controller: lastNameController,
                placeholder: 'Last Name',
                onSubmitted: validateName,
              ),
              buildDivider(context),
              const SizedBox(height: 20),
              CupertinoTextField(
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(1)
                        : white.withOpacity(1),
                    fontSize: 18),
                decoration:
                    const BoxDecoration(borderRadius: BorderRadius.vertical()),
                cursorHeight: 18,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textCapitalization: TextCapitalization.words,
                obscureText: false,
                keyboardType: const TextInputType.numberWithOptions(),
                minLines: null,
                maxLines: 1,
                prefix: Row(
                  children: [
                    Icon(
                      CupertinoIcons.phone,
                      color: Theme.of(context).brightness == Brightness.light
                          ? black.withOpacity(0.5)
                          : white.withOpacity(0.2),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                controller: phoneNumberController,
                placeholder: 'Phone Number',
                onSubmitted: validatePhone,
              ),
              buildDivider(context),
              /*
 //////////Sign Up         /////Email field
                                 */

              /*

                                 */
              const SizedBox(height: 20),
              /*
/////////Sign Up      /////////PASSWORD FIELD///////////////
                                 */
            ],
          ),
        ),
      ),
      Step(
          /*
        //
        //
        //
        //PROFILE PICTURE AND ABOUT AND BUSINESS NAME
         */
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: buildText(context,
              text: 'Business Contact Details',
              size: 18,
              fontWeight: FontWeight.w700),
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildText(context,
                text: 'Business Name', fontWeight: FontWeight.w700, size: 16),
            CupertinoTextField(
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black.withOpacity(1)
                      : white.withOpacity(1),
                  fontSize: 18),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.vertical()),
              cursorHeight: 18,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textCapitalization: TextCapitalization.words,
              obscureText: false,
              minLines: null,
              maxLines: 1,
              prefix: Row(
                children: [
                  Icon(
                    CupertinoIcons.building_2_fill,
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(0.5)
                        : white.withOpacity(0.2),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              controller: businessNameController,
              placeholder: 'Business Name',
              onSubmitted: validateName,
            ),
            const Divider(),
            const SizedBox(height: 20),
            buildText(context,
                text: 'Business Description',
                fontWeight: FontWeight.w700,
                size: 16),
            CupertinoTextField(
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black.withOpacity(1)
                      : white.withOpacity(1),
                  fontSize: 18),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.vertical()),
              cursorHeight: 18,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textCapitalization: TextCapitalization.words,
              obscureText: false,
              minLines: null,
              maxLines: null,
              prefix: Row(
                children: [
                  Icon(
                    CupertinoIcons.building_2_fill,
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(0.5)
                        : white.withOpacity(0.2),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              controller: descriptionController,
              placeholder: '150 Words maximum',
              onSubmitted: validateName,
              expands: true,
            ),
            const Divider(),
            const SizedBox(height: 20),
          ])),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: buildText(context,
              text: 'Address Information',
              size: 18,
              fontWeight: FontWeight.w700),
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            buildText(context,
                text: 'Physical Location',
                fontWeight: FontWeight.w700,
                size: 16),
            CupertinoTextField(
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black.withOpacity(1)
                      : white.withOpacity(1),
                  fontSize: 18),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.vertical()),
              cursorHeight: 18,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textCapitalization: TextCapitalization.words,
              obscureText: false,
              minLines: null,
              maxLines: 1,
              prefix: Row(
                children: [
                  Icon(
                    CupertinoIcons.location,
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(0.5)
                        : white.withOpacity(0.2),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              controller: addressController,
              placeholder: 'No.123 suits road nowhere',
              onSubmitted: validateName,
            ),
            const Divider(),
            const SizedBox(height: 20),
            buildText(context,
                text: 'State', fontWeight: FontWeight.w700, size: 16),
            CupertinoTextField(
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black.withOpacity(1)
                      : white.withOpacity(1),
                  fontSize: 18),
              decoration:
                  const BoxDecoration(borderRadius: BorderRadius.vertical()),
              cursorHeight: 18,
              padding: const EdgeInsets.symmetric(vertical: 15),
              textCapitalization: TextCapitalization.words,
              obscureText: false,
              minLines: null,
              maxLines: 1,
              prefix: Row(
                children: [
                  Icon(
                    CupertinoIcons.map,
                    color: Theme.of(context).brightness == Brightness.light
                        ? black.withOpacity(0.5)
                        : white.withOpacity(0.2),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              controller: stateController,
              placeholder: 'State',
              onSubmitted: validateName,
            ),
            const Divider(),
            // buildText(context,
            //     text: 'Country', fontWeight: FontWeight.w700, size: 16),
            // CupertinoTextField(
            //   style: TextStyle(
            //       color: Theme.of(context).brightness == Brightness.light
            //           ? black.withOpacity(1)
            //           : white.withOpacity(1),
            //       fontSize: 18),
            //   decoration:
            //       const BoxDecoration(borderRadius: BorderRadius.vertical()),
            //   cursorHeight: 18,
            //   padding: const EdgeInsets.symmetric(vertical: 15),
            //   textCapitalization: TextCapitalization.words,
            //   obscureText: false,
            //   minLines: null,
            //   maxLines: 1,
            //   controller: stateController,
            //   placeholder: 'Country',
            //   onSubmitted: validateName,
            // ),
            // const Divider(),
          ])),
    ];
  }

  /*
  //
  //
  //
   Validators
   */

  String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'Email address is required';
    }

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format';

    return null;
  }

  /*

  name validator
   */

  String? validateName(String? formName) {
    if (formName == null || formName.isEmpty) {
      return 'Name required address is required';
    }

    String pattern = r'(?=.*?[A-Z])(?=.*?[a-z])';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formName)) return 'Invalid Name Format';

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

  String? validatePhone(String? formPhone) {
    if (formPhone == null || formPhone.isEmpty) {
      return 'Strong password is required';
    }
    String pattern = r'^(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formPhone)) {
      return '''
  Please input valid Phone Number
    ''';
    }

    return null;
  }
}
