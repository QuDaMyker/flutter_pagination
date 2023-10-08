import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxString result = ''.obs;
  RxBool isLoading = false.obs;
  RxList list = [].obs;

  Future<void> getAPI(int page) async {
    isLoading.value = true;
    final url =
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$page&offset=0');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final resData = json.decode(response.body);
      list.value = List<Map<String, dynamic>>.from(resData['results']);
    } else {
      print('Error');
    }
    isLoading.value = false;
  }
}
