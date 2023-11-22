import 'package:bootcamperciyes_movieapp/feature/detail/detail_view.dart';
import 'package:bootcamperciyes_movieapp/product/model/response.dart';
import 'package:bootcamperciyes_movieapp/product/service/api_service.dart';
import 'package:bootcamperciyes_movieapp/product/widget/appbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final List<Response> cache = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MovieAppBar(),
        body: FutureBuilder(
          future: ApiService.get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final data = snapshot.data;
                if (data == null) return Text('Veri boş');
                if (data.results.isEmpty) return Text('Liste boş.');
                cache.addAll(Iterable.castFrom(data.results));
                return ListView(
                  children: [
                    Center(
                      child: Text(
                        'Movie List',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ...data.results
                        .map(
                          (e) => ListTile(
                            onTap: () => mounted
                                ? Navigator.maybeOf(context)?.push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailView(data: e),
                                    ),
                                  )
                                : null,
                            trailing: Text(e.voteAverage.toString()),
                            leading: e.posterPath != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${e.posterPath!}',
                                  )
                                : null,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    e.title ?? e.originalTitle ?? 'Başlıksız',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    e.popularity?.toStringAsFixed(3) ?? '-1',
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              e.overview ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                  ],
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
