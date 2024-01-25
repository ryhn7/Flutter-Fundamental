import 'package:dio/dio.dart';
import 'package:dio_http/person.dart';

abstract class Services {
  static Future<Person> getById(int id) async {
    try {
      var response = await Dio()
          .get<Map<String, dynamic>>("https://reqres.in/api/users/$id");

      if (response.statusCode == 200) {
        return Person(
            id: response.data?['data']['id'],
            name: response.data?['data']['first_name'] +
                ' ' +
                response.data?['data']['last_name'],
            email: response.data?['data']['email']);
      }
      return Person(id: 0, name: '', email: '');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Person> createUser(
      String firstName, String lastName, String email) async {
    try {
      var response = await Dio()
          .post<Map<String, dynamic>>("https://reqres.in/api/users", data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email
      });

      if (response.statusCode == 201) {
        return Person(
            id: int.tryParse(response.data?['id'].toString() ?? '0') ??
                0,
            name: response.data?['first_name'] +
                ' ' +
                response.data?['last_name'],
            email: response.data?['email']);
      }

      return Person(id: int.parse('0'), name: '', email: '');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
