import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://ceikerala.niveosys.org/api-project/public/api";

  Future<List<dynamic>> fetchAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/fetch-all-users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  Future<void> createUser(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-user'),
      body: userData,
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to create user");
    }
  }

  Future<void> updateUser(String id, Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update-user/$id'),
      body: userData,
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update user");
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete-user/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete user");
    }
  }
}
