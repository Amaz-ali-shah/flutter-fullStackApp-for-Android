// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/cubit/auth_cubit.dart';
// import 'package:frontend/features/home/cubit/task_cubit.dart';
// import 'package:frontend/features/home/pages/add_new_task_page.dart';
// import 'package:frontend/features/home/widgets/date_selector.dart';
// import 'package:frontend/features/home/widgets/task_card.dart';
// import 'package:intl/intl.dart';

// class HomePage extends StatefulWidget {
//   static MaterialPageRoute route() =>
//       MaterialPageRoute(builder: (context) => const HomePage());

//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//     DateTime selectedDate = DateTime.now();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final user = context.read<AuthCubit>().state as AuthUserLoggedIn;
//     context.read<TaskCubit>().getAllTasks(token: user.user.token!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Tasks'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, AddNewTaskPage.route());
//             },
//             icon: const Icon(CupertinoIcons.add),
//           ),
//         ],
//       ),
//       body: BlocBuilder<TaskCubit, TasksState>(
//         builder: (context, state) {
//           if (state is TasksLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (state is TasksError) {
//             return Center(child: Text(state.error));
//           }
//           if (state is GetTasksSuccess) {
//             final tasks = state.tasks.where((elem)=>DateFormat('d').format(elem.dueAt) ==
//                         DateFormat('d').format(selectedDate) &&
//                     selectedDate.month == elem.dueAt.month &&
//                     selectedDate.year == elem.dueAt.year).toList();
//             return Column(
//               children: [
//                 DateSelector(
//                   selectedDate: selectedDate,
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),

//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     final task = tasks[index];
//                     return Row(
//                       children: [
//                         Expanded(
//                           child: TaskCard(
//                             color: task.color,
//                             headerText: task.title,
//                             descriptionText: task.description,
//                           ),
//                         ),
//                         const SizedBox(width: 10), // spacing
//                         CircleAvatar(radius: 5, backgroundColor: task.color),
//                         const SizedBox(width: 10), // spacing
//                         Text(
//                           DateFormat.jm().format(task.dueAt),
//                           style: TextStyle(fontSize: 15),
//                         ),
//                         const SizedBox(width: 10), // spacing
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             );
//           }
//           return SizedBox();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/task_cubit.dart';
import 'package:frontend/features/home/pages/add_new_task_page.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state as AuthUserLoggedIn;
    context.read<TaskCubit>().getAllTasks(token: user.user.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewTaskPage.route());
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TasksError) {
            return Center(child: Text(state.error));
          }
          if (state is GetTasksSuccess) {
            final tasks = state.tasks
                .where(
                  (elem) =>
                      DateFormat('d').format(elem.dueAt) ==
                          DateFormat('d').format(selectedDate) &&
                      selectedDate.month == elem.dueAt.month &&
                      selectedDate.year == elem.dueAt.year,
                )
                .toList();

            return Column(
              children: [
                DateSelector(
                  selectedDate: selectedDate,
                  onTap: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Row(
                      children: [
                        Expanded(
                          child: TaskCard(
                            color: task.color,
                            headerText: task.title,
                            descriptionText: task.description,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(radius: 5, backgroundColor: task.color),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat.jm().format(task.dueAt),
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
