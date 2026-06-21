import 'dart:convert';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  // Changed return type to Future<UserModel>
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.backendUri}/auth/signup'),
        headers: {
          'Content-Type': 'application/json', // fixed typo
        },
        body: jsonEncode({
          // send the user data
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode != 201) {
        // Decode error message from response
        final errorJson = jsonDecode(response.body);
        throw Exception(errorJson['msg'] ?? 'Signup failed');
      }

      // Parse the JSON response
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return UserModel.fromJson(jsonMap);
    } catch (e) {
      // Re-throw or handle appropriately
      throw Exception('Signup error: $e');
    }
  }

  // Future<void> login() { ... }  // adjust similarly
}
