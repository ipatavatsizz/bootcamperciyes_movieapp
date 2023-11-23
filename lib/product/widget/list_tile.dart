import 'package:bootcamperciyes_movieapp/feature/detail/detail_view.dart';
import 'package:bootcamperciyes_movieapp/product/model/results.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.data,
  });

  final Results data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.mounted
          ? Navigator.maybeOf(context)?.push(
              MaterialPageRoute(
                builder: (context) => DetailView(data: data),
              ),
            )
          : null,
      leading: data.posterPath != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${data.posterPath!}',
                ),
              ],
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              data.title ?? data.originalTitle ?? 'Başlıksız',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              data.voteAverage?.toStringAsFixed(1) ?? '?',
            ),
          ),
        ],
      ),
      subtitle: Text(
        data.overview ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
