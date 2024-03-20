import 'package:flutter/material.dart';
//widgets
import '../../../widgets/atoms/app_back_button.dart';

class ProspectScheduleView extends StatefulWidget {
  const ProspectScheduleView({super.key});

  @override
  State<ProspectScheduleView> createState() => _ProspectScheduleViewState();
}

class _ProspectScheduleViewState extends State<ProspectScheduleView>
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
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [AppBackButton(needPrimary: true)],
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: theme.disabledColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Nombre del cliente',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Cargo u ocupacion del cliente'),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50.0,
                  width: size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/zonas.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const Text(
                                  'Zonas',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/rutero.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const Text(
                                  'Rutero',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/no_visitado.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const Text(
                                  'No visitado',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/pqrs.png',
                                  width: 30,
                                  height: 30,
                                ),
                                const Text(
                                  'PQRS',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 380,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TabBar(controller: _tabcontroller, tabs: const [
                        SizedBox(
                          width: 200,
                          child: Tab(
                            text: 'Informacion',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Tab(
                            text: 'Estadistica',
                          ),
                        )
                      ]),
                      Expanded(
                          child: TabBarView(
                              controller: _tabcontroller,
                              children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Informacion Basica',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Nombre'),
                                        Text('Nombre del cliente')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Telefono'),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text('3007239603'))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Informacion de encuentro',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Jueves, Oct 19 2023'),
                                        Text('3:00 AM')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Jueves, Oct 19 2023'),
                                        Text('4:00 AM')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Direccion',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [Text('Calle 40 Sur 25F-12')],
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
                          ]))
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
