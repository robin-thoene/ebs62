import 'package:flutter/material.dart';

/// Possible distance units that the application supports.
///
/// The enumeration value contains the conversion value to
/// the reference unit [DistanceUnit.meters] as [toMeters].
enum DistanceUnit {
  meters(toMeters: 1.0),
  kilometers(toMeters: 1000.0),
  feet(toMeters: 0.3048),
  miles(toMeters: 1609.34);

  const DistanceUnit({required this.toMeters});

  final double toMeters;
}

/// Converts a value [inputValue] to another unit [outputUnit].
///
/// The current unit [inputUnit] for the given value [inputValue] is needed
/// to perform the conversion.
double convert(
    double inputValue, DistanceUnit inputUnit, DistanceUnit outputUnit) {
  return inputValue * inputUnit.toMeters / outputUnit.toMeters;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konverter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Einheiten Konverter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// The actual value that the user put into the text field
  String? _valueToConvert;

  /// Whether the conversion of the user text field input to double was successful or not
  String? _valueConversionErrorMsg;

  /// The parsed user text field input
  double? _parsedValueToConvert;

  /// On press handler for the button that performs the conversion
  void onPressedConvertButton() {
    // Ensure that the text field input is not empty
    if (_valueToConvert == null || _valueToConvert == "") {
      setState(() {
        _valueConversionErrorMsg = "Der Wert darf nicht leer sein";
      });
      return;
    }
    // Ensure that the text field value can be converted
    var d = double.tryParse(_valueToConvert!);
    setState(() {
      _parsedValueToConvert = d;
      _valueConversionErrorMsg = null;
    });
    if (_parsedValueToConvert == null) {
      _valueConversionErrorMsg = "Die Eingabe is keine valide Dezimalzahl";
      // If the input can not be parsed to double,
      // do not proceed and set the validation error
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 30.0,
              children: <Widget>[
                const Text(
                  'Wert',
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText:
                          "Bitte geben Sie den zu konvertierenden Wert an",
                      errorText: _valueConversionErrorMsg),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (newValue) {
                    _valueToConvert = newValue;
                  },
                ),
                const Text('Von'),
                const Text('TODO: input'),
                const Text('Bis'),
                const Text('TODO: input'),
                ElevatedButton(
                  onPressed: onPressedConvertButton,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text('Konvertieren'),
                )
              ],
            ),
          ),
        ));
  }
}
