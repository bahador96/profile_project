import 'package:flutter/material.dart';
import 'package:profile_app/main.dart';

class Skill extends StatelessWidget {
  final SkillType type;
  final String title;
  final String imagePath;
  final Color shadowColor;
  final bool isActive;
  final Function() onTap;
  // int selectedIndex = 0;

  const Skill({
    Key? key,
    required this.type,
    required this.title,
    required this.imagePath,
    required this.shadowColor,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: (isActive)
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: (isActive)
                  ? BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    )
                  : null,
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
            ),
            const Text('Photoshop'),
          ],
        ),
      ),
    );
  }
}
