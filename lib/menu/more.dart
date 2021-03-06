import 'package:flutter/material.dart';

import '../util/util.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getUiText(context).more),
      ),
      body: Center(
        child: Text(getUiText(context).more),
      ),
    );
  }
}