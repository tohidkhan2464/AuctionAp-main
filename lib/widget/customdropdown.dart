import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: widget.onChanged,
      itemBuilder: (BuildContext context) {
        return widget.items.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.value == null || widget.value!.isEmpty
                  ? 'Select any code'
                  : widget.value!,
              style: TextStyle(
                fontSize: 14,
                color: widget.value == null || widget.value!.isEmpty
                    ? Colors.grey
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
