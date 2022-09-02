// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names, prefer_single_quotes, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/widgets/input_field.dart';

import '../theme.dart';
import '../widgets/button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _tittlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedReminder = 5;
  List<int> _RemindList = [5, 10, 15, 20];

  String _SelectedRepeat = 'None';
  List<String> Repeatlist = ['None', 'Weekly', 'Daily', 'Monthly'];
  int _SelectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              "Add Task",
              style: headingStyle,
            ),
            InputField(
              Tittle: 'Tittle',
              Hint: 'Add Tittle Here',
              controller: _tittlecontroller,
            ),
            InputField(
              Tittle: 'Note',
              Hint: 'Add Note Here',
              controller: _notecontroller,
            ),
            InputField(
              Tittle: 'Date',
              Hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                onPressed: () {
                  _getDateFromUser();
                },
                icon: const Icon(Icons.calendar_today_outlined),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    Tittle: 'Start Time',
                    Hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(IsStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputField(
                    Tittle: 'End Time',
                    Hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(IsStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InputField(
                Tittle: 'Remind',
                Hint: '$_selectedReminder minutes early',
                widget: Row(
                  children: [
                    DropdownButton(
                      borderRadius: BorderRadius.circular(30),
                      dropdownColor: Colors.blueGrey,
                      items: _RemindList.map<DropdownMenuItem<String>>(
                          (int Value) => DropdownMenuItem<String>(
                                value: Value.toString(),
                                child: Text(
                                  "$Value",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )).toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: SubtittleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedReminder = int.parse(newValue!);
                        });
                      },
                    ),
                    const SizedBox(width: 6)
                  ],
                )),
            InputField(
                Tittle: 'Repeat',
                Hint: '$_SelectedRepeat',
                widget: Row(
                  children: [
                    DropdownButton(
                      borderRadius: BorderRadius.circular(30),
                      dropdownColor: Colors.blueGrey,
                      items: Repeatlist.map<DropdownMenuItem<String>>(
                          (String Value) => DropdownMenuItem<String>(
                                value: Value,
                                child: Text(
                                  "$Value",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )).toList(),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      elevation: 4,
                      underline: Container(
                        height: 0,
                      ),
                      style: SubtittleStyle,
                      onChanged: (String? newValue) {
                        setState(() {
                          _SelectedRepeat = newValue!;
                        });
                      },
                    ),
                    const SizedBox(width: 6)
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorBalete(),
                MyButton(
                    label: 'Create Task',
                    onTab: () {
                      _validate();
                    })
              ],
            )
          ]),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 16,
              color: primaryClr,
            )),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          ),
          SizedBox(
            width: 6,
          )
        ],
      );

  Column ColorBalete() {
    return Column(
        // ignore: prefer_const_literals_to_create_immutables
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Color', style: tittleStyle),
          Wrap(
              children: List<Widget>.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _SelectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: CircleAvatar(
                  radius: 14,
                  child: _SelectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
              ),
            ),
          ))
        ]);
  }

  _validate() {
    if (_tittlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty) {
      _addTaskTodb();
      Get.back();
    } else if (_tittlecontroller.text.isEmpty || _notecontroller.text.isEmpty) {
      Get.snackbar(
        'required',
        'ALL FIELDS ARE REQUIRED',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber, color: Colors.red),
      );
    } else {
      print("######### Someting Bad Happend");
    }
  }

  _addTaskTodb() async {
    try {
      int _value = await _taskController.addTask(
        task: Task(
          tittle: _tittlecontroller.text,
          note: _notecontroller.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _SelectedColor,
          remind: _selectedReminder,
          repeat: _SelectedRepeat,
        ),
      );
      print('$_value');
    } catch (e) {
      print('error');
    }
  }

  void _getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    } else {
      print('something wrong happend');
    }
  }

  void _getTimeFromUser({required bool IsStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: IsStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String FormatedTime = pickedTime!.format(context);
    if (IsStartTime) {
      setState(() {
        _startTime = FormatedTime;
      });
    } else if (!IsStartTime) {
      setState(() {
        _endTime = FormatedTime;
      });
    } else {
      print("SomeThing Wrong Happend");
    }
  }
}
