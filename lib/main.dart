import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/size_config.dart';
import 'package:taba3ni/constant/style.dart';
import 'package:taba3ni/firebase_options.dart';
import 'package:taba3ni/providers/app_provider.dart';
import 'package:taba3ni/providers/auth_provider.dart';
import 'package:taba3ni/providers/language.dart';
import 'package:taba3ni/view/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return ConnectionNotifier(
          child: ThemeProvider(
              initTheme: darkTheme,
              builder: (context, myTheme) {
                return MaterialApp(
                  theme: myTheme,
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  routes: {'/': (context) => const WelcomeScreen()},
                );
              }),
        );
      });
    });
  }
}
