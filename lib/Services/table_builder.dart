import 'package:flutter/material.dart';

class TableBuilder {
  List<Widget> buildCells(int count, List<String> array, BuildContext context,
      {Color color}) {
    return List.generate(
      count,
      (index) => Container(
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: color,
        ),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
        //alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width * 0.4,
        //color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: Center(child: Text(array[index], style: TextStyle())),
      ),
    );
  }

  List<Widget> _buildRows(int count, List<String> array, BuildContext context) {
    return List.generate(
      count,
      (index) => Row(
        children: buildCells(count, array, context),
      ),
    );
  }
}
