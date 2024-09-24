import 'package:auto_route/auto_route.dart';
import 'package:broyalty_app/features/presenter/constant/color.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: ListView.builder(
        itemCount: 5, // Number of containers to display
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.analogMainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Favorite Image ${index + 1}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
