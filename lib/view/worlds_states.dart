import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:covid_tracker/constants/colors.dart';
import 'package:covid_tracker/models/world_states.dart';
import 'package:covid_tracker/services/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:covid_tracker/widgets/reusable_row_widget.dart';

class WorldsStates extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;

  const WorldsStates({
    Key? key,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates>
    with TickerProviderStateMixin {
  StatesServices statesServices = StatesServices();
  bool isDarkMode = true;
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 5))
        ..repeat();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                  widget.onThemeChanged(isDarkMode);
                });
              })
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            FutureBuilder(
                future: statesServices.fetchWorldsStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.black,
                      size: 50,
                      controller: _animationController,
                    ));
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'No data available',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': snapshot.data!.cases!.toDouble(),
                            'Recovered': snapshot.data!.recovered!.toDouble(),
                            'Deaths': snapshot.data!.deaths!.toDouble(),
                          },
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: ConstantColors.colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2.3,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartType: ChartType.ring,
                          key: ValueKey("PieChart"), // Add a unique key
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRowWidget(
                                    title: "Total Cases",
                                    value: snapshot.data!.cases!.toString()),
                                ReusableRowWidget(
                                    title: "Total Recovered",
                                    value:
                                        snapshot.data!.recovered!.toString()),
                                ReusableRowWidget(
                                    title: "Total Deaths",
                                    value: snapshot.data!.deaths!.toString()),
                                ReusableRowWidget(
                                    title: "Active Cases",
                                    value: snapshot.data!.active!.toString()),
                                ReusableRowWidget(
                                    title: "Critical Cases",
                                    value: snapshot.data!.critical!.toString()),
                                ReusableRowWidget(
                                    title: "Total Tests",
                                    value: snapshot.data!.tests!.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: ConstantColors.colorList[1],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text("Track Countries"),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}
