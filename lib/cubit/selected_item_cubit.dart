import 'package:cred/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedItemCubit extends Cubit<Item?> {
  /// Cubit to change the selected Item
  SelectedItemCubit() : super(null);

  void selectItem(Item item) => emit(item);
}
