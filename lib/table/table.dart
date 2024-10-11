import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod for state management.
import 'package:intl/intl.dart'; // Importing intl package for date formatting.
import 'package:testing/table/table_notifier.dart'; // Importing the TableNotifier class.
import 'package:testing/notifier/responsive_utils.dart'; // Importing responsive utilities.
import '../notifier/products_notifier.dart'; // Importing the ProductNotifier class.

class TableTesting extends ConsumerStatefulWidget { // Defining a stateful widget that uses Riverpod.
  const TableTesting({super.key, required this.title}); // Constructor with a required title parameter.

  final String title; // Title of the table.

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold); // Defining a text style.

  @override
  CustomTableState createState() => CustomTableState(); // Creating the state for this widget.
}

class CustomTableState extends ConsumerState<TableTesting> { // Defining the state class for TableTesting.
  final TextEditingController _searchController = TextEditingController(); // Controller for the search input.
  final Map<int, bool> _expandedRows = {}; // Map to keep track of expanded rows.

  @override
  void initState() {
    super.initState();
    ref.read(productNotifierProvider.notifier).fetchProducts().then((_) { // Fetching products on initialization.
      ref.read(dataTableNotifierProvider.notifier).initializeTableProducts(); // Initializing table products.
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dataTableNotifierProvider); // Watching the state of the data table.
    final notifier = ref.read(dataTableNotifierProvider.notifier); // Reading the notifier for the data table.

    return Scaffold( // Building the main scaffold.
      appBar: AppBar(
        title: Text(widget.title), // Setting the title of the app bar.
      ),
      backgroundColor: Colors.grey[200], // Setting the background color.
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.horizontalPadding(context), // Horizontal padding based on screen size.
          vertical: ResponsiveUtils.verticalPadding(context), // Vertical padding based on screen size.
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0), // Padding at the bottom.
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _searchController, // Controller for the search input.
                        decoration: InputDecoration(
                          hintText: 'Search...', // Placeholder text.
                          hintStyle: TextStyle(color: Colors.grey[400]), // Style for the placeholder text.
                          filled: true,
                          fillColor: Colors.white, // Background color of the text field.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners.
                            borderSide: BorderSide.none, // No border.
                          ),
                        ),
                        style: TextStyle(color: Colors.grey[600]), // Style for the input text.
                        onChanged: (query) {
                          notifier.setSearchQuery(query); // Updating the search query.
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Spacing between the search field and the filter button.
                  PopupMenuButton<String>(
                    icon: Image.asset('lib/images/filter.png'), // Filter icon.
                    onSelected: (value) {
                      switch (value) {
                        case 'A-Z':
                          notifier.sortProducts((a, b) => a.title.compareTo(b.title)); // Sorting A-Z.
                          break;
                        case 'Z-A':
                          notifier.sortProducts((a, b) => b.title.compareTo(a.title)); // Sorting Z-A.
                          break;
                        case 'Lowest Price':
                          notifier.sortProducts((a, b) => a.price.compareTo(b.price)); // Sorting by lowest price.
                          break;
                        case 'Highest Price':
                          notifier.sortProducts((a, b) => b.price.compareTo(a.price)); // Sorting by highest price.
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'A-Z',
                        child: Text('Sort A-Z'), // Menu item for sorting A-Z.
                      ),
                      const PopupMenuItem(
                        value: 'Z-A',
                        child: Text('Sort Z-A'), // Menu item for sorting Z-A.
                      ),
                      const PopupMenuItem(
                        value: 'Lowest Price',
                        child: Text('Sort by Lowest Price'), // Menu item for sorting by lowest price.
                      ),
                      const PopupMenuItem(
                        value: 'Highest Price',
                        child: Text('Sort by Highest Price'), // Menu item for sorting by highest price.
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
                      color: Colors.white, // Background color of the container.
                      borderRadius: BorderRadius.circular(12), // Rounded corners.
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, // Shadow color.
                          blurRadius: 8, // Blur radius of the shadow.
                          offset: Offset(0, 2), // Offset of the shadow.
                        ),
                      ],
                    ),
                    child: ResponsiveUtils.isMobile(context) // Checking if the device is mobile.
                        ? Column(
                      children: notifier.filteredProducts.map((product) { // Mapping filtered products to widgets.
                        final creationDate = product.creationAt != null
                            ? DateFormat('dd-MM-yy').format(product.creationAt!) // Formatting creation date.
                            : '';
                        final updateDate = product.updatedAt != null
                            ? DateFormat('dd-MM-yy').format(product.updatedAt!) // Formatting update date.
                            : '';
                        final isExpanded = _expandedRows[product.id] ?? false; // Checking if the row is expanded.

                        return Column(
                          children: [
                            ListTile(
                              title: Text(product.title), // Product title.
                              subtitle: Text('\$${product.price.toString()}'), // Product price.
                              trailing: IconButton(
                                icon: Image.asset(isExpanded
                                    ? 'lib/images/play_circle_outline.png'
                                    : 'lib/images/play_circle_filled.png'), // Icon based on expansion state.
                                onPressed: () {
                                  setState(() {
                                    _expandedRows[product.id] = !isExpanded; // Toggling expansion state.
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
                                    Text('Description: ${product.description ?? ''}'), // Product description.
                                    Text('Created At: $creationDate'), // Creation date.
                                    Text('Updated At: $updateDate'), // Update date.
                                  ],
                                ),
                              ),
                            const Divider(), // Divider between rows.
                          ],
                        );
                      }).toList(),
                    )
                        : Flexible(
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.grey[300]), // Heading row color.
                        headingTextStyle: const TextStyle(color: Colors.black), // Heading text style.
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Title',
                                style: TextStyle(fontStyle: FontStyle.italic), // Column title style.
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Price',
                                style: TextStyle(fontStyle: FontStyle.italic), // Column price style.
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Description',
                                style: TextStyle(fontStyle: FontStyle.italic), // Column description style.
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Creation Date',
                                style: TextStyle(fontStyle: FontStyle.italic), // Column creation date style.
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Update Date',
                                style: TextStyle(fontStyle: FontStyle.italic), // Column update date style.
                              ),
                            ),
                          ),
                        ],
                        rows: notifier.filteredProducts.map((product) { // Mapping filtered products to data rows.
                          final creationDate = product.creationAt != null
                              ? DateFormat('dd-MM-yy').format(product.creationAt!) // Formatting creation date.
                              : '';
                          final updateDate = product.updatedAt != null
                              ? DateFormat('dd-MM-yy').format(product.updatedAt!) // Formatting update date.
                              : '';

                          return DataRow(
                            color: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Theme.of(context).colorScheme.primary.withOpacity(0.08); // Row color when selected.
                                }
                                return null;
                              },
                            ),
                            cells: <DataCell>[
                              DataCell(Text(product.title)), // Product title cell.
                              DataCell(Text('\$${product.price.toString()}')), // Product price cell.
                              DataCell(Text(product.description ?? '')), // Product description cell.
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100], // Background color for creation date.
                                    borderRadius: BorderRadius.circular(8.0), // Rounded corners.
                                  ),
                                  child: Text(creationDate), // Creation date text.
                                ),
                              ),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100], // Background color for update date.
                                    borderRadius: BorderRadius.circular(8.0), // Rounded corners.
                                  ),
                                  child: Text(updateDate), // Update date text.
                                ),
                              ),
                            ],
                            selected: state.selected[state.products.indexOf(product)], // Row selection state.
                            onSelectChanged: (bool? value) {
                              notifier.setSelectedIndex(state.products.indexOf(product), value!); // Updating selection state.
                            },
                          );
                        }).toList(),
                      ),
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