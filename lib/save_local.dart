import 'package:shared_preferences/shared_preferences.dart';
import 'metrics_enum.dart';


// List of all metric keys derived from the Metric enum values
final List<String> keys = Metric.values
      .map((metric) => metric.name)
      .toList();

// SharedPreferences key for storing enabled metrics
const String saveKey = "stats";
// Map of metric names to Metric enum values
Map<String, Metric> nameMap = Metric.values.asNameMap();

// Provides methods for persistent local storage operations using SharedPreferences
class QueryLocal {
  // Getters and setters for enabled metrics
  static Future<List<Metric>> getAllEnabled() async{
    final prefs = await SharedPreferences.getInstance();
    List<String> enabled = List<String>.from(
        prefs.getStringList(saveKey) ?? keys);

    List<Metric> enabledEnum = enabled
      .map((metricStr) => nameMap[metricStr]!)
      .toList();
    return enabledEnum;
  }

  static Future<bool> getEnabled(Metric key) async {
    final allEnabled = await getAllEnabled();
    return allEnabled.contains(key);
  }

  static void setEnabled(Metric key) async {

    final prefs = await SharedPreferences.getInstance();
    List<String> temp = List<String>.from(
        prefs.getStringList(saveKey) ?? keys);
    
    if (!temp.contains(key.name)) {
      await prefs.setStringList(
          saveKey, temp..add(key.name));
    }
  }

  static void setDisabled(Metric key) async {

    final prefs = await SharedPreferences.getInstance();
    List<String> temp = List<String>.from(
        prefs.getStringList(saveKey) ?? keys);
    if (temp.contains(key.name)) {
      await prefs.setStringList(
          saveKey, temp..remove(key.name));
    }
  }

  // Getters and setters for selected city
  static void setSelectedCity(City city) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city.toValue());
  }

  static Future<City> getSelectedCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return City.fromValue(await prefs.getString('selectedCity'));
  }
}

// Represents a geographic location with city, coordinates, and country
class City {
  final String city;
  final double lat;
  final double long;
  final String country;

  City({
    required this.city,
    required this.lat,
    required this.long,
    required this.country,
  });

  // Creates a City from CSV row data
  factory City.fromCsv(List<dynamic> row) {
    return City(
      city: row[0].toString(),
      lat: double.parse(row[1].toString()),
      long: double.parse(row[2].toString()),
      country: row[3].toString(),
    );
  }

  // Creates a City from stored string value
  // Defaults to Birmingham
  factory City.fromValue(String? val) {
    if(val == null) {val = "Birmingham,52.4800,-1.9025,United Kingdom";};
    List<String> row = val!.split(",");
    return City(
      city: row[0],
      lat: double.parse(row[1]),
      long: double.parse(row[2]),
      country: row[3],
    );
  }

  // Serializes the City to a storage-friendly string
  String toValue() {
    return '$city,$lat,$long,$country';
  }

  // Returns display-friendly city name with country
  String displayName() {return '$city, $country';}

  @override
  String toString() => displayName();
}

