import 'package:dio/dio.dart';
import '../models/category_model.dart';

/// Repository class responsible forr making the network calls
class CategoryRepository {
  final Dio _dio = Dio(); // Add interceptor for customization or better functionality

  /// Method to Fetch the Categories
  Future<CategoryResponse> fetchCategories() async {
    try {
      final response = await _dio.get('https://api.mocklets.com/p6839/explore-cred');
      return CategoryResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }
}
