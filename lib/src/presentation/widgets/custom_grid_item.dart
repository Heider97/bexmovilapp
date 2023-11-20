import 'package:flutter/material.dart';

class CustomGridItem extends StatelessWidget {
  final String text;

  const CustomGridItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(Icons.alarm, size: 50,),
                    SizedBox(height: 40,),
                    Text(text),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}