import 'package:cred/models/category_model.dart';
import 'package:cred/repositories/category_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  /// repository for managing the network calls
  final CategoryRepository repository;

  /// Bloc for managing the state of the category data
  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<LoadCategories>(onLoadCategories);
  }

  /// Function to be executed on the load category event
  void onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoading());
      final categories = await repository.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError());
    }
  }
}
