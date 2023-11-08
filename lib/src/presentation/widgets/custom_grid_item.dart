import 'package:flutter/material.dart';

class CustomGridItem extends StatelessWidget {
  final String text;

  const CustomGridItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10)),
                elevation: 8,
                child: Text(text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}