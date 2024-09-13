import 'package:flutter/material.dart';
import 'package:nexplay/bin/pagination_api.dart';
import 'package:nexplay/bin/pagination_model.dart';

class Eg extends StatefulWidget {
  const Eg({super.key});

  @override
  State<Eg> createState() => _EgState();
}

class _EgState extends State<Eg> {
  List<GameEg> games = [];
  int pageNumber = 1;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _populategames(pageNumber);

    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
          pageNumber++;
          // print(pageNumber);
          _populategames(pageNumber);
        } 
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _populategames(int pageNumber) async {
    List<GameEg> data = await EgApi().fetchgames(pageNumber);
    setState(() {
      games.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.blue
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: games.length + 1,
            itemBuilder: (context, index) {
              if (index < games.length) {
                var game = games[index];
                return Card(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(game.name),
                    subtitle: Text(game.stores.first.id.toString()),
                    leading: Image.network(game.backgroundImage, fit: BoxFit.scaleDown),
                    trailing: Text(game.id.toString()),
                  ),
                );
              } else {
                return Padding(padding: EdgeInsets.symmetric(vertical: 32), child: Center(child: CircularProgressIndicator()));
              }
            }),
      ),
    );
  }
}



// future_builder{
//           // child: FutureBuilder<List<GameEg>>(
//         //   future: EgApi().fetchgames(),
//         //   builder: (context, snapshot) {
//         //     if (snapshot.connectionState == ConnectionState.waiting) {
//         //       return Center(child: CircularProgressIndicator());
//         //     } else if (snapshot.hasError) {
//         //       return Center(child: Text('Error: ${snapshot.error}'));
//         //     } else {
//         //       return ListView.builder(
//         //         itemCount: snapshot.data!.length,
//         //         itemBuilder: (context, index) {
//         //           return Card(
//         //             color: Colors.transparent,
//         //             child: ListTile(
                      // title: Text(snapshot.data![index].name),
                      // subtitle: Text(snapshot.data![index].stores.first.id.toString()),
                      // leading: Image.network(snapshot.data![index].backgroundImage),
                      // trailing: Text(snapshot.data![index].id.toString()),
//         //             ),
//         //           );
//         //         },
//         //       );
//         //     }
//         //   },
//         // ),
// }