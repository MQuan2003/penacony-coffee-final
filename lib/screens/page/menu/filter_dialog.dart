import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialSortOption;
  final List<String> initialSelectedCategories;
  final List<String> categories;

  const FilterBottomSheet({
    super.key,
    required this.initialSortOption,
    required this.initialSelectedCategories,
    required this.categories,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String selectedSortOption;
  late List<String> selectedCategories;

  @override
  void initState() {
    super.initState();
    selectedSortOption = widget.initialSortOption;
    selectedCategories = List.from(widget.initialSelectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort & Filter',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          // Phần sắp xếp
          const Text('Sort by:'),
          DropdownButton<String>(
            value: selectedSortOption,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedSortOption = value;
                });
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'A - Z',
                child: Text('A - Z'),
              ),
              DropdownMenuItem(
                value: 'Z - A',
                child: Text('Z - A'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Phần lọc danh mục
          const Text('Filter categories:'),
          Wrap(
            spacing: 8.0,
            children: widget.categories.map((category) {
              final isSelected = selectedCategories.contains(category);
              return FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedCategories.add(category);
                    } else {
                      selectedCategories.remove(category);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          // Nút Apply
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'sortOption': selectedSortOption,
                'categories': selectedCategories,
              });
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}
