import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class FilterAndSearchField extends StatelessWidget {
  const FilterAndSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(IconlyBroken.search),
                hintText: 'Search near by facility',
                isDense: true,
                contentPadding: const EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton.filled(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.teal, // Change the button background color
                foregroundColor: Colors.white, // Change the filter icon color
              ),
              icon: const Icon(
                IconlyBroken.filter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
