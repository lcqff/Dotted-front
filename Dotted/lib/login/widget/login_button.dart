import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const LoginButton({
    required this.imagePath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 250,
        height: 60,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onTap,
          child: Ink.image(
            image: AssetImage('assets/$imagePath.png'),
            fit: BoxFit.cover,
            )
          ),
        ),
    );
  }
}