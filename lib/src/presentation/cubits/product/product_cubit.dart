import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';


//domain
import '../../../domain/models/product.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

part 'product_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductCubit extends Cubit<ProductState> {
  final DatabaseRepository _databaseRepository;

  ProductCubit(this._databaseRepository) : super(const ProductLoading());

  Future<void> init(int productId) async {
    final product = await _databaseRepository.getProduct(productId);
    emit(ProductSuccess(product: product));
  }

  void back() => _navigationService.goBack();


}
