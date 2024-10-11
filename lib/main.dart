import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kip_shooping/navbar.dart';
import 'package:kip_shooping/provider/filer_provider.dart';
import 'package:kip_shooping/view/filter.dart';
import 'package:kip_shooping/view/filter_result.dart';
import 'package:kip_shooping/view/first.dart';
import 'package:kip_shooping/view/home.dart';
import 'package:kip_shooping/view/course.dart';
import 'package:kip_shooping/view/login.dart';
import 'package:kip_shooping/view/screen5.dart';
import 'package:kip_shooping/view/sign_up.dart';
import 'package:kip_shooping/widgets/pageroutebuilder.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilterProvider(),
      child: MaterialApp(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "first":
              return createRoute(FirstPage());
            case "signup":
              return createRoute(SignUpScreen());
            case "login":
              return createRoute(LoginScreen());
            case "home":
              return createRoute(HomePageScreen());
            case "filter":
              Map<String, dynamic> args =
                  settings.arguments as Map<String, dynamic>;
              return createRoute(FilterPage(
                productDataList: args["productDataList"],
              ));
            case "filterResult":
              Map<String, dynamic> args =
                  settings.arguments as Map<String, dynamic>;
              return createRoute(FilterResult(
                productDataList: args["productDataList"],
                selectedCategories: args['selectedCategories'],
                searchText: args['searchText'],
              ));
            default:
              return createRoute(FirstPage());
          }
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return const FirstPage();
    // return const SignUpScreen();
    // return const LoginScreen();
    return const CourseScreen();
    // return const NavBar();
    // return const HomePageScreen();
    // return FilterPage();
  }
}
