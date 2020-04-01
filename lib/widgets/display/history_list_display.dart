import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/history.dart';

class HistoryItem extends StatelessWidget {
  final String value;
  final double itemHeight;

  HistoryItem({
    @required this.value,
    @required this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        color: const Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(fontSize: itemHeight / 2.5),
        ),
      ),
    );
  }
}

class HistoryListDisplay extends StatelessWidget {
  final double parentHeight;

  HistoryListDisplay(this.parentHeight);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // Reversing so that in list view, we can start from bottom by using
    // reverse = true
    final historyItems =
        Provider.of<History>(context).historyItems.reversed.toList();

    final containerHeight = parentHeight * 0.78;

    return Container(
      height: containerHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: themeData.primaryColor, width: parentHeight * 0.01),
        ),
      ),
      child: ListView.builder(
        reverse: true,
        itemBuilder: (ctx, index) => HistoryItem(
          value: historyItems[index],
          itemHeight: containerHeight / 4.5,
        ),
        itemCount: historyItems.length,
      ),
    );
  }
}
