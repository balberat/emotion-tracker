import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Emotion Tracker"),
      ),
      body: SizedBox(
        child: GridView.count(
          crossAxisCount: 4,
          children: const [
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
            EmotionBox(),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {},
          child: Container(
            width: 120,
            height: 30,
            color: Colors.black,
          )),
    );
  }
}

class EmotionBox extends StatelessWidget {
  const EmotionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        color: Colors.amber,
      ),
    );
  }
}
