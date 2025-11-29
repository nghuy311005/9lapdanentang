import 'package:geolocator/geolocator.dart';
import 'networking.dart';

const apiKey = 'c46dfc34320984ec47d6c5a2dac82d08';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('🚫 Dịch vụ định vị chưa bật. Hãy bật GPS lên.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('🚫 Quyền vị trí bị từ chối');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('🚫 Quyền vị trí bị từ chối vĩnh viễn');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  Future<dynamic> getLocationWeather() async {
    // 🔴 BƯỚC 1: Tạm thời tắt dòng lấy vị trí thật này đi (Vì máy ảo đang lỗi cái này)
    // Position position = await _determinePosition();

    // 🟢 BƯỚC 2: Điền cứng tọa độ Hà Nội vào đây để App chạy được luôn
    double lat = 21.0285;
    double lon = 105.8542;

    // Gửi toạ độ giả này lên server
    String url =
        '$openWeatherMapURL?lat=$lat&lon=$lon&appid=$apiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
