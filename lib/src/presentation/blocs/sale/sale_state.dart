part of 'sale_bloc.dart';

enum SaleStatus {
  initial,
  loading,
  routers,
  clients,
  warehouses,
  products,
  failed
}

class SaleState {
  final SaleStatus status;
  final List<Router>? routers;
  final List<Router>? historical;
  final Router? router;
  final List<Client>? clients;
  final List<Client>? clientsFounded;
  final Client? client;
  final List<Filter>? filters;
  final List<Warehouse>? warehouses;
  final Warehouse? warehouseSelected;
  final List<Price>? prices;
  final Price? priceSelected;
  final List<Product>? products;
  final double? total;
  final int? cant;
  final List<String>? grids;
  final String? grid;
  final List<Product>? cart;
  final double? subtotal;
  final String? error;
  final int? totalProductsShippingCart;
  final double? totalPriceShippingCart;
  final CartProductInfo? cartProductInfo;

  const SaleState(
      {this.status = SaleStatus.initial,
      this.routers,
      this.historical,
      this.router,
      this.clients,
      this.clientsFounded,
      this.client,
      this.filters,
      this.warehouses,
      this.warehouseSelected,
      this.prices,
      this.priceSelected,
      this.products,
      this.total,
      this.cant,
      this.grids,
      this.grid,
      this.cart,
      this.subtotal,
      this.error,
      this.totalProductsShippingCart,
      this.totalPriceShippingCart,
      this.cartProductInfo});

  SaleState copyWith(
          {SaleStatus? status,
          List<Router>? routers,
          List<Router>? historical,
          Router? router,
          List<Client>? clients,
          Client? client,
          List<Client>? clientsFounded,
          List<Filter>? filters,
          List<Warehouse>? warehouses,
          Warehouse? warehouseSelected,
          List<Price>? prices,
          Price? priceSelected,
          List<Product>? products,
          List<Map<String, Product>>? product,
          double? total,
          int? cant,
          List<String>? grids,
          String? grid,
          List<Product>? cart,
          double? subtotal,
          String? error,
          int? totalProductsShippingCart,
          double? totalPriceShippingCart,
          CartProductInfo? cartProductInfo}) =>
      SaleState(
          status: status ?? this.status,
          routers: routers ?? this.routers,
          historical: historical ?? this.historical,
          router: router ?? this.router,
          clients: clients ?? this.clients,
          clientsFounded: clientsFounded ?? this.clientsFounded,
          client: client ?? this.client,
          filters: filters ?? this.filters,
          warehouses: warehouses ?? this.warehouses,
          warehouseSelected: warehouseSelected ?? this.warehouseSelected,
          prices: prices ?? this.prices,
          priceSelected: priceSelected ?? this.priceSelected,
          products: products ?? this.products,
          total: total ?? this.total,
          cant: cant ?? this.cant,
          grids: grids ?? this.grids,
          grid: grid ?? this.grid,
          cart: cart ?? this.cart,
          subtotal: subtotal ?? this.subtotal,
          error: error ?? this.error,
          totalProductsShippingCart:
              totalProductsShippingCart ?? this.totalProductsShippingCart,
          totalPriceShippingCart:
              totalPriceShippingCart ?? this.totalPriceShippingCart,
          cartProductInfo: cartProductInfo ?? this.cartProductInfo);

  List<Object?> get props => [status, error];
}
