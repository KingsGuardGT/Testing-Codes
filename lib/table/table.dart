import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:testing/table/table_notifier.dart';
import 'package:testing/notifier/responsive_utils.dart';

class TableTesting extends ConsumerStatefulWidget {
  const TableTesting({super.key, required this.title});

  final String title;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends ConsumerState<TableTesting> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Map<int, bool> _expandedRows = {};

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dataTableNotifierProvider);
    final notifier = ref.read(dataTableNotifierProvider.notifier);

    // Filter data based on search query
    final filteredData = state.products.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 200,
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
                        ),
                        style: TextStyle(color: Colors.grey[600]),
                        onChanged: (query) {
                          setState(() {
                            _searchQuery = query;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    icon: Image.asset('lib/images/filter.png'), // Change icon to filter.png
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
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
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
                      children: filteredData.map((product) {
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
                            const Divider(), // Add Divider here
                          ],
                        );
                      }).toList(),
                    )
                        : DataTable(
                      headingRowColor: WidgetStateProperty.all(Colors.grey[300]),
                      headingTextStyle: const TextStyle(color: Colors.black),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Title',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Price',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Description',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Creation Date',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Update Date',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: filteredData.map((product) {
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
                            DataCell(Text(product.title)),
                            DataCell(Text('\$${product.price.toString()}')),
                            DataCell(Text(product.description ?? '')),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(creationDate),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(updateDate),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}