// import 'package:flutter/material.dart';
// import 'package:nexplay/api/api_service.dart';

// class MyCarousel extends StatefulWidget {
//   const MyCarousel({super.key});

//   @override
//   State<MyCarousel> createState() => _MyCarouselState();
// }

// class _MyCarouselState extends State<MyCarousel> {
//   List<Widget> games = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadGames();
//   }

//   Future<void> _loadGames() async {
//     try {
//       final gamesData = await GameApi.fetchGames();
//       setState(() {
//         games = gamesData.map((game) {
//           return Card(
//             margin: const EdgeInsets.all(10),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(15),
//                   child: Image.network(
//                     game['background_image'],
//                     width: double.infinity,
//                     height: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Text(
//                     game['name'],
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }).toList();
//       });
//     } catch (e) {
//       throw Exception('Caught Exception: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return games.isEmpty
//         ? const Center(child: CircularProgressIndicator(
//           color: Colors.red,
//         ))
//         : Center(
//             child: InkWell(
//               // onTap: () => ,
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxHeight: 200),
//                 child: CarouselView(
//                   itemExtent: 350,
//                   shrinkExtent: 10,
//                   children: games,
//                 ),
//               ),
//             ),
//           );
//   }


// }
