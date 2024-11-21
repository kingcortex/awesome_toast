import 'package:awesome_toast/awesome_toast.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  AwesomeToastStyle _selectedStyle = AwesomeToastStyle.style1;
  final AwesomeToast _awesomeToast = AwesomeToast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 219, 219),
      appBar: AppBar(title: const Text('My Toasts')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<AwesomeToastStyle>(
                  value: _selectedStyle,
                  onChanged: (AwesomeToastStyle? newValue) {
                    if (newValue != null) {
                      // _awesomeToast.show(context:  context,title: Text("This is my info") ,type:  newValue);
                      setState(() {
                        _selectedStyle = newValue;
                      });
                    }
                  },
                  items:
                      AwesomeToastStyle.values.map((AwesomeToastStyle style) {
                    return DropdownMenuItem<AwesomeToastStyle>(
                      value: style,
                      child: Text(style.toString().split('.').last),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10)
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: errorPrimary),
              onPressed: () {
                _awesomeToast.show(
                    context: context,
                    title: Text("This is my info"),
                    type: AwesomeToastType.error);
              },
              child: const Text(
                'Show Toast Error',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: successPrimary,
              ),
              onPressed: () {
                _awesomeToast.show(
                  context: context,
                  title: Text("This is my info"),
                  description: Text("Description"),
                  type: AwesomeToastType.success,
                );
              },
              child: const Text(
                'Show Toast Success',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: infoPrimary),
              onPressed: () {
                _awesomeToast.show(
                    context: context,
                    title: Text("This is my info"),
                    type: AwesomeToastType.info);
              },
              child: const Text(
                'Show Toast Info',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: warningPrimary),
              onPressed: () {
                _awesomeToast.show(
                    context: context,
                    title: Text("This is my info"),
                    type: AwesomeToastType.warning);
              },
              child: const Text(
                'Show Toast Warning',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
