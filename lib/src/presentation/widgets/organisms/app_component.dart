import 'package:flutter/material.dart';
//domain
import '../../../domain/models/component.dart';
//widgets
import '../../views/user/sale/features/prices.dart';
import '../../views/user/sale/features/products.dart';
import '../../views/user/wallet/features/clients.dart';
import '../../views/user/wallet/features/summaries.dart';
import '../molecules/app_text_block.dart';

//home
import '../../views/user/home/features/features.dart';
import '../../views/user/home/features/statistics.dart';
import '../../views/user/home/features/applications.dart';
//sale
import '../../views/user/sale/features/routers.dart';
import '../../views/user/sale/features/clients.dart';
//wallet
import '../../views/user/wallet/features/dashboard.dart';

enum ComponentTypes { kpi, feature, line, pie, list }

/// A customizable form widget.
///
/// The [AppComponent] widget displays a form with an optional title and description,
/// a list of form items, and a form button. The form items are displayed with
/// their associated labels.
///
/// See also:
///
/// * [AppTextBlock], which is used to display the title and description.
class AppWidget extends StatefulWidget {
  /// Creates a customizable form widget.
  ///
  /// The [components], [type], [name]
  /// null.
  const AppWidget(
      {super.key,
      required this.name,
      required this.type,
      required this.components,
      this.tabController});

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final String name;
  final String type;

  /// The list of form items to display in the form.
  ///
  /// Must not be null.
  final List<Component> components;

  final TabController? tabController;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    switch (widget.name) {
      case 'HomeFeatures':
      // return HomeFeatures(features: widget.components.first.results);
      case 'HomeStatistics':
      // if (widget.components.isNotEmpty) {
      //   var kpis = widget.components
      //       .map((e) => e.type == "kpi" ? e : null)
      //       .toList(growable: true);
      //   var forms = widget.components
      //       .map((e) => e.type == "form" ? e : null)
      //       .toList(growable: true);
      //
      //   return HomeStatistics(
      //       kpis: kpis, forms: forms, tabController: widget.tabController!);
      // } else {
      //   return HomeStatistics(
      //       kpis: const [],
      //       forms: const [],
      //       tabController: widget.tabController!);
      // }
      case 'HomeApplications':
      // return HomeApplications(applications: widget.components.first.results);
      case 'SaleRouters':
      //return SaleRouters(routers: widget.components.first.results);
      case 'SaleClients':
      // return SaleClients(clients: widget.components.first.results);
      case 'SaleWarehouses':
      // return SaleWarehouses(warehouses: widget.components.first.results);
      case 'SalePrices':
        return SalePrices(prices: widget.components.first.results);
      case 'SaleProducts':
      // return SaleProducts(products: widget.components.first.results);
      case 'WalletHome':
      // return WalletDashboard(components: widget.components);
      case 'WalletClients':
        return WalletClients(clients: widget.components.first.results);
      case 'WalletSummaries':
        return WalletSummaries(invoices: widget.components.first.results);
      default:
        return const SizedBox();
    }
  }
}
