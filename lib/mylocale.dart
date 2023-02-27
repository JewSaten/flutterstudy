import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MaterialApp(
      title: 'localization sample',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('es'),
        Locale('ko'),
      ],
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('localization sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Localizations.override(
            context: context,
            locale: const Locale('ko'),
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              onDateChanged: (DateTime value) {},
            ),
          ),
        ),
      ),
    );
  }
}
