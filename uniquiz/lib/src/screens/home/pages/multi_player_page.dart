import 'package:flutter/material.dart';

class MultiPlayerPage extends StatelessWidget {
  const MultiPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("multi platform", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
      ),
    );
  }
}