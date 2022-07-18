import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/firebase_options.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/data_provider.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/providers/state_provider.dart';
import 'package:taba3ni/providers/user_provider.dart';
import 'package:taba3ni/services/shared_data.dart';
import 'package:taba3ni/views/login/getstarted.dart';
import 'package:taba3ni/views/login/login.dart';
import 'package:taba3ni/views/login/signup.dart';
import 'package:taba3ni/views/page_structure.dart';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';
/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port2 = ReceivePort();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DataPrefrences.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  IsolateNameServer.registerPortWithName(
    port2.sendPort,
    isolateName,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => StateProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ThemeNotifier>().initTheme(DataPrefrences.getDarkMode());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/index',
      routes: {
        '/index': (context) => const IndexScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const PageStructure()
      },
    );
  }
}
