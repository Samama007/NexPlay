import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                onPressed: () {},
                icon: Icon(
                  Icons.sports_cricket_rounded,
                  color: Colors.white,
                  size: 50,
                )),
            Text('Sports', style: TextStyle(color: Colors.white, fontSize: 15))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            IconButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                onPressed: () {},
                icon: Icon(
                  Icons.sports_esports_rounded,
                  color: Colors.white,
                  size: 50,
                )),
            Text('Esports', style: TextStyle(color: Colors.white, fontSize: 15))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            IconButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                onPressed: () {},
                icon: Icon(
                  Icons.casino_rounded,
                  color: Colors.white,
                  size: 50,
                )),
            Text('Casino', style: TextStyle(color: Colors.white, fontSize: 15))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            IconButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 50,
                )),
            Text('More', style: TextStyle(color: Colors.white, fontSize: 15)),
          ],
        )
      ],
    );
  }
}
