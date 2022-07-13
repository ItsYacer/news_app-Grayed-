import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc_observer.dart';
import 'package:newsapp/dio_helper.dart';
import 'package:newsapp/news_app/cubit/cubit.dart';
import 'package:newsapp/news_app/cubit/states.dart';

import 'news_app/news_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
      // debugPrint(isDark.toString());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: NewsLayout(),
      ),
    );
  }
}
