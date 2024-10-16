import 'package:flutter/material.dart';
import 'package:project/widget/customdropdown.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilter;
  final Map<String, dynamic> initialFilters;

  const CustomBottomSheet(
      {super.key, required this.onFilter, required this.initialFilters});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  int _selectedOption = -1;
  String? _selectedValue;
  double _minPrice = 0.0;
  double _maxPrice = 100000.0;

  final List<String> _dropdownItems = [
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '1X',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '2X',
    '2Y',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '3X',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '77',
    '80',
    '88',
    'X0',
    'X1',
    'X2',
    'X5',
    'X7',
    'X9',
    'XX',
    'XY'
  ];

  List<String> options = [
    'ONE DIGIT',
    'TWO DIGIT',
    'THREE DIGIT',
    'FOUR DIGIT',
    'FIVE DIGIT'
  ];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialFilters['code'] ?? '';
    _selectedOption = options.indexOf(widget.initialFilters['digits'] ?? '');
    _minPrice = widget.initialFilters['minPrice'] ?? 0.0;
    _maxPrice = widget.initialFilters['maxPrice'] ?? 100000.0;
  }

  void _applyFilter() {
    Map<String, dynamic> filters = {
      'code': _selectedValue,
      'digits': _selectedOption == -1 ? null : options[_selectedOption],
      'minPrice': _minPrice,
      'maxPrice': _maxPrice
    };
    widget.onFilter(filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? screenHeight * .65
          : screenHeight * .9,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        color: Color(0xffffffff),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 4,
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 51
                  : 102,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 20),
                child: const Text(
                  "Filter by price",
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: _applyFilter,
                child: Container(
                  height: 32,
                  width: 100,
                  margin: const EdgeInsets.only(right: 20, top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: const Center(
                    child: Text(
                      "Apply Filter",
                      style: TextStyle(
                          fontFamily: 'Work Sans',
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ],
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0.0,
            max: 100000.0,
            divisions: 100,
            onChanged: (RangeValues values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
            labels: RangeLabels(
              _minPrice.toString(),
              _maxPrice.toString(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "Price: JOD ${_minPrice.toStringAsFixed(2)} - JOD ${_maxPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              "Filter by Code",
              style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: screenWidth * .86,
              height: 50,
              margin: const EdgeInsets.only(right: 10, left: 15),
              child: DropdownButtonHideUnderline(
                child: CustomDropdown(
                  items: _dropdownItems,
                  value: _selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: const Text(
              "Filter by Digits",
              style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                String option = options[index];
                return CheckboxListTile(
                  title: Text(
                    option,
                    style: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 10),
                  value: _selectedOption == index,
                  fillColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.black;
                      }
                      return Colors.grey.withOpacity(0.4);
                    },
                  ),
                  activeColor: Colors.white,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _selectedOption = index;
                      } else {
                        _selectedOption = -1;
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedOption = -1;
                    _selectedValue = '';
                    _minPrice = 0.0;
                    _maxPrice = 100000.0;
                  });
                  _applyFilter();
                },
                child: const Text(
                  "Clear all filters",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
