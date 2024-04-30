
import 'package:bexmovil/src/domain/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

part 'product_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductLoading());

  void back() => _navigationService.goBack();
}
