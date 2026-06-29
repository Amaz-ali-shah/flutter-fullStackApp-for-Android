// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:frontend/core/constants/utils.dart';
// import 'package:intl/intl.dart';

// class DateSelector extends StatefulWidget {
//    DateTime selectedDate;
//   DateSelector({super.key,required this.selectedDate});

//   @override
//   State<DateSelector> createState() => _DateSelectorState();
// }

// class _DateSelectorState extends State<DateSelector> {
//   int weekOffSet = 0;
//   DateTime selectedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     final weekDates = generateWeekDates(weekOffSet);
//     String monthName = DateFormat("MMMM").format(weekDates.first);
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//           ).copyWith(bottom: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     // ← missing setState
//                     weekOffSet--;
//                   });
//                 },
//                 icon: const Icon(Icons.arrow_back_ios),
//               ),

//               Text(
//                 monthName,
//                 style: const TextStyle(
//                   // <-- add const
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     // ← missing setState
//                     weekOffSet++;
//                   });
//                 },
//                 icon: const Icon(Icons.arrow_forward_ios),
//               ),
//             ],
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: SizedBox(
//             height: 140,

//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: weekDates.length,
//               itemBuilder: (Context, index) {
//                 final date = weekDates[index];
//                 bool isSelected =
//                     DateFormat('d').format(widget.selectedDate) ==
//                         DateFormat('d').format(date) &&
//                     widget.selectedDate.month == date.month &&
//                     widget.selectedDate.year == date.year;
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       widget.selectedDate = date;
//                     });
//                   },
//                   child: Container(
//                     width: 100,
//                     margin: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.blue : null,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: isSelected ? Colors.blue : Colors.grey.shade300,
//                         width: 2,
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           DateFormat("d").format(date),
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black87,
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 5),

//                         Text(
//                           DateFormat("E").format(date),
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.black87,

//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final DateTime selectedDate;
  final Function (DateTime) onTap;
  // final Function(DateTime) onDateSelected;

  const DateSelector({
    super.key,
    required this.selectedDate,
    // required this.onDateSelected,
    required this.onTap
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffSet = 0;

  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDates(weekOffSet);
    String monthName = DateFormat("MMMM").format(weekDates.first);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffSet--;
                  });
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Text(
                monthName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    weekOffSet++;
                  });
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                final date = weekDates[index];
                bool isSelected =
                    DateFormat('d').format(widget.selectedDate) ==
                        DateFormat('d').format(date) &&
                    widget.selectedDate.month == date.month &&
                    widget.selectedDate.year == date.year;

                return GestureDetector(
                  onTap:  ()=> widget.onTap(date),
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("d").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat("E").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
