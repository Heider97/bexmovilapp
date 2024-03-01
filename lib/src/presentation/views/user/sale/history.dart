import 'package:bexmovil/src/presentation/views/user/sale/details.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_history_sale.dart';
import 'package:bexmovil/src/presentation/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/gaps.dart';

import '../../../widgets/user/custom_search_bar.dart';

class HistorySale extends StatefulWidget {
  const HistorySale({super.key});

  @override
  State<HistorySale> createState() => _HistorySaleState();
}

class _HistorySaleState extends State<HistorySale> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14);
    return Scaffold(
      drawer: DrawerWidget(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 30, right: 20, left: 20, top: 48),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => '',
                      child: Container(
                        padding: const EdgeInsets.all(12), // Border width
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 119, 24),
                            borderRadius: borderRadius),
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: Colors.white, size: 18),
                        ),
                      )),
                  gapH16,
                  Builder(builder: (context) {
                    return GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          padding: const EdgeInsets.all(2), // Border width
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 119, 24),
                              borderRadius: borderRadius),
                          child: ClipRRect(
                            borderRadius: borderRadius,
                            child: const Icon(Icons.list,
                                color: Colors.white, size: 35),
                          ),
                        ));
                  })
                ],
              ),
              gapH20,
              Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text("Historial De Ventas: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 260,
                    height: 50,
                    child: CustomSearchBar(
                        controller: searchController,
                        hintText: 'Código de venta'),
                  ),
                  GestureDetector(
                      onTap: () => '',
                      child: Container(
                        padding: const EdgeInsets.all(10), // Border width
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 119, 24),
                            borderRadius: borderRadius),
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: const Icon(Icons.filter_alt_outlined,
                              color: Colors.white, size: 20),
                        ),
                      )),
                  GestureDetector(
                      onTap: () => '',
                      child: Container(
                        padding: const EdgeInsets.all(10), // Border width
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 243, 119, 24),
                            borderRadius: borderRadius),
                        child: ClipRRect(
                          borderRadius: borderRadius,
                          child: const Icon(Icons.window,
                              color: Colors.white, size: 20),
                        ),
                      ))
                ],
              ),
              gapH16,
              SizedBox(
                height: 550,
                width: 500,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: CardSale(
                                    state: "Exitoso",
                                    client: "Pandapan",
                                    codeSale: "Q098788E",
                                    eventCard: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsSale(
                                                  dataSales: [],
                                                ))),
                                    totalValue: 9009209.09,
                                    date: "20/12/2023")),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
