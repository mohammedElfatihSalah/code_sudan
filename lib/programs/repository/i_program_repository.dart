import 'package:app_inter_2/programs/program.dart';

abstract class IProgramRepository {
  Future<List<Program>> getAllPrograms();
}
