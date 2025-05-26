import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ljm/provider/connection.dart';
import 'package:ljm/tools/env.dart';

class TablePaginateUrl extends StatefulWidget {
  final String path;
  final Map<String, dynamic>? query;
  final String? order;
  final List<String>? filter;
  final String title;
  final bool pencarian;

  final Widget? floatingActionButton;
  final PagingController<int, dynamic>? controller;
  final Widget Function(BuildContext, dynamic, int) itemBuilder;

  const TablePaginateUrl({required this.itemBuilder, required this.path, this.query, super.key, this.order, this.filter, this.title = 'Daftar Data', this.floatingActionButton, this.controller, this.pencarian = true});

  @override
  State<TablePaginateUrl> createState() => _TablePaginateUrlState();
}

class _TablePaginateUrlState extends State<TablePaginateUrl> {
  var pageSize = 10; // jumlah records per loading
  late final pagingController = PagingController<int, dynamic>(getNextPageKey: (state) => (state.keys?.last ?? 0) + 1, fetchPage: fetchPage);

  final _searchController = TextEditingController();

  Future<List<dynamic>> fetchPage(int pageKey) async {
    String? where;
    if (_searchController.text.isNotEmpty && widget.filter != null) {
      where = createWhere(_searchController.text, widget.filter!);
    }

    var query = {
      ...?widget.query,
      'j': pageSize.toString(),
      'p': pageKey.toString(),
    };
    if (where != null) query = {...query, 'where': where};

    final newItems = await getUrlData(widget.path, query);
    return newItems ?? [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        child: CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar with floating and pinned properties
            if (widget.pencarian)
              SliverAppBar(
                toolbarHeight: 80,
                primary: false,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                pinned: false, // Keep app bar pinned at the top
                floating: true, // Float app bar upwards
                title: TextField(
                  controller: _searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    // fillColor: Colors.white,
                    // filled: true,
                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: (_searchController.text.isNotEmpty)
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                pagingController.refresh(); // Refresh the list
                              });
                            },
                          )
                        : null,

                    helperText: 'Pencarian data',
                    border: const UnderlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    // Trigger a new search when the text changes
                    setState(() {});
                    pagingController.refresh();
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: PopupMenuButton<String>(
                      elevation: 0,
                      onSelected: (value) {
                        // Handle item selection
                        switch (value) {
                          case 'settings':
                            // Implement your settings action
                            break;
                          case 'selectColumn':
                            // Implement your select column action
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'settings',
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Pengaturan'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'selectColumn',
                          child: ListTile(
                            leading: Icon(Icons.view_column),
                            title: Text('Pilih Kolom'),
                          ),
                        ),
                      ],
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            // SliverPagedList for dynamic list with pagination
            PagingListener(
              controller: widget.controller ?? pagingController,
              builder: (context, state, fetchNextPage) => PagedSliverList<int, dynamic>(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: widget.itemBuilder,
                  firstPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  newPageProgressIndicatorBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  noItemsFoundIndicatorBuilder: (_) => const Center(child: Text('No items found')),
                ),
              ),
            ),
          ],
        ));
  }
}
