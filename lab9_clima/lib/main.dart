import 'package:flutter/material.dart';
import 'services/weather.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherModel weather = WeatherModel();
  final TextEditingController cityController = TextEditingController();

  String cityName = "";
  String temperature = "";
  String iconCode = "";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWeatherByLocation();
  }

  Future<void> getWeatherByLocation() async {
    setState(() => isLoading = true);
    try {
      var data = await weather.getLocationWeather();
      updateUI(data);
    } catch (e) {
      showErrorSnackBar("Không lấy được dữ liệu vị trí!");
    }
    setState(() => isLoading = false);
  }

  Future<void> getWeatherByCity(String city) async {
    if (city.isEmpty) return;
    setState(() => isLoading = true);
    try {
      var data = await weather.getCityWeather(city);
      updateUI(data);
    } catch (e) {
      showErrorSnackBar("Không tìm thấy thành phố!");
    }
    setState(() => isLoading = false);
  }

  void updateUI(dynamic data) {
    if (data == null) return;
    setState(() {
      double temp = data['main']['temp'];
      temperature = temp.toStringAsFixed(1);
      cityName = data['name'];
      iconCode = data['weather'][0]['icon'];
    });
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🖼 ẢNH NỀN
          Image.asset("assets/bg_weather.png", fit: BoxFit.cover),

          // Lớp phủ mờ để text nổi bật
          Container(color: Colors.black.withOpacity(0.4)),

          SafeArea(
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (iconCode.isNotEmpty)
                            Image.network(
                              "https://openweathermap.org/img/wn/$iconCode@4x.png",
                              width: 150,
                              height: 150,
                            ),
                          Text(
                            "$temperature°C",
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cityName,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Ô nhập thành phố
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: TextField(
                              controller: cityController,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'Nhập tên thành phố...',
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: Colors.white12,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onSubmitted: (value) => getWeatherByCity(value),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () =>
                                getWeatherByCity(cityController.text),
                            icon: const Icon(Icons.search),
                            label: const Text("Tìm thời tiết"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          IconButton(
                            onPressed: getWeatherByLocation,
                            icon: const Icon(Icons.refresh, size: 30),
                            tooltip: "Lấy lại theo vị trí GPS",
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
