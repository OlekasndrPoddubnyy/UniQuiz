import 'package:flutter/material.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key,
    this.color,
    required this.time
  }) : super(key: key);

  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timer_rounded, size: 16, color: color??Theme.of(context).primaryColor,),
        const SizedBox(width: 5,),
        Text(time, style: const TextStyle(
          color: Colors.white,
          letterSpacing: 2,

        ))
      ],
    );
  }
}
