import 'dart:io';

import 'package:app_inter_2/programs/program.dart';
import 'package:app_inter_2/programs/program_registeration_form.dart';
import 'package:app_inter_2/programs/repository/i_program_repository.dart';
import 'package:app_inter_2/programs/repository/program_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProgramListPage extends StatefulWidget {
  @override
  _ProgramListPageState createState() => _ProgramListPageState();
}

class _ProgramListPageState extends State<ProgramListPage> {
  final IProgramRepository repository = ProgramRepositoryImpl();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        color: Colors.black.withOpacity(0.5),
        child: FutureBuilder<List<Program>>(
          future: repository.getAllPrograms(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Program> programs = snapshot.data;
            return ListView.builder(
              itemCount: programs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(programs[index].name),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProgramRegisterationForm(
                              program: programs[index],
                            )));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
