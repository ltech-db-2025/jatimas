import 'package:flutter/material.dart';

class Item {
  final int id;
  final String name;
  final String description;

  Item({required this.id, required this.name, required this.description});
}

class DireksiPage extends StatelessWidget {
  final List<Item> items = [
    Item(id: 1, name: 'Item 1', description: 'Description of Item 1'),
    Item(id: 2, name: 'Item 2', description: 'Description of Item 2'),
    Item(id: 3, name: 'Item 3', description: 'Description of Item 3'),
    Item(id: 4, name: 'Item 4', description: 'Description of Item 4'),
  ];

  DireksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Master-Detail Table Example')),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Description')),
            ],
            rows: items
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item.id.toString())),
                      DataCell(Text(item.name)),
                      DataCell(Text(item.description)),
                    ],
                    onSelectChanged: (isSelected) {
                      if (isSelected != null && isSelected) {
                        _showItemDetail(context, item);
                      }
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showItemDetail(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Item Detail'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${item.id}'),
              const SizedBox(height: 8),
              Text('Name: ${item.name}'),
              const SizedBox(height: 8),
              Text('Description: ${item.description}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
