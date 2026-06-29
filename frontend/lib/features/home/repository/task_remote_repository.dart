// import 'dart:convert';
// import 'package:frontend/core/constants/constants.dart';
// import 'package:frontend/models/task_model.dart';
// import 'package:http/http.dart' as http;

// class TaskRemoteRepository {
//   Future<TaskModel> createTask({
//     required String title,
//     required String description,
//     required String hexColor,
//     required String token,
//     required DateTime dueAt,
//   }) async {
//     try {
//       final res = await http.post(
//         Uri.parse("${Constants.backendUri}/tasks"),
//         headers: {'Content-Type': 'application/json', 'X-Authorization': token},
//         body: jsonEncode({
//           'title': title,
//           'description': description,
//           'hexColor': hexColor,
//           'dueAt': dueAt.toIso8601String(),
//         }),
//       );

//       if (res.statusCode != 201) {
//         throw jsonDecode(res.body)['error'];
//       }

//       final decoded = jsonDecode(res.body);

//        // If backend returns [...], unwrap it
//       final taskMap = decoded is List
//       ? decoded[0] as Map<String, dynamic>
//       : decoded as Map<String, dynamic>;

//       return TaskModel.fromJson(taskMap);

//       // return TaskModel.fromJson(res.body);
//     } catch (e) {
//       rethrow; // fine, though this does nothing extra – you could remove the catch entirely
//     }
//   }
// }
import 'dart:convert';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteRepository {
  Future<TaskModel> createTask({
    required String title,
    required String description,
    required String hexColor,
    required String token,
    required DateTime dueAt,
  }) async {
    final res = await http.post(
      Uri.parse("${Constants.backendUri}/tasks"),
      headers: {'Content-Type': 'application/json', 'X-Authorization': token},
      body: jsonEncode({
        'title': title,
        'description': description,
        'hexColor': hexColor,
        'dueAt': dueAt.toIso8601String(),
      }),
    );

    if (res.statusCode != 201) {
      throw jsonDecode(res.body)['error'];
    }

    // ✅ Decode first, then unwrap List if backend returns [{ ... }]
    final decoded = jsonDecode(res.body);
    final taskMap = decoded is List
        ? decoded[0] as Map<String, dynamic>
        : decoded as Map<String, dynamic>;

    return TaskModel.fromJson(taskMap);
  }   



  Future<List<TaskModel>> getTasks({
    
    required String token,
   
  }) async {
    final res = await http.get(
      Uri.parse("${Constants.backendUri}/tasks"),
      headers: {'Content-Type': 'application/json', 'X-Authorization': token},
      
    );

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['error'];
    }

    final listOfTasks = jsonDecode(res.body);
    List<TaskModel> tasksList= [];

    for (var elem in listOfTasks){
      tasksList.add(TaskModel.fromMap(elem));
    }

    return tasksList;
  }
}
