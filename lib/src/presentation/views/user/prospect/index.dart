// ignore_for_file: must_be_immutable

import 'package:bexmovil/src/presentation/widgets/global/custom_check_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_close_cutton.dart';
import 'package:flutter/material.dart';

class ProspectSheduleView extends StatefulWidget {
  ProspectSheduleView({super.key});

  @override
  State<ProspectSheduleView> createState() => _ProspectSheduleViewState();
}

class _ProspectSheduleViewState extends State<ProspectSheduleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    _tabcontroller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [CustomCloseButton(), CustomCheckButton()],
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Nombre del cliente',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Cargo u ocupacion del cliente'),
                SizedBox(height: 20),
                Container(
                  height: 50.0,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              return Container(
                                width: 130,
                                height: 190,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const Icon(
                                  Icons.star,
                                  size: 30,
                                ),
                              );
                            })),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 280,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabcontroller, 
                        tabs: const [
                          Tab(
                            text: 'Informacion',
                          ),
                          Tab(
                            text: 'Estadistica',
                          )
                        ]
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabcontroller,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [ 
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text('Informacion Basica', style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text('Nombre'),
                                        Text('Nombre del cliente')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text('Telefono'),
                                        Text('3007239603')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text('Informacion de encuentro', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Jueves, Oct 19 2023'),
                                        Text('3:00 AM')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Jueves, Oct 19 2023'),
                                        Text('4:00 AM')
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text('Direccion', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Calle 40 Sur 25F-12')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('Medellin, El poblado, 70015')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: Text('Estadistica'),
                            )
                          ]
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
