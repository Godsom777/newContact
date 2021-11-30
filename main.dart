import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:general_market/screens/authenticationpage.dart';
import 'package:general_market/screens/contacts.dart';
import 'package:general_market/screens/profileview.dart';
import 'package:general_market/screens/userdetails.dart';
import 'package:general_market/services/auth.dart';
import 'package:provider/provider.dart';

import 'constants/konstants.dart';
import 'constants/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setupServices();
  runApp(const MyApp());
}

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  static String title = 'Gorbes';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //  TODO: change the of appbar color to match the dark mode

      statusBarColor: Theme.of(context).brightness == Brightness.dark
          ? black
          : Colors.transparent,
      systemNavigationBarColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xff23C7AC)
          : Colors.transparent,
    ));

    return ChangeNotifierProvider(
      create: (context) => AuthRepo(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/profileView': (context) => const ProfileView(),
          '/profileUpdate': (context) => const ProfileUpdate()
        },
        debugShowCheckedModeBanner: false,
        title: title,
        theme: FlexColorScheme.light(
          colors: const FlexSchemeColor(
              primary: Color(0xff244b61),
              primaryVariant: Color(0xffff4d06),
              secondary: Color(0xffff9006),
              secondaryVariant: Color(0xff284050)),
          scheme: FlexScheme.amber,
        ).toTheme,
        darkTheme: FlexColorScheme.dark(
          darkIsTrueBlack: false,
          colors: const FlexSchemeColor(
              primary: Color(0xff202828),
              primaryVariant: Color(0xffaa3200),
              secondary: Color(0xffff9006),
              secondaryVariant: Color(0xff507890)),
          scheme: FlexScheme.indigo,
        ).toTheme,
        themeMode: ThemeMode.system,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return const AuthenticationPage();
            }
            return const Contacts();
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
