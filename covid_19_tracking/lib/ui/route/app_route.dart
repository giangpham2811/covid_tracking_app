import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/account_screen.dart';
import 'package:covid_19_tracking/ui/account/login/login_screen.dart';
import 'package:covid_19_tracking/ui/account/login/screen/reset_password_screen.dart';
import 'package:covid_19_tracking/ui/account/signup/signup_page.dart';
import 'package:covid_19_tracking/ui/country_details/country_details_bloc/country_details_bloc.dart';
import 'package:covid_19_tracking/ui/country_details/country_details_pages.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_screen.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_bloc/summary_bloc.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_screen.dart';
import 'package:covid_19_tracking/ui/home/home_screen.dart';
import 'package:covid_19_tracking/ui/instruction/instruction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  AppRoute({required this.userRepository, required this.globalSummaryRepository});

  final GlobalSummaryRepository globalSummaryRepository;
  final UserRepository userRepository;

  Route onGenerateRoute(RouteSettings routeSettings) {
    final SummaryBloc _summaryBloc = SummaryBloc(globalSummaryRepository);
    switch (routeSettings.name) {
      case HomeViewRoute:
        return PageTransition(
          child: HomeScreen(
            globalSummaryRepository: globalSummaryRepository,
            userRepository: userRepository,
          ),
          type: PageTransitionType.fade,
        );
      case GlobalViewRoute:
        return MaterialPageRoute<Widget>(
          builder: (_) => BlocProvider<SummaryBloc>.value(
            value: _summaryBloc..add(SummaryEventRequested()),
            child: const DashboardScreen(title: 'COVID-19 TRACKING'),
          ),
        );
      case CountryViewRoute:
        return MaterialPageRoute<Widget>(
          builder: (_) => BlocProvider<SummaryBloc>.value(
            value: _summaryBloc..add(SummaryEventRequested()),
            child: const CountryScreen(title: 'Reports by countries'),
          ),
        );
      case FaqsViewRoute:
        return MaterialPageRoute<Widget>(
          builder: (_) => const InstructionScreen(
            title: 'FAQs',
          ),
        );
      case CountryDetailsViewRoute:
        return PageTransition(
            child: BlocProvider(
              create: (_) => CountryDetailsBloc(globalSummaryRepository, (routeSettings.arguments! as Country).slug)..add(CountryDetailsFetchedEvent()),
              child: CountryDetailPages(
                title: '${(routeSettings.arguments! as Country).country} ',
                country: routeSettings.arguments! as Country,
              ),
            ),
            type: PageTransitionType.leftToRight,
            settings: routeSettings);

      case AccountViewRoute:
        return MaterialPageRoute<Widget>(
          builder: (_) {
            return AccountScreen(userRepository: userRepository);
          },
        );
      case SignUpViewRoute:
        return MaterialPageRoute<Widget>(builder: (_) {
          return SignUpPage(userRepository: userRepository);
        });
      case SignInViewRoute:
        return MaterialPageRoute<Widget>(builder: (_) {
          return LoginPage(userRepository: userRepository);
        });
      case ResetPasswordViewRoute:
        return MaterialPageRoute<Widget>(builder: (_) {
          return const ResetPassword();
        });
      default:
        return MaterialPageRoute<Widget>(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
