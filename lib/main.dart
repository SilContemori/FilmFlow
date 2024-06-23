import 'package:filmflow/features/app/splash_screen/splash_screen.dart';
import 'package:filmflow/features/user_auth/pages/login_page.dart';
import 'package:filmflow/firebase_options.dart';
import 'package:filmflow/provider/wathist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WatchlistProvider())
      ],
      child: MaterialApp(
        routes: {
          '/login': (context) => const LoginPage(),
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        title: 'Film Flow',
        home: const SplashScreen(
          child: LoginPage(),
        ),
      ),
    );
  }
}
