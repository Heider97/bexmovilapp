import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

//domain
import '../../../domain/models/category.dart';
import '../../../domain/repositories/database_repository.dart';

//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

part 'category_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CategoryCubit extends Cubit<CategoryState> {
  final DatabaseRepository _databaseRepository;

  CategoryCubit(this._databaseRepository) : super(const CategoryLoading());

  Future<void> init(int categoryId) async {
    final category = await _databaseRepository.getCategoryWithProducts(categoryId);
    emit(CategorySuccess(category: category));
  }

  void back() => _navigationService.goBack();

}
