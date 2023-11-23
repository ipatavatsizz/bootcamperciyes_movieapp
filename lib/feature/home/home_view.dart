import 'package:bootcamperciyes_movieapp/product/model/results.dart';
import 'package:bootcamperciyes_movieapp/product/service/api_service.dart';
import 'package:bootcamperciyes_movieapp/product/widget/appbar.dart';
import 'package:bootcamperciyes_movieapp/product/widget/list_tile.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Set<Results> cache = {};
  int index = 0;
  final double scrollOffset = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => setState(() => index--),
            icon: Icon(Icons.arrow_back),
          ),
          Text('${index + 1}'),
          IconButton(
            onPressed: () => setState(() => index++),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      appBar: MovieAppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiService.get(page: index + 1),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final data = snapshot.data;

                if (data == null) return Text('Veri boş');
                if (data.results.isEmpty) return Text('Liste boş.');

                debugPrint('caching ${cache.length}');

                return ScrollConfiguration(
                  behavior:
                      MaterialScrollBehavior().copyWith(overscroll: false),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ...data.results.map((data) => MovieListTile(data: data)),
                    ],
                  ),
                );
              default:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Veriler alınıyor...'),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
