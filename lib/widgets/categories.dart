import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexplay/pages/categories_page.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
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
              SizedBox(height: 2),
              Text('Sports', style: TextStyle(color: Colors.white, fontSize: 17))
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
              SizedBox(height: 2),
              Text('Esports', style: TextStyle(color: Colors.white, fontSize: 17))
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
              SizedBox(height: 2),
              Text('Casino', style: TextStyle(color: Colors.white, fontSize: 17))
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
                    CupertinoIcons.car_detailed,
                    color: Colors.white,
                    size: 50,
                  )),
              SizedBox(height: 2),
              Text('Racing', style: TextStyle(color: Colors.white, fontSize: 17)),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              IconButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage()));
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 50,
                  )),
              SizedBox(height: 2),
              Text('More', style: TextStyle(color: Colors.white, fontSize: 17)),
            ],
          )
        ],
      ),
    );
  }
}
