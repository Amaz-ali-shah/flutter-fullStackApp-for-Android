// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/core/constants/utils.dart';
// import 'package:frontend/features/home/repository/task_remote_repository.dart';
// import 'package:frontend/models/task_model.dart';
// part 'add_new_task_state.dart';

// class AddNewTaskCubit extends Cubit<AddNewTaskState>{
//   AddNewTaskCubit():super(AddNewTaskInitial());

//   final taskRemoteRepository = TaskRemoteRepository();

//   Future<void> createNewTask({

//     required this.id,
//     required this.uid,
//     required this.title,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.dueAt,
//     required this.color,
//     required this.isSynced,
//   })  async {
//     try{
//       emit(AddNewTaskLoading());
//       final  taskModel = await taskRemoteRepository.createTask(
//         title: title,
//         description: description,
//         hexColor: rgbToHex(color), 
//         token: token, 
//         dueAt: dueAt
//       );
//       emit(AddNewTaskSuccess(taskModel));

//     }
//     catch(e) {
//       emit(AddNewTaskError(e.toString()));

//     }
//   }

//  }
import 'dart:ui';  // for Color class
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';
import 'package:frontend/models/task_model.dart';
part 'add_new_task_state.dart';


class AddNewTaskCubit extends Cubit<AddNewTaskState> {
  AddNewTaskCubit() : super(AddNewTaskInitial());

  final taskRemoteRepository = TaskRemoteRepository();

  Future<void> createNewTask({
    required String title,
    required String description,
    required Color color,
    required DateTime dueAt,
    required String token,
  }) async {
    try {
      emit(AddNewTaskLoading());
      final taskModel = await taskRemoteRepository.createTask(
        title: title,
        description: description,
        hexColor: rgbToHex(color),
        token: token,
        dueAt: dueAt,
      );
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(AddNewTaskError(e.toString()));
    }
  }
}