import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/menu/more.dart';
import 'package:tic_tac_toe/menu/settings.dart';
import 'package:tic_tac_toe/menu/stats.dart';
import 'package:tic_tac_toe/util/util.dart';
import 'info.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).hoverColor),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset("web/images/logo.svg")),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      getUiText(context).options,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(getUiText(context).settings),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SettingsScreen();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: Text(getUiText(context).stats),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const StatsScreen();
                        },
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.more_horiz),
                    title: Text(getUiText(context).more),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const MoreScreen();
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: Theme.of(context).hoverColor,
              leading: const Icon(Icons.info),
              title: Text(getUiText(context).info),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const InfoScreen();
                  },
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
