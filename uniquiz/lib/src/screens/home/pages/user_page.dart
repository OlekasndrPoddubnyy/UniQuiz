import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniquiz/src/constants/app_colors.dart';
import 'package:uniquiz/src/controllers/home_controller.dart';
import 'package:uniquiz/src/firebase/firebase_ref.dart';

import '../../../constants/colors.dart';
import '../../../models/user_model.dart';

class UserPage extends GetView<HomeController> {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: SafeArea(
          child: Obx(() => controller.user.value==null?
                const SizedBox()
                    :Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.15),
                        CircleAvatar(
                          backgroundImage: Image.network(controller.user.value?.photoURL ?? '').image,
                          radius: 45,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          controller.user.value!.displayName??'',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: onSurfaceTextColor,
                         ),
                        ),
                        Text(
                          'email : ${controller.user.value!.email??''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text('Total Point:  ${controller.points.value}',
                            style: const TextStyle(
                              fontWeight:FontWeight.w900,
                              letterSpacing: 2,
                              fontSize: 20,
                              color: onSurfaceTextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            _DrawerButton(
                              icon: Icons.email_rounded,
                              label: "Contact Us",
                              onPressed: () => controller.email(),
                            ),
                            const SizedBox(height: 20),
                            _DrawerButton(
                              icon: Icons.logout,
                              label: "Sign Out",
                              onPressed: () => controller.signOut(),
                            )],
                        )
                      ],
                    )),
        ),
        )
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({Key? key,
    required this.icon,
    required this.label,
    this.onPressed
  }) : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.75, 30)),
          backgroundColor: MaterialStateProperty.all(Colors.white54),
        ),
        onPressed: onPressed,
        icon: Icon(
          color: Colors.black87,
          icon,
          size: 25,
        ),
        label: Text(label, style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),)
    );
  }
}