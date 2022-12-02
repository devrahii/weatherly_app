// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:weatherly/utilities/constants.dart';
import 'package:weatherly/services/weather.dart';
import 'package:weatherly/screens/city_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//TODO Move to screens Folder
//TODO Add Time Forecast Temp
//TODO Add Day Forecast Temp
//TODO add ClipPath widget around image widget
//TODO add multiple images to background according to temp
//TODO allocate Fix position of Container Temp and image

class HomePageWidget extends StatefulWidget {
  HomePageWidget({this.locationWeather});

  final locationWeather;
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';
  int humidityVal = 0;
  int wind = 0;
  int visibility = 0;
  String condn = '';
  int feelsLike = 0;
  int current_min_temp = 0;
  int current_max_temp = 0;
  DateTime sunrise = DateTime.now();
  DateTime sunset  = DateTime.now();
  String getSunrise = '';
  String getSunset = '';
  int? pressure;


  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        humidityVal = 0;
        wind = 0;
        visibility = 0;
        condn = 'Error';
        feelsLike = 0;
        current_min_temp =0;
        current_max_temp = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      var humidity = weatherData['main']['humidity'];
      var windVal = weatherData['wind']['speed'];
      var visibilityVal = weatherData['visibility'];
      condn = weatherData['weather'][0]['main'];
      visibility = visibilityVal.toInt();
      wind = windVal.toInt();
      humidityVal = humidity.toInt();
      double feelLikeTemp = weatherData['main']['feels_like'];
      double getCurrentMinTemp = weatherData['main']['temp_min'];
      double getCurrentMaxTemp = weatherData['main']['temp_max'];
      current_min_temp = getCurrentMinTemp.toInt();
      current_max_temp = getCurrentMaxTemp.toInt();
      feelsLike = feelLikeTemp.toInt();
      sunrise = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000);
      getSunrise =  DateFormat.jm().format(sunrise).toString();
      sunset = DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000);
      getSunset =  DateFormat.jm().format(sunset).toString();
      pressure = weatherData['main']['pressure'].toInt();


      // print(feels_like);
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor:  Color(0xFF5AD1FB),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      // borderColor: Colors.transparent,
                      // borderRadius: 30,
                      // borderWidth: 1,
                      // buttonSize: 60,
                      iconSize: 60,
                      icon:  const Icon(
                        Icons.location_on,
                        // color: FlutterFlowTheme.of(context).primaryText,
                        size: 30,
                      ),
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                    ),
                    Padding(
                      padding:  const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                      child: Text(
                        '$cityName',
                        style: const TextStyle(fontSize: 30, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                        textAlign: TextAlign.start,
                        // style: FlutterFlowTheme.of(context).title1.override(
                        //   fontFamily: 'Poppins',
                        //   fontSize: 30,
                        // ),
                      ),
                    ),
                    IconButton(
                      // borderColor: Colors.transparent,
                      // borderRadius: 30,
                      // borderWidth: 1,
                      // buttonSize: 50,
                      icon:  const Icon(
                        Icons.search,
                        // color: FlutterFlowTheme.of(context).primaryText,
                        size: 30,
                      ),
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                          await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                         Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(30, 50, 0, 0),
                          child: Text(
                            '$temperature°',

                            style: const TextStyle(fontSize: 56, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                            // FlutterFlowTheme.of(context).title1.override(
                            //   fontFamily: 'Poppins',
                            //    fontSize: 56,
                            // ),
                          ),
                        ),
                        Padding(
                          padding:  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              const FaIcon(
                                FontAwesomeIcons.angleUp,
                                color: Colors.black,
                                size: 10,
                              ),
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  '$current_max_temp°',
                                  style: const TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),
                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              const Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  color: Colors.black,
                                  size: 10,
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                child: Text(
                                  '$current_min_temp°',
                                  style: const TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),
                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                         Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(0, 20, 5, 0),
                          child: Text(
                            '$condn',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                            // style:
                            // FlutterFlowTheme.of(context).bodyText1.override(
                            //   fontFamily: 'Poppins',
                            //   fontSize: 16,
                            // ),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                          child: Text(
                            'Feels like $feelsLike°',
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 12, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                            // style:
                            // FlutterFlowTheme.of(context).bodyText1.override(
                            //   fontFamily: 'Poppins',
                            //   fontSize: 12,
                            // ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsetsDirectional.fromSTEB(150, 0, 0, 0),
                      child: Container(
                        width: 400,
                        height: 400,
                        clipBehavior: Clip.antiAlias,
                        decoration:  const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/187/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                 const Divider(
                  thickness: 0.5,
                   color: Colors.black,
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Now',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                              child: Text(
                                '28°',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Now',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                                child: Text(
                                  '28°',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 Divider(
                  thickness: 0.5,
                                      color: Colors.black,
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children:  [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Tuesday',
                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                              // style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                            child: Icon(
                              Icons.wb_sunny,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                            child: Text(
                              '31',
                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                              // style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              '13',
                              style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                              // style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Icon(
                                Icons.wb_sunny,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Text(
                                '31',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '13',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Icon(
                                Icons.wb_sunny,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Text(
                                '31',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '13',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Tuesday',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Icon(
                                Icons.wb_sunny,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                              child: Text(
                                '31',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '13',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                 Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
                Padding(
                  padding:  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 400,
                        height: 50,
                        child: Stack(
                          children:  [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'Sunrise',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(180, 0, 0, 0),
                              child: Text(
                                'Sunset',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 0, 0),
                              child: Text(
                                '$getSunrise',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(180, 20, 0, 0),
                              child: Text(
                                '$getSunset',
                                style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                // style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Container(
                          width: 400,
                          height: 50,
                          child: Stack(
                            children:  [
                              const Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Visibility',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    180, 0, 0, 0),
                                child: Text(
                                  'Humidity',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 0, 0),
                                child: Text(
                                  '$visibility meter',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    180, 20, 0, 0),
                                child: Text(
                                  '$humidityVal%',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Container(
                          width: 400,
                          height: 50,
                          child: Stack(
                            children:  [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'Wind',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    180, 0, 0, 0),
                                child: Text(
                                  'Pressure',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 20, 0, 0),
                                child: Text(
                                  '$wind m/s',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    180, 20, 0, 0),
                                child: Text(
                                  '$pressure hPa',
                                  style: TextStyle(fontSize: 14, fontFamily: 'Poppins',fontWeight: FontWeight.w600),

                                  // style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
