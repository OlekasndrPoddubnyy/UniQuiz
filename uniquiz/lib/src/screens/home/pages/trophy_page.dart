import 'package:flutter/material.dart';

class TrophyPage extends StatelessWidget {
  const TrophyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("trophy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
      ),
    );
  }
}
