import 'dart:convert';
import 'package:app_inter_2/programs/program.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'i_program_repository.dart';

class ProgramRepositoryImpl extends IProgramRepository {
  Future<List<Program>> getAllPrograms() async {
    ParseResponse response = await ParseObject('Program').getAll();
    List<Program> programs = List();
    if (response.success) {
      print(response.result);
      var jsonResults = jsonDecode(response.result.toString());
      programs = List<Program>.from(
          jsonResults.map((e) => Program.instance(e)).toList());
      return programs;
    }
    return null;
  }
}
