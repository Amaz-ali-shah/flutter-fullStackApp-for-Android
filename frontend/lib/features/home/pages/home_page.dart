// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/features/home/widgets/task_card.dart';

// class HomePage extends StatelessWidget {
//   static MaterialPageRoute route() =>
//       MaterialPageRoute(builder: (context) => const HomePage());

//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Tasks"),
//         centerTitle: true,
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add)),
//         ],
//       ),
//       body: Column(
//         children: [
//           TaskCard(color: Color.blue,HeaderText: "hello",descriptonText: "hii",),);
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/home/pages/add_new_task_page.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

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
      body: Column(
        children: [
          DateSelector(),
          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Colors.blue,
                  headerText: 'Complete Flutter project',
                  descriptionText:
                      'Finalize the app and submit for review Finalize the app and submit for reviewFinalize the app and submit for reviewFinalize the app and submit for reviewFinalize the app and submit for reviewFinalize the app and submit for reviewFinalize the app and submit for reviewFinalize the app and submit for review',
                ),
              ),
              const SizedBox(width: 10), // spacing
              const CircleAvatar(radius: 5, backgroundColor: Colors.blue),
              const SizedBox(width: 10), // spacing
              Text("10:00 AM", style: TextStyle(fontSize: 15)),
              const SizedBox(width: 10), // spacing
            ],
          ),
        ],
      ),
    );
  }
}
