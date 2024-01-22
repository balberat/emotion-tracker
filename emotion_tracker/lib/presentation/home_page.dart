import 'package:emotion_tracker/application/history_bloc/history_bloc.dart';
import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:emotion_tracker/presentation/history_page.dart';
import 'package:emotion_tracker/presentation/quote_display_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Emotion> goodEmotions = [
      Emotion.alertness,
      Emotion.amusement,
      Emotion.awe,
      Emotion.gratitude,
      Emotion.hope,
      Emotion.joy,
      Emotion.love,
      Emotion.pride,
      Emotion.satisfaction,
    ];
    List<Emotion> badEmotions = [
      Emotion.anger,
      Emotion.anxiety,
      Emotion.contempt,
      Emotion.disgust,
      Emotion.embarrassment,
      Emotion.fear,
      Emotion.quilt,
      Emotion.offense,
      Emotion.sadness,
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Emotion Tracker"),
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            state.optionEmotion.fold(
              () {},
              (emotion) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuoteDisplayPage(emotion: emotion)),
                );
              },
            );
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "How Are Yoru ? ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 230,
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    children: [
                      for (int i = 0; i < goodEmotions.length; i++)
                        EmotionBox(isGood: true, emotion: goodEmotions[i]),
                    ],
                  ),
                ),
                const SizedBox(height: 70),
                SizedBox(
                  height: 230,
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 2,
                    children: [
                      for (int i = 0; i < badEmotions.length; i++)
                        EmotionBox(isGood: false, emotion: badEmotions[i]),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
            child: const Text(
              "Show History",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class EmotionBox extends StatelessWidget {
  final Emotion emotion;
  final bool isGood;
  const EmotionBox({
    super.key,
    required this.emotion,
    required this.isGood,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HistoryBloc>().add(AddItemToHistoryEvent(emotion));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: isGood ? Colors.blue : Colors.red, width: 3),
        ),
        child: Center(
            child: Text(
          emotion.value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
