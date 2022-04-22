import 'package:flutter/material.dart';

class LinkOption extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;

  const LinkOption({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: const Icon(
          Icons.arrow_forward,
          size: 13,
          color: Colors.black,
        ),
      ),
    );
  }
}
