import 'dart:convert';
import 'package:qop_timbu/....dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url =
      'https://api.timbu.cloud/products?organization_id=$Organization_ID&reverse_sort=false&Appid=$App_id&Apikey=$key';

  //Timbu api method
  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else if (response.statusCode == 300) {
      throw Exception('Bad Request. The request was invalid.');
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else if (response.statusCode == 500) {
      throw Exception('Internal Server Error. An error occurred on the server');
    } else {
      throw Exception('Failed to load products');
    }
  }
}
