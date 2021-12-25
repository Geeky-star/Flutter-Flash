import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) {
                return FlashDemo();
              }),
            ],
          )),
    );
  }
}

class FlashDemo extends StatefulWidget {
  @override
  _FlashDemoState createState() => _FlashDemoState();
}

class _FlashDemoState extends State<FlashDemo> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('FlashBar Examples',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => _showBasicFlash(),
              child: Text('Basic Flashbar'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _showTopFlash(),
              child: Text('Top Flashbar'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _showCustomFlash(),
              child: Text('Bottom Flashbar'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _flashWithInput(),
              child: Text('Input Flashbar'),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.showToast('You have 10 minutes left in the meeting.'),
              child: Text('Toast'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBasicFlash({
    flashStyle = FlashBehavior.floating,
  }) {
    showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: flashStyle,
          position: FlashPosition.bottom,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text('This is a basic flashbar'),
          ),
        );
      },
    );
  }

  void _showTopFlash() {
    showFlash(
      context: context,
      duration: const Duration(seconds: 2),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          behavior: FlashBehavior.fixed,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text('Hey User!'),
            content: Text('This is the top Flashbar!'),
            primaryAction: TextButton(
              onPressed: () {},
              child: Text('DISMISS', style: TextStyle(color: Colors.blue)),
            ),
          ),
        );
      },
    );
  }

  void _showCustomFlash() {
    showFlash(
      context: context,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          borderRadius: BorderRadius.circular(8.0),
          borderColor: Colors.blue,
          backgroundGradient: LinearGradient(
            colors: [Colors.pink, Colors.red],
          ),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              title: Text('Hello Flash'),
              content: Text('You can put any message of any length here.'),
              indicatorColor: Colors.blue,
              icon: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('DISMISS', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        );
      },
    );
  }

  void _flashWithInput() {
    TextEditingController editingController = TextEditingController();
    context.showFlashBar(
      barrierColor: Colors.blue,
      borderWidth: 3,
      behavior: FlashBehavior.fixed,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      title: Text('Hello from Flash'),
      content: Column(
        children: [
          Text('You can put any message of any length here.'),
          TextFormField(
            controller: editingController,
            autofocus: true,
          )
        ],
      ),
      primaryActionBuilder: (context, controller, _) {
        return IconButton(
          onPressed: () {
            print(editingController.text);
            editingController.clear();
          },
          icon: Icon(Icons.send, color: Colors.blue),
        );
      },
    );
  }
}
