import 'package:covid_tracker/Detail_Screen.dart';
import 'package:covid_tracker/Services/state_servieces.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryStateScreen extends StatefulWidget {
  const CountryStateScreen({super.key});

  @override
  State<CountryStateScreen> createState() => _CountryStateScreenState();
}

class _CountryStateScreenState extends State<CountryStateScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServieces stateServieces = StateServieces();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServieces.countryStateApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(itemBuilder: (context, Index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade800,
                      child: Column(
                        children: [
                          ListTile(
                            title: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]["country"];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              active: snapshot.data![index]
                                                  ["active"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                              name: snapshot.data![index]
                                                  ["country"],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              totalCases: snapshot.data![index]
                                                  ["cases"],
                                              totalDeaths: snapshot.data![index]
                                                  ["deaths"],
                                              totalRecoverd: snapshot
                                                  .data![index]["recovered"],
                                            ))),
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]))),
                              )
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              active: snapshot.data![index]
                                                  ["active"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                              name: snapshot.data![index]
                                                  ["country"],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              totalCases: snapshot.data![index]
                                                  ["cases"],
                                              totalDeaths: snapshot.data![index]
                                                  ["deaths"],
                                              totalRecoverd: snapshot
                                                  .data![index]["recovered"],
                                            ))),
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]["country"]),
                                    subtitle: Text(snapshot.data![index]
                                            ["cases"]
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]["countryInfo"]
                                                ["flag"]))),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
