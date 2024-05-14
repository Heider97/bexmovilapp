import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

//domain
import '../../../domain/repositories/database_repository.dart';

//service
import '../../../locator.dart';
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'productivity_state.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();

class ProductivityCubit extends Cubit<ProductivityState> {
  final DatabaseRepository _databaseRepository;

  ProductivityCubit(this._databaseRepository) : super(const ProductivityLoading());

  Future<void> init() async {
    emit(const ProductivitySuccess());
  }

  void dispose() {
    emit(const ProductivityLoading());
  }

  void back() => _navigationService.goBack();

}