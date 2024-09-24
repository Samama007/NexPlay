import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/pages/category_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    // Color foregroundColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryItem(context,
              icon: FaIcon(
                FontAwesomeIcons.gamepad,
                size: 40,
                color: backgroundColor,
              ),
              label: 'Arcade',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CatDetails(id: 11)))),
          _buildCategoryItem(
            context,
            icon: FaIcon(FontAwesomeIcons.baseballBatBall, color: backgroundColor, size: 40),
            label: 'Sports',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CatDetails(id: 15))),
          ),
          _buildCategoryItem(
            context,
            icon: Icon(CupertinoIcons.car_detailed, color: backgroundColor, size: 40),
            label: 'Racing',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CatDetails(id: 1))),
          ),
          _buildCategoryItem(context,
              icon: Icon(FontAwesomeIcons.gun, color: backgroundColor, size: 40),
              label: 'Shooter',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CatDetails(id: 2),
                  ))),
          _buildCategoryItem(
            context,
            icon: Icon(Icons.shield, color: backgroundColor, size: 40),
            label: 'RPG',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CatDetails(id: 5))),
          ),
          _buildCategoryItem(context,
              icon: FaIcon(
                FontAwesomeIcons.hammer,
                size: 40,
                color: backgroundColor,
              ),
              label: 'Fighting',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CatDetails(id: 6)))),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, {required Widget icon, required String label, required VoidCallback onTap}) {
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: foregroundColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: icon,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
