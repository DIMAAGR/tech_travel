import 'package:flutter/material.dart';

class UserButton extends StatelessWidget {
  final String userFirstLetter;
  final VoidCallback onPressed;
  const UserButton({super.key, required this.userFirstLetter, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(child: Text(userFirstLetter)),
      ),
    );
  }
}
