import 'package:covid_tracker/Word_State_Screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image, name;
  final int totalCases,
      totalDeaths,
      totalRecoverd,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    super.key,
    required this.active,
    required this.critical,
    required this.image,
    required this.name,
    required this.test,
    required this.todayRecovered,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecoverd,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        spacing: 15,
                        children: [
                          CovidDetailRow(
                              title: "Cases",
                              value: widget.totalCases.toString()),
                          CovidDetailRow(
                              title: "Recovered",
                              value: widget.totalRecoverd.toString()),
                          CovidDetailRow(
                              title: "Deaths",
                              value: widget.totalDeaths.toString()),
                          CovidDetailRow(
                              title: "Active", value: widget.active.toString()),
                          CovidDetailRow(
                              title: "Critical",
                              value: widget.critical.toString()),
                          CovidDetailRow(
                              title: "Test", value: widget.test.toString()),
                          CovidDetailRow(
                              title: "Deaths",
                              value: widget.totalDeaths.toString()),
                          CovidDetailRow(
                              title: "Today Recoverd",
                              value: widget.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
