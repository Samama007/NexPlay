import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          color: Colors.amber,
          height: double.infinity,
          width: double.infinity,
          // decoration: BoxDecoration(color: Colors.grey),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red,
                child: Text('data'),
              );
            },
          ),
        ),
      ),
    );
  }
}
