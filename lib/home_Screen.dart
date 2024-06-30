import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/Services/services.dart';
import 'package:weather_app/model/model.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WeatherData weatherData;
  bool isloadimg = false;
  myWeather() {
    isloadimg = false;
    weatherServices().fetchWeather().then((val) {
      setState(() {
        weatherData = val;
        isloadimg = true;
      });
    });
  }

  @override
  void initState() {
    weatherData = WeatherData(
        name: "",
        temperature: Temperature(current: 0.0),
        humidity: 0,
        wind: Wind(speed: 0.0),
        maxTemperature: 0,
        minTemperature: 0,
        pressure: 0,
        seaLevel: 0,
        weather: []);
    // TODO: implement initState
    super.initState();
    myWeather();
  }

  @override
  Widget build(BuildContext context) {
    String formatedDate = DateFormat("EEEE , MMMM yyyy").format(DateTime.now());

    String formatedTime = DateFormat("hh:mm a").format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xff6768d0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isloadimg
                  ? WeatherDetail(
                      weatherData: weatherData,
                      formatedDate: formatedDate,
                      formatedTime: formatedTime,
                    )
                  : CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatefulWidget {
  final WeatherData weatherData;
  final String formatedDate;
  final String formatedTime;

  const WeatherDetail(
      {super.key,
      required this.weatherData,
      required this.formatedDate,
      required this.formatedTime});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//for current address name
        Text(
          widget.weatherData.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
//for current temp of my address
        //in api we got temperature in calvine , so we arw converting in celcius in model
        Text(
          "${widget.weatherData.temperature.current.toStringAsFixed(2)} °C",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
        ),
        //for weather condition
        if (widget.weatherData.weather.isNotEmpty)
          Text(
            widget.weatherData.weather[0].main,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        const SizedBox(
          height: 30,
        ),
        //for current date and time
        Text(
          widget.formatedDate,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        Text(
          widget.formatedTime,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),

        const SizedBox(
          height: 30,
        ),
        Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/cloudy.png"))),
        ),
        //for weather detail

        Container(
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.deepPurple),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "wind",
                            value: "${widget.weatherData.wind.speed} km/h"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "Max",
                            value:
                                "${widget.weatherData.maxTemperature.toStringAsFixed(2)} °C"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "Min",
                            value:
                                "${widget.weatherData.wind.speed.toStringAsFixed(2)} °C"),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "Humidity",
                            value: "${widget.weatherData.humidity} %"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.air,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "Pressure",
                            value: "${widget.weatherData.pressure}hPa"),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.leaderboard,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        weatherImfoCard(
                            title: "Sea-Level",
                            value: "${widget.weatherData.seaLevel}m"),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Column weatherImfoCard({required String title, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }
}
