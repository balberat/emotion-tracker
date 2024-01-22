import 'package:emotion_tracker/application/quote_bloc/quote_bloc.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/injection.dart';
import 'package:emotion_tracker/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteDisplayPage extends StatelessWidget {
  final Emotion? emotion;
  const QuoteDisplayPage({super.key, this.emotion});

  @override
  Widget build(BuildContext context) {
    final argumentEmotion = Emotion.fromValue(
        (ModalRoute.of(context)?.settings.arguments).toString());
    return BlocProvider(
      create: (context) =>
          getIt<QuoteBloc>()..add(GetQuoteEvent(emotion ?? argumentEmotion)),
      child: BlocConsumer<QuoteBloc, QuoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.optionQuote.fold(
            () {
              return state.optionFailure.fold(
                () {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                (failure) {
                  return Scaffold(
                    body: Center(
                      child: InkWell(
                          onTap: () {
                            context
                                .read<QuoteBloc>()
                                .add(GetQuoteEvent(emotion ?? argumentEmotion));
                          },
                          child: const Icon(
                            Icons.refresh,
                            size: 50,
                            color: Colors.blue,
                          )),
                    ),
                  );
                },
              );
            },
            (quote) {
              return Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    Image.network(state.imageUrl, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 140.0,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            child: Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '“ ',
                                      style: const TextStyle(
                                          fontFamily: "Ic",
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30),
                                      children: [
                                        TextSpan(
                                            text: quote.body,
                                            style: const TextStyle(
                                                fontFamily: "Ic",
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22)),
                                        const TextSpan(
                                            text: '”',
                                            style: TextStyle(
                                                fontFamily: "Ic",
                                                fontWeight: FontWeight.w700,
                                                color: Colors.green,
                                                fontSize: 30))
                                      ]),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      quote.author,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: "Ic",
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                floatingActionButton: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Icon(Icons.home,
                            size: 35, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(
                                  text: "${quote.body}\n- ${quote.author}"))
                              .then(
                            (result) => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text("Copied to Clipboard"))),
                          );
                        },
                        child: const Icon(Icons.content_copy,
                            size: 30, color: Colors.white),
                      ),
                    ]),
              );
            },
          );
        },
      ),
    );
  }
}
