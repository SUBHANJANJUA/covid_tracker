import 'package:covid_tracker/Country_State.dart';
import 'package:covid_tracker/Model/WorldSateModel.dart';
import 'package:covid_tracker/Services/state_servieces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WordStateScreen extends StatefulWidget {
  const WordStateScreen({super.key});

  @override
  State<WordStateScreen> createState() => _WordStateScreenState();
}

class _WordStateScreenState extends State<WordStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  final colorList = <Color>[
    Color(0xFF4285F4),
    Color(0xFF1aa268),
    Color(0xFFde5246),
  ];
  StateServieces stateServieces = StateServieces();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: stateServieces.fetchWordStateModel(),
                builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "total":
                                double.parse(snapshot.data!.cases!.toString()),
                            "recover": double.parse(
                                snapshot.data!.recovered!.toString()),
                            "deaths":
                                double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          chartRadius: 150,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              spacing: 20,
                              children: [
                                CovidDetailRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString(),
                                ),
                                CovidDetailRow(
                                  title: "Recover",
                                  value: snapshot.data!.recovered.toString(),
                                ),
                                CovidDetailRow(
                                  title: "deaths",
                                  value: snapshot.data!.deaths.toString(),
                                ),
                                CovidDetailRow(
                                  title: "Current",
                                  value: snapshot.data!.active.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountryStateScreen()));
                            },
                            child: Text('Track Countries'))
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class CovidDetailRow extends StatelessWidget {
  const CovidDetailRow({
    super.key,
    required this.title,
    required this.value,
  });
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
