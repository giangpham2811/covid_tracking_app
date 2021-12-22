import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/bloc/bloc_observer.dart';
import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/network/cases_service.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/home/home_screen.dart';
import 'package:covid_19_tracking/ui/route/app_route.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_void_async
void main() async {
  Bloc.observer = AppBlocObserver();
  Paint.enableDithering = true;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRoute _appRoute;
  GlobalSummaryRepository globalSummaryRepository = GlobalSummaryRepository(
    restCaseService: RestCaseService(
      Dio(
        BaseOptions(
          sendTimeout: 5000,
          receiveTimeout: 5000,
          connectTimeout: 5000,
        ),
      ),
    ),
  );
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    _appRoute = AppRoute(globalSummaryRepository: globalSummaryRepository, userRepository: userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: const IconThemeData(
            color: bgColor, //change your color here
          ),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: bgColor),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: textColor),
        canvasColor: cardColor,
        cardColor: cardColor,
      ),
      home: HomeScreen(globalSummaryRepository: globalSummaryRepository,userRepository: userRepository),
      onGenerateRoute: _appRoute.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
