import 'package:bootcamperciyes_movieapp/product/model/results.dart';
import 'package:bootcamperciyes_movieapp/product/widget/appbar.dart';
import 'package:bootcamperciyes_movieapp/product/widget/title_divider.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    super.key,
    required this.data,
  });

  final Results data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(),
      body: ListView(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(horizontal: 10),
            clipBehavior: Clip.hardEdge,
            elevation: 10,
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${data.posterPath!}',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TITLE
                    SizedBox(
                      height: 70,
                      child: NavigationToolbar(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.black,
                              // decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              // ),
                              padding: EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 7,
                              ),
                              child: Text(
                                data.voteAverage?.toStringAsFixed(1) ?? '-1',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        centerMiddle: true,
                        middle: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            data.title ??
                                data.originalTitle ??
                                'Başlık verisi girilmemiş',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CountryFlag.fromLanguageCode(
                              data.originalLanguage?.toUpperCase() ?? 'EN',
                              height: 24,
                              width: 48,
                              borderRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // DETAYLAR
                    TitleDivider(
                      title: 'DETAYLAR',
                      alignment: DividerAlignment.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Yetişkin'),
                              Text(
                                data.adult != null
                                    ? data.adult!
                                        ? 'Evet'
                                        : 'Hayır'
                                    : '?',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Popülerlik'),
                              Text('${data.popularity ?? '?'}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // AÇIKLAMA
                    TitleDivider(
                      title: 'AÇIKLAMA',
                      alignment: DividerAlignment.left,
                    ),
                    SizedBox(height: 10),
                    Text(
                      data.overview ?? 'Açıklama verisi girilmemiş.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 20),
                    TitleDivider(
                      title: 'SON',
                      alignment: DividerAlignment.right,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
