import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});
  final String
  title; // intializing a string to be used assigned a value on compile time.

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;
  final TextEditingController _countTarget =
      TextEditingController(); // intializing text editing controller

  void increaseCount() {
    setState(() {
      final countTargetInput = int.tryParse(_countTarget.text);
      if (_count != countTargetInput) {
        _count++;
      }

      // checking if target has been reached
      if (_count == countTargetInput) {
        debugPrint('Target recached'); // prints into the console
        HapticFeedback.mediumImpact(); // the device vibrates upon reaching the targets
      }
    });
  } // incrementing the count

  @override
  void dispose() {
    _countTarget.dispose();
    super.dispose();
  }

  // a function to refresh count to its original state
  void refreshCount() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ), // title is been conveerted to widget
        actions: [
          IconButton(
            onPressed: () {
              refreshCount();
              
            }, // refreshes the counter back to 0
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
      ), // app bar section

      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            // The textfield below
            // accepts users count terget and pass it to the system using controller.
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.widthOf(context) / 4.5,

                // The textfield below
                // accepts users count terget and pass it to the system using controller.
                child: TextField(
                  controller: _countTarget,
                  keyboardType: TextInputType
                      .number, // this allow user to only input numbers
                  decoration: InputDecoration(hintText: 'Enter count target'),
                ),
              ),
            ),

            Text(
              'Click on the add button below to increase count.',
              style: TextStyle(fontSize: 16),
            ), // instruction
            // Actual counted number
            Text('$_count', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        splashColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          increaseCount();
        }, // triggered action when the fab is pressed

        elevation: 4.0,
        tooltip: 'increment',
        child: Icon(Icons.add), // add Icon
      ),
    );
  }
}
