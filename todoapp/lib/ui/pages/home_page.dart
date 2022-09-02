// ignore_for_file: prefer_final_fields

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'package:todo/ui/widgets/task_tile.dart';
import '../../controllers/task_controller.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper _notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notifyHelper = NotifyHelper();
    _notifyHelper.requestIOSPermissions();
    _notifyHelper.initializeNotification();
    _taskController.getTask();
  }

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _appBar(),
        body: Column(
          children: [
            _addTaskBar(),
            _DateBicker(),
            const SizedBox(
              height: 20,
            ),
            _showTasks(),
          ],
        ));
  }

  AppBar _appBar() => AppBar(
        leading: IconButton(
            onPressed: () {
              ThemeServices().SwitchTheme();
              // NotifyHelper()
              //     .DisplayNotification(tittle: 'Theme Change', body: 'Done');
              // NotifyHelper().schedulNotification();
            },
            icon: Icon(
              Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
              size: 16,
              color: primaryClr,
            )),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              _notifyHelper.CancelAllNotification();
              _taskController.deleteAll();
            },
            icon: Icon(
              Icons.cleaning_services_rounded,
              size: 24,
              color: Get.isDarkMode ? Colors.white : darkGreyClr,
            ),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
            radius: 18,
          ),
          const SizedBox(
            width: 6,
          )
        ],
      );

  _addTaskBar() {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 6),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: SubheadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTab: () async {
              await Get.to(() => const AddTaskPage());
              _taskController.getTask();
            },
          )
        ]));
  }

  _DateBicker() {
    return Container(
        margin: const EdgeInsets.only(top: 6, left: 20),
        child: DatePicker(
          DateTime.now(),
          width: 70,
          height: 100,
          initialSelectedDate: DateTime.now(),
          selectedTextColor: Colors.white,
          selectionColor: primaryClr,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onDateChange: (newval) {
            _selectedDate = newval;
          },
        ));
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.TaskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemBuilder: (BuildContext contex, int index) {
                var task = _taskController.TaskList[index];

                if (task.repeat == 'Daily' ||
                    task.date == DateFormat.yMd().format(_selectedDate) ||
                    (task.repeat == 'Weekly' &&
                        _selectedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == 'Monthly' &&
                        DateFormat.yMd().parse(task.date!).day ==
                            _selectedDate.day)) {
                  var hour = task.startTime.toString().split(':')[0];
                  var mintues = task.startTime.toString().split(':')[1];
                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat('HH:mm').format(date);

                  NotifyHelper().scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: _taskController.TaskList.length,
            ),
          );
        }
      }),
    );
    /*
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(
            context,
            Task(
                title: 'Tittle1',
                note: 'note someting',
                isCompleted: 0,
                startTime: '8:40',
                endTime: '9:40',
                color: 1),
          );
        },
        child: TaskTile(
          Task(
              title: 'Tittle1',
              note: 'note someting',
              isCompleted: 0,
              startTime: '8:40',
              endTime: '9:40',
              color: 1),
        ),
      ),
    );
    */
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 220,
                        ),
                  SvgPicture.asset(
                    'images/task.svg',
                    height: 90,
                    semanticsLabel: 'Task',
                    color: primaryClr.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      'You do not have any tasks yet \n add new tasks to make your day productive',
                      style: SubtittleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 120,
                        )
                      : const SizedBox(
                          height: 180,
                        )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _getBottomSheet(
      {required String labal,
      required Function() ontab,
      required Color clr,
      bool IsClose = false}) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: IsClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: IsClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            labal,
            style: IsClose
                ? tittleStyle
                : tittleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        width: SizeConfig.screenWidth,
        height: (SizeConfig.orientation == Orientation.landscape)
            ? (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.6
                : SizeConfig.screenHeight * 0.8)
            : (task.isCompleted == 1
                ? SizeConfig.screenHeight * 0.30
                : SizeConfig.screenHeight * 0.39),
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            task.isCompleted == 1
                ? Container()
                : _getBottomSheet(
                    labal: 'Task Completed',
                    ontab: () {
                      _notifyHelper.CancelNotification(task);
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr),
            _getBottomSheet(
              labal: 'Delete Task',
              ontab: () {
                _notifyHelper.CancelNotification(task);
                _taskController.Delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
            ),
            Divider(
              color: Get.isDarkMode ? Colors.grey : darkGreyClr,
            ),
            _getBottomSheet(
                labal: 'Cancel',
                ontab: () {
                  Get.back();
                },
                clr: primaryClr),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _onRefresh() async {
    _taskController.getTask();
  }
}
