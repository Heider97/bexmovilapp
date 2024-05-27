import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

//services
import '../../../services/storage.dart';
import '../../../services/navigation.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  final LocalStorageService storageService;
  final NavigationService navigationService;

  IndexCubit(this.storageService, this.navigationService) : super(const IndexInitial());


}
