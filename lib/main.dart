import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sada/features/home/screen/home_municipality.dart';
import 'package:sada/features/home/widgets/bottom_nav_bar.dart';
import 'package:sada/features/onboarding/onboarding.dart';
import 'package:sada/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سَدَى',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF2FEA9B),
          selectionHandleColor: Color(0xFF2FEA9B),
          selectionColor: Color(0x662FEA9B),
        ),
      ),

      home: const HomeMunicipality(),
      // home: const Onboarding(),
      // home: BottomNavBar(),
    );
  }
}
