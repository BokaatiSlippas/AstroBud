import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:astronomy_weather_app/save_local.dart';
import 'package:flutter/services.dart' show rootBundle;


/// A searchable dropdown widget for selecting cities from a CSV database.
/// - Loads city data from 'assets/worldcities.csv'
/// - Persists selected city using [QueryLocal]
/// - Supports fuzzy search by city or country name
/// - Displays selected city when reopening
class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  List<City> cities = [];
  City? selectedCity;

  // Loads the user's last selected city from Local Storage
  @override
  void initState() {
    loadCities();
    QueryLocal.getSelectedCity().then((value) {
      selectedCity = value;
    });
  }

  // Parses city data from the bundled CSV file
  Future<void> loadCities() async {
    try {
      final String dataString = await rootBundle.loadString('assets/worldcities.csv');
      List<List<dynamic>> csvTable = const CsvToListConverter().convert(dataString);

      setState( () {
        cities = csvTable
          .map( (row) => City.fromCsv(row) )
          .toList();
      } );
    } catch (e) {
      print('failed to parse csv: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<City>(
      items: (f, cs) => cities,
      itemAsString: (City city) => city.displayName(),
      onChanged: (City? city) {
        setState( () {
          selectedCity = city;
        });

        if(city != null) {
          QueryLocal.setSelectedCity(city); // Persist selection
        }
      },
      selectedItem: selectedCity,
      filterFn: (City city, String filter) {
        final lowercaseFilter = filter.toLowerCase();
        return city.city.toLowerCase().contains(lowercaseFilter) ||
               city.country.toLowerCase().contains(lowercaseFilter);
      },
      compareFn: (City? cityA, City? cityB) {
        if (cityA == null || cityB == null) return false;
        return cityA.toString() == cityB.toString();
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search city or country...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
