import 'package:filmflow/features/app/splash_screen/splash_screen.dart';
import 'package:filmflow/features/user_auth/pages/login_page.dart';
import 'package:filmflow/firebase_options.dart';
import 'package:filmflow/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: 'Film Flow',
      home: SplashScreen(
        child: HomePage(), //LoginPage(), //HomePage(),//da rimettere LogIn()
      ),
    );
  }
}
