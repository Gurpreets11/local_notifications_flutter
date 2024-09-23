import 'package:flutter/material.dart';

import 'local_notifications.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

//  to listen to any notification clicked or not
  listenToNotifications() {
    debugPrint("Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      debugPrint(event);
      Navigator.pushNamed(context, '/notification_detail', arguments: event);
    });
  }

  final int maxTitleLength = 40;
  TextEditingController _textTitleController = TextEditingController(text: "Notification Title");
  final int maxContentLength = 100;
  TextEditingController _textContentController = TextEditingController(text: "This is notification content data");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Local Notifications Flutter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Colors.white70,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Enter Notification title and content.",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  controller: _textTitleController,
                  maxLength: maxTitleLength,
                  decoration: InputDecoration(
                    hintText: "Hint text",
                    counterText: "",
                    suffix: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey[200],
                      ),
                      child: Text((maxTitleLength - _textTitleController.text.length).toString()),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextFormField(
                  maxLines: 3,
                  controller: _textContentController,
                  maxLength: maxContentLength,
                  decoration: InputDecoration(
                    counterText: "",
                    suffix: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey[200],
                      ),
                      child: Text((maxContentLength - _textContentController.text.length).toString()),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(

                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  LocalNotifications.showSimpleNotification(
                      title: _textTitleController.text,
                      body: _textContentController.text,
                      payload: _textContentController.text);
                },
                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.black87,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                label: const Text(
                  "Simple Notification",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.timer_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  LocalNotifications.showPeriodicNotifications(
                      title: _textTitleController.text, //"Periodic Notification",
                      body: _textContentController.text, //"This is a Periodic Notification",
                      payload: _textContentController.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                label: const Text(
                  "Periodic Notifications",
                  style: TextStyle(color: Colors.white),
                ),
              ),

               ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    LocalNotifications.cancel(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shadowColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  label: const Text(
                    "Close Periodic Notifcations",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton.icon(
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    LocalNotifications.cancelAll();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shadowColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  label: const Text(
                    "Cancel All Notifcations",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
