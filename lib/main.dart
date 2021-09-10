import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentStep = 0;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final address = TextEditingController();
  final postcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Stepper Widget',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.redAccent),
        ),
        child: Stepper(
            onStepTapped: (step) => setState(() => currentStep = step),
            steps: getSteps(),
            currentStep: currentStep,
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() {
                      currentStep = currentStep -= 1;
                    }),
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;
              if (isLastStep) {
                // ignore: avoid_print
                print('Completed');
              } else {
                setState(() {
                  currentStep = currentStep + 1;
                });
              }
            },
            controlsBuilder: (context, {onStepContinue, onStepCancel}) =>
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('NEXT'),
                          onPressed: onStepContinue,
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('CANCEL'),
                            onPressed: onStepCancel,
                          ),
                        ),
                    ],
                  ),
                )),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: const Text('Step 1'),
          isActive: currentStep >= 0,
          content: Column(children: [
            TextFormField(
                controller: firstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                )),
            TextFormField(
                controller: lastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                )),
          ]),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: const Text('Step 2'),
          isActive: currentStep >= 1,
          content: Column(children: [
            TextFormField(
                controller: address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                )),
            TextFormField(
                controller: postcode,
                decoration: const InputDecoration(
                  labelText: 'Postal Code',
                )),
          ]),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          title: const Text('Step 3'),
          isActive: currentStep >= 2,
          content: Container(
            child: null,
          ),
        ),
      ];
}
