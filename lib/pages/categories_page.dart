import 'package:flutter/material.dart';
import 'package:nexplay/models/my_categories_model.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/pages/cat_details.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<CategoriesModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = GameApi().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(children: [
          FutureBuilder<List<CategoriesModel>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load categories'));
              } else {
                var categories = snapshot.data!.first.results;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 2,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CatDetails(id: category.id),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                category.imageBackground,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                color: Colors.black.withOpacity(0.5),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                            Center(
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          Positioned(
            top: 30,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white38)),
            ),
          ),
        ]),
      ),
    );
  }
}
