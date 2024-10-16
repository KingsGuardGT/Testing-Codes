import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:testing/table/table_notifier.dart';
import 'package:testing/notifier/responsive_utils.dart';
import '../notifier/products_notifier.dart';

class TableTesting extends ConsumerStatefulWidget {
  const TableTesting({super.key, required this.title});

  final String title;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  CustomTableState createState() => CustomTableState();
}

class CustomTableState extends ConsumerState<TableTesting> {
  final TextEditingController _searchController = TextEditingController();
  final Map<int, bool> _expandedRows = {};
  final List<String> _filters = [];
  final ScrollController _scrollController = ScrollController();

  late Future<void> _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    await ref.read(productNotifierProvider.notifier).fetchProducts(limit: 100);
    ref.read(dataTableNotifierProvider.notifier).initializeTableProducts();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(dataTableNotifierProvider.notifier).loadMoreProducts();
    }
  }

  double _getDescriptionCellWidth(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return 600;
    } else if (ResponsiveUtils.isTablet(context)) {
      return 300; // Halved for tablet
    } else {
      return 600; // Original size for desktop
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dataTableNotifierProvider);
    final notifier = ref.read(dataTableNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context),
          vertical: ResponsiveUtils.verticalPadding(context),
        ),
        child: FutureBuilder<void>(
          future: _fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          margin: const EdgeInsets.only(right: 8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                            ),
                            style: TextStyle(color: Colors.grey[600]),
                            onSubmitted: (query) {
                              notifier.setSearchQuery(query);
                              if (query.isNotEmpty && !_filters.contains(query) && _filters.length < 5) {
                                setState(() {
                                  _filters.add(query);
                                });
                              }
                              _searchController.clear();
                            },
                            onChanged: (query) {
                              if (query.isEmpty) {
                                notifier.setSearchQuery(query);
                              }
                            },
                          ),
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: _filters.map((filter) {
                            return Chip(
                              label: Text(
                                filter,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: Colors.black,
                              labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                              onDeleted: () {
                                setState(() {
                                  _filters.remove(filter);
                                  if (_filters.isEmpty) {
                                    notifier.setSearchQuery('');
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          child: PopupMenuButton<String>(
                            icon: Image.asset('lib/images/filter.png'),
                            onSelected: (value) {
                              switch (value) {
                                case 'A-Z':
                                  notifier.sortProducts((a, b) => a.title.compareTo(b.title));
                                  break;
                                case 'Z-A':
                                  notifier.sortProducts((a, b) => b.title.compareTo(a.title));
                                  break;
                                case 'Lowest Price':
                                  notifier.sortProducts((a, b) => a.price.compareTo(b.price));
                                  break;
                                case 'Highest Price':
                                  notifier.sortProducts((a, b) => b.price.compareTo(a.price));
                                  break;
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'A-Z',
                                child: Text('Sort A-Z'),
                              ),
                              const PopupMenuItem(
                                value: 'Z-A',
                                child: Text('Sort Z-A'),
                              ),
                              const PopupMenuItem(
                                value: 'Lowest Price',
                                child: Text('Sort by Lowest Price'),
                              ),
                              const PopupMenuItem(
                                value: 'Highest Price',
                                child: Text('Sort by Highest Price'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ResponsiveUtils.isMobile(context)
                              ? Column(
                            children: notifier.filteredProducts.map((product) {
                              final creationDate = product.creationAt != null
                                  ? DateFormat('dd-MM-yy').format(product.creationAt!)
                                  : '';
                              final updateDate = product.updatedAt != null
                                  ? DateFormat('dd-MM-yy').format(product.updatedAt!)
                                  : '';
                              final isExpanded = _expandedRows[product.id] ?? false;

                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(product.title),
                                    subtitle: Text('\$${product.price.toString()}'),
                                    trailing: IconButton(
                                      icon: Image.asset(isExpanded
                                          ? 'lib/images/play_circle_outline.png'
                                          : 'lib/images/play_circle_filled.png'),
                                      onPressed: () {
                                        setState(() {
                                          _expandedRows[product.id] = !isExpanded;
                                        });
                                      },
                                    ),
                                  ),
                                  if (isExpanded)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Description: ${product.description ?? ''}'),
                                          Text('Created At: $creationDate'),
                                          Text('Updated At: $updateDate'),
                                        ],
                                      ),
                                    ),
                                  const Divider(),
                                ],
                              );
                            }).toList(),
                          )
                              : LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                  child: DataTable(
                                    headingRowColor: WidgetStateProperty.all(Colors.grey[300]),
                                    headingTextStyle: const TextStyle(color: Colors.black),
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 60),
                                          child: const Text(
                                            'Title',
                                            style: TextStyle(fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 40),
                                          child: const Text(
                                            'Price',
                                            style: TextStyle(fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: ConstrainedBox(
                                          constraints: BoxConstraints(maxWidth: _getDescriptionCellWidth(context)),
                                          child: const Text(
                                            'Description',
                                            style: TextStyle(fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 100),
                                          child: const Text(
                                            'Creation Date',
                                            style: TextStyle(fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 100),
                                          child: const Text(
                                            'Update Date',
                                            style: TextStyle(fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: notifier.filteredProducts.map((product) {
                                      final creationDate = product.creationAt != null
                                          ? DateFormat('dd-MM-yy').format(product.creationAt!)
                                          : '';
                                      final updateDate = product.updatedAt != null
                                          ? DateFormat('dd-MM-yy').format(product.updatedAt!)
                                          : '';

                                      return DataRow(
                                        color: WidgetStateProperty.resolveWith<Color?>(
                                              (Set<WidgetState> states) {
                                            if (states.contains(WidgetState.selected)) {
                                              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                                            }
                                            return null;
                                          },
                                        ),
                                        cells: <DataCell>[
                                          DataCell(
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 150),
                                              child: Text(
                                                product.title,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            ConstrainedBox(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              child: Text(
                                                '\$${product.price.toString()}',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: _getDescriptionCellWidth(context)),
                                              child: Text(
                                                product.description ?? '',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Container(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              padding: const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[100],
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: Text(
                                                creationDate,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Container(
                                              constraints: const BoxConstraints(maxWidth: 100),
                                              padding: const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.green[100],
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: Text(
                                                updateDate,
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                        selected: state.selected[state.products.indexOf(product)],
                                        onSelectChanged: (bool? value) {
                                          notifier.setSelectedIndex(state.products.indexOf(product), value!);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}