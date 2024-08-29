import 'package:flutter/material.dart';
import 'package:nexplay/authentication%20pages/login_page.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                  onPressed: () {
                    print('object');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginPage(),
                    //     ));
                  },
                  icon: Icon(
                    Icons.sports_cricket_rounded,
                    color: Colors.white,
                    size: 50,
                    semanticLabel: 'Sportssdssad',
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
                    semanticLabel: 'Esports',
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
                    semanticLabel: 'Casino',
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
                    semanticLabel: 'Olympics',
                  )),
              Text('More', style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }
}
