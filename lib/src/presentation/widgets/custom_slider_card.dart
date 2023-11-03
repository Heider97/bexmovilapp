import 'package:flutter/material.dart';

class CustomSliderCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomSliderCard({
    super.key,
    required this.title,
    required this.onPressed,
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
                  return GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      width: 250,
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Ventas',
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
                                const Text(
                                  '9',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
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
                                  '-5.2%',
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Ventas pendientes',
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text('6'),
                                Text(
                                  '-',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('10%')
                              ],
                            ),
                            const Divider(color: Colors.black),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Ventas totales',
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('9 - 21%')
                              ],
                            )
                          ],
                        ),
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

class SliderCard2 extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  const SliderCard2({super.key, required this.title, required this.onPressed});

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
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Prospectos',
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
                              const Text(
                                '80',
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
                                '-5.2%',
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
                          
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  'Prospectos Creados',
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text('6'),
                              Text(
                                '-',
                                style: TextStyle(color: Colors.red),
                              ),
                              Text('10%')
                            ],
                          ),

                          const Divider(
                            indent: 15,
                            color: Colors.black,
                            endIndent: 15,
                          ),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  'Prospectos Visitados',
                                ),
                              ),
                              SizedBox(width: 10,),
                                Text('6'),
                                Text(
                                  '-',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Text('10%')
                            ],
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

Widget _textItemsCard({
  required String text,
}) {
  return Text(text);
  // return ListTile(
  //   title: Row(
  //     children: <Widget>[
  //       Icon(icon),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),
  //         child: Text(text),
  //       )
  //     ],
  //   ),
  //   onTap: onTap,
  // );
}
