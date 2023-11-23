import 'package:bootcamperciyes_movieapp/product/service/local_service.dart';
import 'package:flutter/material.dart';

class LocalView extends StatefulWidget {
  const LocalView({super.key});

  @override
  State<LocalView> createState() => _LocalViewState();
}

class _LocalViewState extends State<LocalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: LocalService.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children:
                    snapshot.data!.filmler.map((e) => Text(e.title)).toList(),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
