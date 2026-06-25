// // // import 'dart:convert';
// // // import 'package:frontend/core/constants/constants.dart';
// // // import 'package:frontend/models/user_model.dart';
// // // import 'package:http/http.dart' as http;

// // // class AuthRemoteRepository {
// // //   // Changed return type to Future<UserModel>
// // //   Future<UserModel> signUp({
// // //     required String name,
// // //     required String email,
// // //     required String password,
// // //   }) async {
// // //     try {
// // //       final response = await http.post(
// // //         Uri.parse('${Constants.backendUri}/auth/signup'),
// // //         headers: {
// // //           'Content-Type': 'application/json', // fixed typo
// // //         },
// // //         body: jsonEncode({
// // //           // send the user data
// // //           'name': name,
// // //           'email': email,
// // //           'password': password,
// // //         }),
// // //       );

// // //       if (response.statusCode != 201) {
// // //         // Decode error message from response
// // //         final errorJson = jsonDecode(response.body);
// // //         throw Exception(errorJson['msg'] ?? 'Signup failed');
// // //       }

// // //       factory UserModel.fromJson(Map<String, dynamic> json) {
// // //   return UserModel(
// // //     id: json['id'] as String,
// // //     email: json['email'] as String,
// // //     name: json['name'] as String,
// // //     token: json['token'] as String?,
// // //     // ✅ handle both snake_case and camelCase
// // //     createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
// // //     updatedAt: DateTime.parse((json['updatedAt'] ?? json['updated_at']) as String),
// // //   );
// // // }

// // //       // Parse the JSON response
// // //       // final Map<String, dynamic> jsonMap = jsonDecode(response.body);
// // //       // return UserModel.fromJson(jsonMap);
// // //     } catch (e) {
// // //       // Re-throw or handle appropriately
// // //       throw Exception('Signup error: $e');
// // //     }
// // //   }

// // //   // Future<void> login() { ... }  // adjust similarly
// // // }

// // import 'dart:convert';
// // import 'package:frontend/core/constants/constants.dart';
// // import 'package:frontend/models/user_model.dart';
// // import 'package:http/http.dart' as http;

// // class AuthRemoteRepository {
// //   Future<UserModel> signUp({
// //     required String name,
// //     required String email,
// //     required String password,
// //   }) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse('${Constants.backendUri}/auth/signup'),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'name': name, 'email': email, 'password': password}),
// //       );

// //       if (response.statusCode != 201) {
// //         final errorJson = jsonDecode(response.body);
// //         throw Exception(errorJson['msg'] ?? 'Signup failed');
// //       }

// //       // Parse the JSON response
// //       final Map<String, dynamic> jsonMap = jsonDecode(response.body);
// //       return UserModel.fromJson(jsonMap);
// //     } catch (e) {
// //       throw Exception('Signup error: $e');
// //     }
// //   }

// //   Future<UserModel> login({
// //     required String email,
// //     required String password,
// //   }) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse('${Constants.backendUri}/auth/login'),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'email': email, 'password': password}),
// //       );

// //       if (response.statusCode != 200) {
// //         print('Error response: ${response.body}');
// //         final errorJson = jsonDecode(response.body);
// //         throw Exception(errorJson['msg'] ?? 'Login failed');
// //       }

// //       // Parse the JSON response
// //       final Map<String, dynamic> jsonMap = jsonDecode(response.body);
// //       return UserModel.fromJson(jsonMap);
// //     } catch (e) {
// //       throw Exception('Login error: $e');
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:frontend/core/constants/constants.dart';
// import 'package:frontend/core/services/sp_services.dart';
// import 'package:frontend/models/user_model.dart';
// import 'package:http/http.dart' as http;

// class AuthRemoteRepository {
//   // Helper to extract error message from response
//   final spService = SpService();
//   final authRemoteRepository = AuthRemoteRepository();

//   String _getErrorMessage(Map<String, dynamic> json, String fallback) {
//     return json['detail'] ??
//         json['message'] ??
//         json['msg'] ??
//         json['error'] ??
//         fallback;
//   }

//   Future<UserModel> signUp({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${Constants.backendUri}/auth/signup'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'name': name, 'email': email, 'password': password}),
//       );

