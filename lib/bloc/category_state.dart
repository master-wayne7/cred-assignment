// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoryResponse categoryResponse;
  CategoryLoaded(this.categoryResponse);
}

class CategoryError extends CategoryState {}
