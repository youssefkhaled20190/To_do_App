// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
    this.task, {
    Key? key,
  }) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
            SizeConfig.orientation == Orientation.landscape ? 4 : 20),
      ),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _getcolor(task.color)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.tittle!,
                    style: GoogleFonts.lato(
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: GoogleFonts.lato(
                          // ignore: prefer_const_constructors
                          textStyle: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    task.note!,
                    style: GoogleFonts.lato(
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: GoogleFonts.lato(
                    // ignore: prefer_const_constructors
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getcolor(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
/*
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Task>('task', task));
    properties.add(DiagnosticsProperty<Task>('task', task));
  }
  */
}