//       print('Signup response [${response.statusCode}]: ${response.body}');

//       if (response.statusCode != 201) {
//         final errorJson = jsonDecode(response.body);
//         throw Exception(_getErrorMessage(errorJson, 'Signup failed'));
//       }

//       final Map<String, dynamic> jsonMap = jsonDecode(response.body);
//       return UserModel.fromJson(jsonMap);
//     } on Exception {
//       rethrow; // don't wrap already-thrown exceptions
//     } catch (e) {
//       throw Exception('Signup error: $e');
//     }
//   }

//   Future<UserModel> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${Constants.backendUri}/auth/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       print('Login response [${response.statusCode}]: ${response.body}');

//       if (response.statusCode != 200) {
//         final errorJson = jsonDecode(response.body);
//         throw Exception(_getErrorMessage(errorJson, 'Login failed'));
//       }

//       final Map<String, dynamic> jsonMap = jsonDecode(response.body);
//       return UserModel.fromJson(jsonMap);
//     } on Exception {
//       rethrow; // don't wrap already-thrown exceptions
//     } catch (e) {
//       throw Exception('Login error: $e');
//     }
//   }

//   Future<UserModel?> getUserData() async {
//     try {
//       final token = await spService.getToken();
//       print(token);
//       if (token == null) {
//         //throw 'No token found!';
//         return null;
//       }

//       final res = await http.post(
//         Uri.parse('${Constants.backendUri}/auth/tokenIsValid'),
//         headers: {'Content-Type': 'application/json', 'X-Authorization': token},
//       );
//       print(res);
//       if (res.statusCode != 200 || jsonDecode(res.body) == false) {
//         return null;
//       }

//       final userResponse = await http.get(
//         Uri.parse('${Constants.backendUri}/auth'),
//         headers: {'Content-Type': 'application/json', 'X-Authorization': token},
//       );
//       print(userResponse.body);
//       if (userResponse.statusCode != 200) {
//         throw jsonDecode(userResponse.body)['error'];
//       }

//       final Map<String, dynamic> jsonMap = jsonDecode(
//         userResponse.body,
//       ); // ✅ fixed: was res.body
//       return UserModel.fromJson(jsonMap);
//     } catch (e) {
//       final user = await authRemoteRepository.getUserData();
//       return user;
//     }
//   }
// }
import 'dart:convert';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/services/sp_services.dart';
import 'package:frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  final spService = SpService();

  // ✅ REMOVED: final authRemoteRepository = AuthRemoteRepository();

  String _getErrorMessage(Map<String, dynamic> json, String fallback) {
    return json['detail'] ??
        json['message'] ??
        json['msg'] ??
        json['error'] ??
        fallback;
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.backendUri}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      print('Signup response [${response.statusCode}]: ${response.body}');
      if (response.statusCode != 201) {
        final errorJson = jsonDecode(response.body);
        throw Exception(_getErrorMessage(errorJson, 'Signup failed'));
      }
      return UserModel.fromJson(jsonDecode(response.body));
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception('Signup error: $e');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.backendUri}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('Login response [${response.statusCode}]: ${response.body}');
      if (response.statusCode != 200) {
        final errorJson = jsonDecode(response.body);
        throw Exception(_getErrorMessage(errorJson, 'Login failed'));
      }
      return UserModel.fromJson(jsonDecode(response.body));
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      final token = await spService.getToken();
      print(token);
      if (token == null) return null;

      final res = await http.post(
        Uri.parse('${Constants.backendUri}/auth/tokenIsValid'),
        headers: {'Content-Type': 'application/json', 'X-Authorization': token},
      );
      if (res.statusCode != 200 || jsonDecode(res.body) == false) return null;

      final userResponse = await http.get(
        Uri.parse('${Constants.backendUri}/auth'),
        headers: {'Content-Type': 'application/json', 'X-Authorization': token},
      );
      if (userResponse.statusCode != 200) {
        throw Exception(jsonDecode(userResponse.body)['error']);
      }
      return UserModel.fromJson(jsonDecode(userResponse.body));
    } catch (e) {
      // ✅ REMOVED recursive call — just log and return null
      print('getUserData error: $e');
      return null;
    }
  }
}
