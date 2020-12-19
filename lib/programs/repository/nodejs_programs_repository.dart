import 'dart:convert';

import 'package:app_inter_2/programs/program.dart';
import 'package:app_inter_2/programs/repository/i_program_repository.dart';
import 'package:http/http.dart' as http;

class NodeJsProgramRepository extends IProgramRepository {
  static const String BASE_URL = 'http:' + '//' + '192.168.43.84:80';

  @override
  Future<List<Program>> getAllPrograms() async {
    http.Response response = await http.get(BASE_URL + '/program');

    if (response != null) {
      var bodyJson = json.decode(response.body);
      bool isSuccess = bodyJson['success'];

      if (isSuccess) {
        List<Program> programs = List();
        var programsJson = bodyJson['programs'];
        for (var programJson in programsJson) {
          String name = programJson['name'];
          String description = programJson['description'];
          String formUrl = programJson['formUrl'];
          String imageUrl = programJson['imageUrl'];

          programs.add(Program(
            name: name,
            description: description,
            imageUrl: imageUrl,
            formUrl: formUrl,
          ));
        }

        return programs;
      } else {
        return [];
      }
    }
  }
}
