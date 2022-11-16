import 'package:flutter/material.dart';

class LearnFlutter extends StatefulWidget {
  const LearnFlutter({super.key});

  @override
  State<LearnFlutter> createState() => _LearnFlutterState();
}

class _LearnFlutterState extends State<LearnFlutter> {
  bool isSwitch = false;
  bool? isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Flutter'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('Images/X_Brand.png'),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.black,
            ),
            Container(
              color: Colors.blueGrey,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'This is a text Widget',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: isSwitch ? Colors.blue : Colors.green,
              ),
              onPressed: () {
                debugPrint('Elevated button 2');
              },
              child: const Text('Elevated button'),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined button');
              },
              child: const Text('Outlined button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('Text button');
              },
              child: const Text('Text button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('Gester for row');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.blue,
                  ),
                  Text(
                    'Row Widget',
                  ),
                  Icon(
                    Icons.local_airport_sharp,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool newValue) {
                setState(() {
                  isSwitch = newValue;
                });
              },
            ),
            Checkbox(
              value: isCheck,
              onChanged: (bool? newCheck) {
                setState(() {
                  isCheck = newCheck;
                });
              },
            ),
            Image.asset('Images/X_Brand.png'),
          ],
        ),
      ),
    );
  }
}
