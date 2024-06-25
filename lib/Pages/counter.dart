import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Watch',
      theme: ThemeData(
        primaryColor: Colors.blue, // Color primario
      ),
      home: const CounterWatch(),
    );
  }
}

class CounterWatch extends StatefulWidget {
  const CounterWatch({super.key});

  @override
  SmartWatchCounterState createState() => SmartWatchCounterState();
}

class SmartWatchCounterState extends State<CounterWatch> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      if (_counter < 10) {
        _counter++;
      } else {
        _showMaxLimitSnackBar();
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > -10) {
        _counter--;
      } else {
        _showMinLimitSnackBar();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _showMaxLimitSnackBar() {
    _showMessage('El máximo posible es 10');
  }

  void _showMinLimitSnackBar() {
    _showMessage('El mínimo posible es -10');
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Evitar que el usuario cierre el diálogo al tocar fuera de él
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 19, 19, 19),
          body: Center(
            child: AlertDialog(
              backgroundColor: const Color.fromARGB(255, 19, 19, 19),
              content: Text(
                message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
    // Desvanecimiento del mensaje después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Detector de gestos para deslizar hacia arriba o hacia abajo
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          _incrementCounter();
        } else if (details.primaryDelta! > 0) {
          _decrementCounter();
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 19, 19), // Fondo negro
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Counter',
                style: TextStyle(
                  fontSize: 10, // Reducir el tamaño de fuente
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                  height:
                      5), // Reducir el espaciado entre el letrero y el botón de incremento
              ElevatedButton(
                // Botón de incremento arriba del contador
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(2), // Reducir el padding
                  minimumSize: const Size(10, 10), // Tamaño mínimo del botón
                ),
                child: const Icon(Icons.arrow_upward, size: 16),
              ),
              const SizedBox(
                height: 5,
              ), // Reducir el espaciado entre el botón de incremento y el contador
              Text(
                '$_counter',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ), // Reducir el espaciado entre el contador y el botón de decremento
              ElevatedButton(
                onPressed: _decrementCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(2), // Reducir el padding
                  minimumSize: const Size(8, 10), // Tamaño mínimo del botón
                ),
                child: const Icon(Icons.arrow_downward, size: 16),
              ),
              const SizedBox(
                height: 5,
              ), // Reducir el espaciado entre el botón de decremento y el botón de reinicio
              ElevatedButton(
                onPressed: _resetCounter,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(4), // Reducir el padding
                  minimumSize: const Size(10, 10), // Tamaño mínimo del botón
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 10), // Reducir el tamaño del texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
