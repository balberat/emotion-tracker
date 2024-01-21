import 'dart:async';

import 'package:emotion_tracker/application/history_bloc/history_bloc.dart';
import 'package:emotion_tracker/environment_variables.dart' as env;
import 'package:emotion_tracker/injection.dart';
import 'package:emotion_tracker/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await setupInjection();
    runApp(const MyApp());
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HistoryBloc>(),
        ),
      ],
      child: MaterialApp(
        title: env.APP_TITLE,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
