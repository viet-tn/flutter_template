import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/ui/ui.dart';
import '../states/empty/empty_list.dart';
import '../states/error/load_error.dart';
import '../states/loading/loading_items.dart';

class AsyncListView<T> extends StatelessWidget {
  const AsyncListView({
    required this.value,
    required this.itemBuilder,
    super.key,
    this.emptyText = '',
    this.onRefresh,
    this.loading = const ListLoading(),
  });

  final AsyncValue<List<T>> value;
  final Future<void> Function()? onRefresh;
  final String emptyText;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Widget loading;

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: CGaps.screenHorizontal,
      child: value.when(
        data: (data) {
          return data.isEmpty
              ? EmptyList(
                  text: emptyText,
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => itemBuilder(
                    context,
                    index,
                    data[index],
                  ),
                );
        },
        error: LoadError.new,
        loading: () => loading,
      ),
    );
    if (onRefresh != null) {
      child = RefreshIndicator(
        onRefresh: onRefresh!,
        child: child,
      );
    }
    return child;
  }
}
