import 'package:emotion_tracker/application/history_bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryBloc>().add(GetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            return state.optionEmotionRecord.fold(
              () {
                return Container();
              },
              (recordList) {
                return SingleChildScrollView(
                  child: DataTable(
                    showBottomBorder: true,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Date',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Emotion',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      for (int i = 0; i < recordList.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                recordList[i].createDate.toIso8601String())),
                            DataCell(Text(recordList[i].emotion.value)),
                          ],
                        ),
                      for (int i = 0; i < recordList.length; i++)
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(
                                recordList[i].createDate.toIso8601String())),
                            DataCell(Text(recordList[i].emotion.value)),
                          ],
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
