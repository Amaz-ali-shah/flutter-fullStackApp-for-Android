// import 'package:flutter/material.dart';

// class TaskCard extends StatelessWidget {
//   final Color color;
//   final String HeaderText;
//   final String descriptonText;
//   const TaskCard({
//     super.key,
//     required this.color,
//     this.HeaderText = '',
//     this.descriptonText = '',
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             HeaderText,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(descriptonText),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Color color;
  final String headerText; // renamed to camelCase (optional but recommended)
  final String descriptionText;

  const TaskCard({
    super.key,
    required this.color,
    this.headerText = '',
    this.descriptionText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            descriptionText,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            maxLines: 4,
            overflow: TextOverflow.ellipsis
          ),
        ],
      ),
    );
  }
}
