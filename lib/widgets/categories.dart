import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/pages/category_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryItem(context, icon: FaIcon(FontAwesomeIcons.gamepad, color: Colors.white, size: 40), label: 'Arcade', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatDetails(id: 11)))),
          _buildCategoryItem(
            context,
            icon: FaIcon(FontAwesomeIcons.baseballBatBall, color: Colors.white, size: 40),
            label: 'Sports',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatDetails(id: 15))),
          ),
          _buildCategoryItem(
            context,
            icon: Icon(CupertinoIcons.car_detailed, color: Colors.white, size: 40),
            label: 'Racing',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatDetails(id: 1))),
          ),
          _buildCategoryItem(context, icon: Icon(FontAwesomeIcons.gun, color: Colors.white, size: 40), label: 'Shooter', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatDetails(id: 2)))),
          _buildCategoryItem(
            context,
            icon: Icon(Icons.shield, color: Colors.white, size: 40),
            label: 'RPG',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatDetails(id: 5))),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, {required Widget icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[800],
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
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
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
