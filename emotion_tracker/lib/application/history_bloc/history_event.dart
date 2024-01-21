part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryEvent extends HistoryEvent {}

class AddItemToHistoryEvent extends HistoryEvent {
  final Emotion emotion;

  const AddItemToHistoryEvent(this.emotion);
}
