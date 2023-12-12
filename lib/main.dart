import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_1/data/repos/series_repo_impl.dart';
import 'package:task_1/layout/home_layout.dart';
import 'package:task_1/shared/cubit/cubit.dart';
import 'package:task_1/shared/cubit/states.dart';
import 'package:task_1/shared/helpers/helpers.dart';
import 'package:task_1/shared/network/remote/dio_helper.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(seriesRepoImpl: SeriesRepoImpl()),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies',
            theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromRGBO(21, 28, 38, .6),
              textTheme: const TextTheme(
                  displayMedium: TextStyle(
                color: Colors.teal,
                fontSize: 17,
              )),
              useMaterial3: true,
            ),
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}
