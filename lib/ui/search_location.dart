import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationSearch extends StatelessWidget {
  final TextEditingController _typeAheadController = TextEditingController();

  LocationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Location')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TypeAheadField(
          // textFieldConfiguration: TextFieldConfiguration(
          //   controller: _typeAheadController,
          //   decoration: InputDecoration(
          //     labelText: 'Location',
          //   ),
          // ),
          suggestionsCallback: (pattern) async {
            // Here, connect to your location API or custom data source
            return await getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: Icon(Icons.location_on),
              title: Text(suggestion.toString()),
            );
          },
          // onSuggestionSelected: (suggestion) {
          //   _typeAheadController.text = suggestion.toString();
          //   // Handle the selection
          // },
          onSelected: (String value) {  },
        ),
      ),
    );
  }

  Future<List<String>> getSuggestions(String query) async {
    // Replace with your API call to get location suggestions
    return ["Place 1", "Place 2", "Place 3"];
  }
}
