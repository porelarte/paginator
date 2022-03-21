import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paginator/src/paginator.dart';

class PaginatorWidget extends StatelessWidget {
  final Paginator? paginator;
  final double bottomExtent;
  final Widget child;

  const PaginatorWidget({
    Key? key,
    required this.paginator,
    required this.child,
    this.bottomExtent = 240.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.axis == Axis.horizontal) return false;

        final maxScroll = notification.metrics.maxScrollExtent.ceil();
        final currentScroll = notification.metrics.pixels.ceil();
        final atEdge = maxScroll <= (currentScroll + bottomExtent);

        if (atEdge) {
          log('atEdge: $atEdge');

          paginator?.maybeFetch();
        }

        return true;
      },
      child: child,
    );
  }
}
