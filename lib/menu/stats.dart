import 'package:flutter/material.dart';
import 'package:tic_tac_toe/util/util.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        getUiText(context).stats,
      )),
      body: Center(
        child: Text(getUiText(context).stats),
      ),
    );
  }
}
