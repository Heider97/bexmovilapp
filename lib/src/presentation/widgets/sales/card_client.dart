// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../utils/constants/gaps.dart';
import '../../views/user/sale/widgets/detail_client.dart';

class CardClientRouter extends StatefulWidget {
  String nit;
  String nameClient;
  String branchClient;
  String addressClient;
  String razClient;
  String quotaClient;
  String priceClient;
  String paymentMethodClient;

  CardClientRouter({
    super.key,
    required this.nit,
    required this.nameClient,
    required this.branchClient,
    required this.addressClient,
    required this.razClient,
    required this.quotaClient,
    required this.priceClient,
    required this.paymentMethodClient,
  });

  @override
  State<CardClientRouter> createState() => _CardClientRouterState();
}

class _CardClientRouterState extends State<CardClientRouter> {
  void _openDetailsClient() {
    showModalBottomSheet(
        context: (context),
        builder: (ctx) => DetailClientSale(
              nameClient: widget.nameClient,
              addressClient: widget.addressClient,
              branchClient: widget.branchClient,
              nit: widget.nit,
              razClient: widget.razClient,
              quotaClient: widget.quotaClient,
              priceClient: widget.priceClient,
              paymentMethodClient: widget.paymentMethodClient,

            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.nit);
        _openDetailsClient();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Container(
            width: double.infinity,
            height: 110,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.nameClient,
                            style: const TextStyle(
                                color: Colors.orange, fontSize: 13)),
                        gapH4,
                        Text(
                          "Nit: ${widget.nit}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        Text(
                          "SUC: ${widget.branchClient}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        Text(
                          "Dirección: ${widget.addressClient}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
