import 'package:calendar_api/calendar_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Calendar API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Calendar calendar = CalendarApi.getCalendar(2023, 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ("${calendar.days.first.year}/${calendar.days.first.month}"),
                ),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        calendar = CalendarApi.getCalendar(
                          calendar.days.first.month == 1 ? calendar.days.first.year - 1 : calendar.days.first.year,
                          calendar.days.first.month == 1 ? 12 : calendar.days.first.month - 1,
                        );
                      });
                    },
                    child: Text("Previous")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        calendar = CalendarApi.getCalendar(
                          calendar.days.first.month == 12 ? calendar.days.first.year + 1 : calendar.days.first.year,
                          calendar.days.first.month == 12 ? 1 : calendar.days.first.month + 1,
                        );
                      });
                    },
                    child: Text("Next")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(builder: (context, constraints) {
                return Wrap(
                    children: [
                  ...["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"],
                  ...List.generate(calendar.days.first.weekday - 1, (index) => ""),
                  ...calendar.days
                      .map(
                        (e) => e.day.toString(),
                      )
                      .toList(),
                ]
                        .map(
                          (e) => Container(
                            width: (constraints.biggest.width - 5) / 7.0,
                            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: Text(e),
                          ),
                        )
                        .toList());
              }),
            ),
          ],
        ),
      ),
    );
  }
}
