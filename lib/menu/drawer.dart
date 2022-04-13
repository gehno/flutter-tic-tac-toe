import 'package:flutter/material.dart';
import 'package:tic_tac_toe/menu/more.dart';
import 'package:tic_tac_toe/menu/settings.dart';
import 'package:tic_tac_toe/menu/stats.dart';

import '../main.dart';
import 'about.dart';

class DrawerWidger extends StatelessWidget {
  const DrawerWidger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DrawerHeader(
            child: Text(
              "Options",
              style: MyApp.titleTextStyle,
            ),
            decoration: BoxDecoration(color: MyApp.titleColor),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Settings"),
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
                  title: const Text("Stats"),
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
                  title: const Text("More"),
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
            tileColor: Colors.grey.shade300,
            leading: const Icon(Icons.info),
            title: const Text("About"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AboutScreen();
                },
              ));
            },
          )
        ],
      ),
    );
  }
}
