import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:paginator/paginator.dart';

class PaginatorWidget extends StatelessWidget {
  // TODO: (PORELARTE) implement offsets
  final Paginator? paginator;
  final Widget child;

  const PaginatorWidget({
    Key? key,
    required this.paginator,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.axis == Axis.horizontal) return false;

        final maxScroll = notification.metrics.maxScrollExtent.ceil();
        final currentScroll = notification.metrics.pixels.ceil();
        final atBottomEdge = maxScroll == currentScroll;

        if (atBottomEdge) {
          log('atBottomEdge: $atBottomEdge');

          paginator?.maybeFetch();
        }

        return true;
      },
      child: child,
    );
  }
}
