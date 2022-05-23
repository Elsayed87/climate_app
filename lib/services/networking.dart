import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      // using dart convert to decodeddata.
      // var decodedDecode=jsonDecode(data);
      //return decodedDecode;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
// the variable of decodedDecode is only has a type var because these data will be returned after calling the method
// but the other you knows its data type so you typed all by data types.[condition,temp,cityname]
//var decodedDecode=jsonDecode(data);
// var condition= jsonDecode(data==response.body=source)[''][''][''];
//jsonDecode is a method from dart convert library.

// int condition=jsonDecode(data)['weather'][0]['id'];

// int condition=decodedData['weather'][0]['id'];
// String cityName=decodedData['name'];
// double temperature=decodedData['main']['temp'];