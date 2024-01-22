import 'package:emotion_tracker/environment_variables.dart' as env;
import 'package:emotion_tracker/injection.dart';
import 'package:emotion_tracker/presentation/history_page.dart';
import 'package:emotion_tracker/presentation/home_page.dart';
import 'package:emotion_tracker/presentation/quote_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/history_bloc/history_bloc.dart';

class EmotionTracker extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const EmotionTracker({super.key});

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
        navigatorKey: navigatorKey,
        routes: {
          '/': (context) => const HomePage(),
          '/history': (context) => const HistoryPage(),
          '/quote': (context) => const QuoteDisplayPage(),
        },
        initialRoute: '/',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
