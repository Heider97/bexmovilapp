import 'package:bexmovil/src/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//domain
import '../../../domain/models/client.dart';
import '../../../domain/models/router.dart';
import '../../../domain/models/filter.dart';
import '../../../domain/models/price.dart';
import '../../../domain/models/warehouse.dart';
import '../../../domain/models/product.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';
import '../../../services/query_loader.dart';
import '../../../services/styled_dialog_controller.dart';

part 'sale_event.dart';
part 'sale_state.dart';

final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final DatabaseRepository databaseRepository;
  final LocalStorageService storageService;
  final NavigationService navigationService;
  final QueryLoaderService queryLoaderService;
  final StyledDialogController styledDialogController;

  SaleBloc(this.databaseRepository, this.storageService, this.navigationService,
      this.queryLoaderService, this.styledDialogController)
      : super(const SaleState(status: SaleStatus.initial)) {
    on<LoadRouters>(_onLoadRouters);
    on<LoadClients>(_onLoadClients);
    on<SearchClient>(_onSearchClient);
    on<LoadWarehousesAndPrices>(_onLoadWarehousesAndPrices);
    on<SelectWarehouse>(_onSelectWarehouse);
    on<SelectPriceList>(_onSelectPrice);
    on<LoadProducts>(_onLoadProducts);
    on<SearchProduct>(_onSearchProduct);
    on<SelectProduct>(_onSelectProduct);
    on<GridModeChange>(_gridModeChange);
    on<LoadCart>(_onLoadCart);
    on<GetDetailsShippingCart>(_onGetDetailsShippingCart);
    on<GetProductsShippingCart>(_onGetProductsShippingCart);
    on<RemoveItemCart>(_removeItemCart);
  }

  Future<void> _removeItemCart(RemoveItemCart event, Emitter emit) async {
    await _databaseRepository.deleteProductAndUpdateCart(
        state.router!.dayRouter!,
        state.priceSelected!.codprecio!,
        state.warehouseSelected!.codbodega!,
        state.client!.id!.toString(),
        event.codProduct);

    add(GetDetailsShippingCart());
    add(GetProductsShippingCart());
  }

  Future<void> _onGetProductsShippingCart(
      GetProductsShippingCart event, Emitter emit) async {
    CartProductInfo cartProductInfo =
        await _databaseRepository.getCartProductInfo(
      state.router!.dayRouter!,
      state.client!.id.toString(),
      state.priceSelected!.codprecio!,
      state.warehouseSelected!.codbodega!,
    );

    emit(state.copyWith(cartProductInfo: cartProductInfo));
  }

  Future<void> _onGetDetailsShippingCart(
      GetDetailsShippingCart event, Emitter emit) async {
    int totalProductsQuantity =
        await _databaseRepository.getTotalProductQuantity(
            state.router!.dayRouter!,
            state.priceSelected!.codprecio!,
            state.warehouseSelected!.codbodega!,
            state.client!.id.toString());

    double totalPriceShippingCart =
        await _databaseRepository.getTotalProductValue(
            state.router!.dayRouter!,
            state.priceSelected!.codprecio!,
            state.warehouseSelected!.codbodega!,
            state.client!.id.toString());

    emit(state.copyWith(
        totalProductsShippingCart: totalProductsQuantity,
        totalPriceShippingCart: totalPriceShippingCart));
  }

  Future<void> _onLoadRouters(LoadRouters event, Emitter emit) async {
    var seller = storageService.getString('username');

    var routers = <Router>[];
    var historical = <Router>[];

    Map<String, dynamic> variables = await queryLoaderService
        .load('/sales-routers', 'SaleBloc', 'LoadRouters', seller!, []);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'routers') {
        routers = variables[keys[i]];
      } else if (keys[i] == 'historical') {
        historical = variables[keys[i]];
      }
    }

    emit(state.copyWith(
        status: SaleStatus.routers, routers: routers, historical: historical));
  }

  Future<void> _onLoadClients(LoadClients event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var seller = storageService.getString('username');
    var clients = <Client>[];

    Map<String, dynamic> variables = await queryLoaderService.load(
        '/sales-clients',
        'SaleBloc',
        'LoadClients',
        seller!,
        [event.router!.dayRouter, seller]);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'clients') {
        clients = variables[keys[i]];
      }
    }

    emit(state.copyWith(
        status: SaleStatus.clients, router: event.router, clients: clients));
  }

  Future<void> _onSearchClient(SearchClient event, Emitter emit) async {
    if (event.value == null || event.value == '') {
      emit(state.copyWith(
        status: SaleStatus.clients,
      ));
    } else {
      var clients = state.clients!.where((client) {
        return client.name!.toLowerCase().contains(event.value!) ||
            client.businessName!.toLowerCase().contains(event.value!);
      }).toList();

      emit(state.copyWith(status: SaleStatus.clients, clients: clients));
    }
  }

  Future<void> _onLoadWarehousesAndPrices(
      LoadWarehousesAndPrices event, Emitter emit) async {
    var seller = storageService.getString('username');

    var warehouses = <Warehouse>[];
    var prices = <Price>[];

    Map<String, dynamic> variables = await queryLoaderService.load(
        '/sale-warehouses-and-prices',
        'SaleBloc',
        'LoadWarehousesAndPrices',
        seller!,
        [event.codbodega, event.codprecio, event.client!.id]);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'warehouses') {
        warehouses = variables[keys[i]];
      } else if (keys[i] == 'prices') {
        prices = variables[keys[i]];
      }
    }

    // styledDialogController.closeVisibleDialog();

    emit(state.copyWith(
        status: SaleStatus.warehouses,
        client: event.client,
        warehouses: warehouses,
        prices: prices));

    // if (sections.first.widgets!.first.components!.first.results is Navigation &&
    //     event.navigation == 'go') {
    //   var navigation = sections.first.widgets!.first.components!.first.results;
    //   await navigationService.goTo(navigation.route!,
    //       arguments: navigation.argument);
    // } else if (sections.first.widgets!.first.components!.first.results
    //         is Navigation &&
    //     event.navigation == 'back') {
    //   add(LoadClients(event.codrouter));
    //   styledDialogController.closeVisibleDialog();
    // } else {
    //   List<Warehouse>? warehouses =
    //       sections.first.widgets!.first.components!.first.results;
    //   List<Price>? listPrices =
    //       sections[1].widgets!.first.components!.first.results;
    //
    //   emit(state.copyWith(
    //       status: SaleStatus.warehouses,
    //       selectedClient: event.client,
    //       warehouseList: warehouses,
    //       priceList: listPrices));
    // }
  }

  _onSelectWarehouse(SelectWarehouse event, Emitter emit) {
    emit(state.copyWith(warehouseSelected: event.warehouse));
  }

  _onSelectPrice(SelectPriceList event, Emitter emit) {
    emit(state.copyWith(priceSelected: event.listPriceSelected));
  }

  _gridModeChange(GridModeChange event, Emitter emit) {
    emit(state.copyWith(grid: event.grid));
  }

  Future<List<Product>> loadProductsPaginated(
      String codprecio, String codbodega, int offset, int limit) async {
    var seller = storageService.getString('username');
    var products = <Product>[];

    Map<String, dynamic> variables = await queryLoaderService.load(
        '/sale-products',
        'SaleBloc',
        'LoadProducts',
        seller!,
        [codprecio, codbodega, limit, offset]);

    List<String> keys = variables.keys.toList();

    for (var i = 0; i < variables.length; i++) {
      if (keys[i] == 'products') {
        products = variables[keys[i]];
      }
    }

    return products;
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter emit) async {
    emit(state.copyWith(status: SaleStatus.loading));

    var grids = [
      'normal',
      'photo',
      'brief',
    ];

    var grid = grids.first;

    emit(state.copyWith(status: SaleStatus.products, grids: grids, grid: grid));
  }

  Future<void> _onSearchProduct(SearchProduct event, Emitter emit) async {
    if (event.value == null || event.value == '') {
      emit(state.copyWith(
        status: SaleStatus.products,
      ));
    } else {
      var products = state.products!.where((product) {
        return product.nomProducto.toLowerCase().contains(event.value!) ||
            product.codProducto!.toLowerCase().contains(event.value!);
      }).toList();

      emit(state.copyWith(status: SaleStatus.products, products: products));
    }
  }

  Future<void> _onSelectProduct(SelectProduct event, Emitter emit) async {
    var totalProduct =
        event.product!.precioProductoPrecio! * event.product!.cant!;
    var total = state.total ?? 0 + totalProduct;
    var cant = state.cant ?? 0 + 1;
    emit(state.copyWith(status: SaleStatus.products, total: total, cant: cant));
  }

  Future<void> _onLoadCart(LoadCart event, Emitter emit) async {}
}
