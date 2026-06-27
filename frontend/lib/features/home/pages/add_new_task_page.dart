import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const AddNewTaskPage());

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  Color selectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New task '),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final _selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 90)),
                );

                if (_selectedDate != null) {
                  setState(() {
                    selectedDate = _selectedDate;
                  });
                }
              },

              child: Text(DateFormat("MM-d-y").format(selectedDate)),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
              maxLines: 4,
            ),

            ColorPicker(
              heading: Text('Select color'),
              subheading: Text('Select a different shade'),

              onColorChanged: (color) {
                setState(() {
                  selectedColor = color;
                });
              },
              color: selectedColor,
              pickersEnabled: {ColorPickerType.wheel: true},
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
