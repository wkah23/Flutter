import 'package:open_api_xml_parser/src/model/ev.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class EvRepository {
  // api key
  var apiKey = '%2FmHCF2ywcRtza2xU1pZEVQZwH3WO2LuDgVppTMJ6wzjcBwfayY3NqoXURCnQvee0C9oyoGDz7A1h3WSg8C4rtA%3D%3D';

  Future<List<Ev>?> loadEvs() async {
    var addr = '경기도 고양시';
    String baseUrl = "http://openapi.kepco.co.kr/service/EvInfoServiceV2/getEvSearchList?addr=$addr&pageNo=1&numOfRows=10&ServiceKey=$apiKey";
    final respnse = await http.get(Uri.parse(baseUrl));

    // 정상적으로 데이터를 불러왔다면
    if (respnse.statusCode == 200) {
      final body = convert.utf8.decode(respnse.bodyBytes);

      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      Map<String, dynamic> jsonResult = convert.json.decode(json);
      final jsonEv = jsonResult['response']['body']['items'];

      if (jsonEv['item'] != null) {
        List<dynamic> list = jsonEv['item'];

        return list.map<Ev>((item) => Ev.fromJson(item)).toList();
      }
    }
    return null;
  }
}