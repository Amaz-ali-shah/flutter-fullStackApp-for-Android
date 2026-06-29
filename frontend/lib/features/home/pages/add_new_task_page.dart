// import 'package:flex_color_picker/flex_color_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/cubit/auth_cubit.dart';
// import 'package:frontend/features/home/cubit/add_new_task_cubit.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AddNewTaskPage extends StatefulWidget {
//   static MaterialPageRoute route() =>
//       MaterialPageRoute(builder: (context) => const AddNewTaskPage());

//   const AddNewTaskPage({super.key});

//   @override
//   State<AddNewTaskPage> createState() => _AddNewTaskPageState();
// }

// class _AddNewTaskPageState extends State<AddNewTaskPage> {
//   DateTime selectedDate = DateTime.now();
//   TextEditingController titleController = TextEditingController();

//   TextEditingController descriptionController = TextEditingController();

//   Color selectedColor = Colors.blue;
//   final formKey = GlobalKey<FormState>();
//   void createNewTask() async {
//     if (formKey.currentState!.validate()) {
//       AuthUserLoggedIn user =
//           context.read<AuthCubit>().state as AuthUserLoggedIn;
//       await context.read<AddNewTaskCubit>().createNewTask(
//         title: titleController.text.trim(),
//         description: descriptionController.text.trim(),
//         color: selectedColor,
//         dueAt: selectedDate,
//         token: user.user.token!,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New task '),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () async {
//                 final _selectedDate = await showDatePicker(
//                   context: context,
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(Duration(days: 90)),
//                 );

//                 if (_selectedDate != null) {
//                   setState(() {
//                     selectedDate = _selectedDate;
//                   });
//                 }
//               },

//               child: Text(DateFormat("MM-d-y").format(selectedDate)),
//             ),
//           ),
//         ],
//       ),

//       body: BlocConsumer<AddNewTaskCubit, AddNewTaskError>(
//         listener: (context, state) {
//           if (state is AddNewTaskError){
//             return Scaffold(
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
//                 state.error
//               ),
//               ),
//               ),
//             ),
//           }
//         },
//         builder: (context, state) {

//           if (state is AddNewTaskLoading){
//             return Center(
//               child: CircularProgressIndicator(),
//             )
//           }

//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: formKey,

//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: titleController,
//                     decoration: InputDecoration(hintText: 'Title'),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return "Title Cannot be empty";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 15),
//                   TextFormField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(hintText: 'Description'),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return "Description  Cannot be empty";
//                       }
//                       return null;
//                     },
//                     maxLines: 4,
//                   ),

//                   ColorPicker(
//                     heading: Text('Select color'),
//                     subheading: Text('Select a different shade'),

//                     onColorChanged: (color) {
//                       setState(() {
//                         selectedColor = color;
//                       });
//                     },
//                     color: selectedColor,
//                     pickersEnabled: {ColorPickerType.wheel: true},
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/task_cubit.dart';
import 'package:frontend/features/home/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const AddNewTaskPage());

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Color selectedColor = Colors.blue;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void createNewTask() {
    if (formKey.currentState!.validate()) {
      final user = context.read<AuthCubit>().state as AuthUserLoggedIn;
      context.read<TaskCubit>().createNewTask(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        color: selectedColor,
        dueAt: selectedDate,
        token: user.user.token!,
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 90)),
                );

               
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
              child: Text(DateFormat("MM-d-y").format(selectedDate)),
            ),
          ),
        ],
      ),
      body: BlocConsumer<TaskCubit, TasksState>(
        listener: (context, state) {
          if (state is TasksError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AddNewTaskSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task created successfully!')),
            );
            Navigator.pushAndRemoveUntil(context, HomePage.route(), (_)=>false);
          }
        },
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                    maxLines: 4,
                  ),
                  ColorPicker(
                    heading: const Text('Select color'),
                    subheading: const Text('Select a different shade'),
                    onColorChanged: (color) {
                      setState(() => selectedColor = color);
                    },
                    color: selectedColor,
                    pickersEnabled: const {ColorPickerType.wheel: true},
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: state is TasksLoading
                        ? null
                        : createNewTask,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
