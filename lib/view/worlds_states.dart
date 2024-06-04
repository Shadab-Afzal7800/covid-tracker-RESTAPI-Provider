import 'package:covid_tracker/constants/colors.dart';
import 'package:covid_tracker/widgets/reusable_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            PieChart(
              dataMap: {'Total': 20, 'Recovered': 15, 'Deaths': 5},
              colorList: ConstantColors.colorList,
              chartRadius: MediaQuery.of(context).size.width / 2,
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.left,
              ),
              chartType: ChartType.ring,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Card(
                child: Column(
                  children: [
                    ReusableRowWidget(title: "Title", value: "8000"),
                    ReusableRowWidget(title: "Title", value: "8000"),
                    ReusableRowWidget(title: "Title", value: "8000"),
                    ReusableRowWidget(title: "Title", value: "8000"),
                    ReusableRowWidget(title: "Title", value: "8000"),
                    ReusableRowWidget(title: "Title", value: "8000"),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: ConstantColors.colorList[1],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("Track Countries"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
