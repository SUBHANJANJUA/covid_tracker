import 'dart:convert';
import 'dart:developer';

import 'package:covid_tracker/Model/WorldSateModel.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StateServieces {
  Future<WorldStateModel> fetchWordStateModel() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countryStateApi() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      log("Api access data from URL");
      return data;
    } else {
      log("Api access data from URL");
      throw Exception("Error");
    }
  }
}
