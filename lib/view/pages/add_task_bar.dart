import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/view/theme.dart';
import 'package:todo/view/widgets/button.dart';
import 'package:todo/view/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController _taskController = Get.put(TaskController()) ;
  final TextEditingController _titleController  = TextEditingController() ;
  final TextEditingController _noteController = TextEditingController() ;
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh :mm  a ").format(DateTime.now());
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  int _selectedColor = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              MyInputField(title: "title", hint: "Enter Your Title " , controller: _titleController),
              MyInputField(title: "Note", hint: "Enter Your Note " , controller: _noteController),
              MyInputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: 'StartTime',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_alarm_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.access_alarm_rounded),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                  title: 'Remind',
                  hint: '$_selectedRemind minutes early',
                  widget: DropdownButton(
                      underline: Container(height: 0),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      items:
                          remindList.map<DropdownMenuItem<String>>((int value) {
                        return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()));
                      }).toList())),
              MyInputField(
                  title: 'Repeat',
                  hint: '$_selectedRepeat',
                  widget: DropdownButton(
                      underline: Container(height: 0),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      items: repeatList
                          .map<DropdownMenuItem<String>>((String? value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value!,
                              style: TextStyle(color: Colors.grey),
                            ));
                      }).toList())),
              const   SizedBox(height: 18,) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 _colorPallete(),
                  MyButton(
                    label: 'Create Task',
                    onTap: (){
                      _validateDate() ;
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDb() ;
      Get.back() ;
    }
    else if ( _titleController.text.isEmpty || _noteController.text.isEmpty ) {
      Get.snackbar("Required", "All Fields Are Required ! " ,
       snackPosition:  SnackPosition.BOTTOM ,
        backgroundColor: Colors.white ,
        colorText: pinkClr ,
        icon: const  Icon(Icons.warning_amber_rounded)
      ) ;
    }
  }
  _addTaskToDb() async {

   int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text ,
        note: _noteController.text ,
        date: DateFormat.yMd().format(_selectedDate) ,
        startTime: _startTime ,
        endTime: _endTime ,
        remind: _selectedRemind ,
        repeat: _selectedRepeat ,
        color: _selectedColor ,
        isCompleted: 0 ,
      )  ,
    ) ;
   print ("My Id is " + "$value") ;

  }
  _colorPallete (){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start ,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox( height: 8),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                    radius: 14 ,
                    backgroundColor: index == 0 ? primaryClr : index == 1 ? pinkClr :   orangeClr ,
                    child: _selectedColor == index ? const  Icon( Icons.done , color: Colors.white ,size: 16,) : Container()
                ),
              ),
              onTap:  (){
                setState(() {
                  _selectedColor = index ;
                });
              },
            );

          }),
        )
      ],
    ) ;
 }
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/person.jpeg"),
        ),
        SizedBox(width: 20),
      ],
    );
  }
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print(' Its Null Or SomeThing Is Wrong ');
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);

    if (pickedTime == null) {
      print('Time Canceled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }
  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
