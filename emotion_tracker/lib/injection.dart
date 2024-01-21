import 'package:emotion_tracker/application/history_bloc/history_bloc.dart';
import 'package:emotion_tracker/application/quote_bloc/quote_bloc.dart';
import 'package:emotion_tracker/infrastructure/contoller/sqflite_controller.dart';
import 'package:emotion_tracker/infrastructure/repository/quote_repository.dart';
import 'package:emotion_tracker/infrastructure/storage/history_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  await injectPackages();
  await injectInfras();
  await injectBloc();
}

Future<void> injectPackages() async {
  getIt.registerSingleton<Client>(Client());
}

Future<void> injectInfras() async {
  final db = await openSqfliteDatabase();
  getIt.registerSingleton<EmotionHistoryStorage>(EmotionHistoryStorage(db!));
  getIt.registerSingleton<QuoteRepository>(QuoteRepository(
    getIt<Client>(),
  ));
}

Future<void> injectBloc() async {
  getIt.registerFactory<HistoryBloc>(
    () => HistoryBloc(getIt<EmotionHistoryStorage>()),
  );
  getIt.registerFactory<QuoteBloc>(() => QuoteBloc(getIt<QuoteRepository>()));
}
