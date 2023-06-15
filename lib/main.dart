import 'package:bloc_project_using_event/screens/auth_pages/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_project_using_event/screens/auth_pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:bloc_project_using_event/screens/home_page/bloc/data_bloc.dart';
import 'package:bloc_project_using_event/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LogInBloc(),
        ),
        BlocProvider(
          create: (context) => DataBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Projrct',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    );
  }
}
