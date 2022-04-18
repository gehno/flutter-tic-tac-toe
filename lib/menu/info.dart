import 'package:flutter/material.dart';

import '../util/util.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getUiText(context).info),
      ),
      body: Center(
        child: Text(getUiText(context).info),
      ),
    );
  }
}
