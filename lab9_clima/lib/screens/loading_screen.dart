// lib/screens/loading_screen.dart
import 'package:flutter/material.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String? cityName;
  double? temperature;
  String? weatherIcon;

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      var weatherData = await weatherModel.getLocationWeather();

      if (weatherData != null) {
        setState(() {
          temperature = weatherData['main']['temp'];
          cityName = weatherData['name'];
          weatherIcon = weatherData['weather'][0]['icon']; // mã icon thời tiết
        });
      }
    } catch (e) {
      print("Error loading weather: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: temperature == null
            ? const CircularProgressIndicator(color: Colors.white)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://openweathermap.org/img/wn/$weatherIcon@2x.png",
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${temperature?.toStringAsFixed(1)}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    cityName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
