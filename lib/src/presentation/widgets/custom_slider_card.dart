import 'package:flutter/material.dart';

class CustomSliderCard extends StatelessWidget {
  final String text;
  final double value;
  final AssetImage image;
  final double value2;
  final String text2;
  final String value3;
  final String simbol;
  final String text4;
  final double value4;
  final double value5;
  final double value6;
  final VoidCallback onPressed;

  const CustomSliderCard({
    super.key,
    required this.onPressed, 
    required this.text, 
    required this.value, 
    required this.image, 
    required this.value2, 
    required this.text2, 
    required this.value3, 
    required this.simbol, 
    required this.text4, 
    required this.value4, 
    required this.value5, 
    required this.value6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 250,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                value.toString(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                height: 40,
                                child: Image.asset(
                                  'assets/arrow.jpg',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                value2.toString(),
                                style: TextStyle(
                                    color: Colors.red.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  text2,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(value3),
                                Text(
                                  simbol,
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(value4.toString())
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 10,
                            color: Colors.black,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  text4,
                                ),
                                const SizedBox(
                                  width: 60,
                                ),
                                Text(value5.toString()),
                                Text(
                                  simbol,
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text(value6.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
