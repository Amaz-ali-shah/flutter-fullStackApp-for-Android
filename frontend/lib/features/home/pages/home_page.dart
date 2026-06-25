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
              // TODO: Add task navigation
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TaskCard(
                  color: Colors.blue,
                  headerText: 'Complete Flutter project',
                  descriptionText: 'Finalize the app and submit for review',
                ),
              ),
              const SizedBox(width: 10), // spacing
              const CircleAvatar(radius: 15, backgroundColor: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
