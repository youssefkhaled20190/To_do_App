import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payload = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        title: Text(_payload.toString().split('|')[0],
            // ignore: prefer_const_constructors
            style:
                TextStyle(color: Get.isDarkMode ? Colors.black : darkGreyClr)),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  "Hello , Youssef",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : darkGreyClr,
                      fontWeight: FontWeight.w900,
                      fontSize: 26),
                ),
                const SizedBox(height: 10),
                Text(
                  "you have new notification",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: primaryClr, borderRadius: BorderRadius.circular(30)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.text_format,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Tittle",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(_payload.toString().split('|')[0],
                        // ignore: prefer_const_constructors
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(
                          Icons.description,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Description",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _payload.toString().split('|')[1],
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text("Date",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(_payload.toString().split('|')[2],
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        )),
                  ],
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
