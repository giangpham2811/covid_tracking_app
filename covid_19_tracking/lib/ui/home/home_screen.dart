import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:covid_19_tracking/repositories/user_repository.dart';
import 'package:covid_19_tracking/ui/account/account_bloc/authentication_bloc.dart';
import 'package:covid_19_tracking/ui/account/account_screen.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_screen.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_bloc/summary_bloc.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_screen.dart';
import 'package:covid_19_tracking/ui/instruction/instruction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.globalSummaryRepository, required this.userRepository}) : super(key: key);
  final GlobalSummaryRepository globalSummaryRepository;
  final UserRepository userRepository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> viewContainer = [
      BlocProvider(
        create: (context) => SummaryBloc(widget.globalSummaryRepository)..add(SummaryEventRequested()),
        child: const DashboardScreen(title: ''),
      ),
      BlocProvider(
        create: (context) => SummaryBloc(widget.globalSummaryRepository)..add(SummaryEventRequested()),
        child: const CountryScreen(title: 'Reports by countries'),
      ),
      const InstructionScreen(
        title: 'FAQs',
      ),
      BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: widget.userRepository)..add(AuthenticationEventStarted()),
        child: AccountScreen(
          userRepository: widget.userRepository,
        ),
      ),
    ];

    void onTabTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    return Scaffold(
      body: viewContainer[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          fixedColor: bgColor,
          onTap: onTabTapped,
          unselectedItemColor: Colors.grey,
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_flags),
              label: 'Countries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer),
              label: 'FAQs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ]),
    );
  }
}
