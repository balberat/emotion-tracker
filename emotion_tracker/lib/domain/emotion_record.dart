import 'package:equatable/equatable.dart';

class EmotionRecord extends Equatable {
  final int id;
  final Emotion emotion;
  final DateTime createDate;

  const EmotionRecord({
    required this.id,
    required this.emotion,
    required this.createDate,
  });

  @override
  List<Object?> get props => [id, emotion, createDate];

  Map<String, dynamic> toMap() {
    return {
      "emotion": emotion.value,
      "create_date": createDate.millisecondsSinceEpoch,
    };
  }

  factory EmotionRecord.fromMap(Map<String, dynamic> map) {
    return EmotionRecord(
      id: map["id"] as int,
      emotion: Emotion.fromValue(map["emotion"]),
      createDate:
          DateTime.fromMillisecondsSinceEpoch(map["create_date"] as int),
    );
  }

  EmotionRecord copyWith({
    int? id,
    Emotion? emotion,
    DateTime? createDate,
  }) {
    return EmotionRecord(
      id: id ?? this.id,
      emotion: emotion ?? this.emotion,
      createDate: createDate ?? this.createDate,
    );
  }
}

enum Emotion {
  alertness('alertness'),
  amusement('amusement'),
  awe('awe'),
  gratitude('gratitude'),
  hope('hope'),
  joy('joy'),
  love('love'),
  pride('pride'),
  satisfaction('satisfaction'),

  anger('anger'),
  anxiety('anxiety'),
  contempt('contempt'),
  disgust('disgust'),
  embarrassment('embarrassment'),
  fear('fear'),
  quilt('quilt'),
  offense('offense'),
  sadness('sadness');

  final String value;
  const Emotion(this.value);

  factory Emotion.fromValue(String value) {
    switch (value) {
      case 'alertness':
        return Emotion.alertness;
      case 'amusement':
        return Emotion.amusement;
      case 'awe':
        return Emotion.awe;
      case 'gratitude':
        return Emotion.gratitude;
      case 'hope':
        return Emotion.hope;
      case 'joy':
        return Emotion.joy;
      case 'love':
        return Emotion.love;
      case 'pride':
        return Emotion.pride;
      case 'satisfaction':
        return Emotion.satisfaction;
      case 'anger':
        return Emotion.anger;
      case 'anxiety':
        return Emotion.anxiety;
      case 'contempt':
        return Emotion.contempt;
      case 'disgust':
        return Emotion.disgust;
      case 'embarrassment':
        return Emotion.embarrassment;
      case 'fear':
        return Emotion.fear;
      case 'quilt':
        return Emotion.quilt;
      case 'offense':
        return Emotion.offense;
      case 'sadness':
        return Emotion.sadness;
      default:
        return Emotion.alertness;
    }
  }
}
