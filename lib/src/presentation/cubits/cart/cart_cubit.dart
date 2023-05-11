import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';


//domain
import '../../../domain/models/product.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

part 'cart_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CartCubit extends Cubit<CartState> {
  final DatabaseRepository _databaseRepository;

  CartCubit(this._databaseRepository) : super(const CartLoading());

  Future<void> init(int productId) async {
    final products = await _databaseRepository.getAllProducts();
    emit(CartSuccess(products: products));
  }

  void back() => _navigationService.goBack();


}
