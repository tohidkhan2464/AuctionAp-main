import 'package:flutter/material.dart';

class CustomMyBidsBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilter;
  final Map<String, dynamic> initialFilters;
  const CustomMyBidsBottomSheet(
      {super.key, required this.onFilter, required this.initialFilters});

  @override
  State<CustomMyBidsBottomSheet> createState() =>
      _CustomMyBidsBottomSheetState();
}

class _CustomMyBidsBottomSheetState extends State<CustomMyBidsBottomSheet> {
  int _selectedOption = -1;
  String? _selectedValue;
  double _minPrice = 300.0;
  double _maxPrice = 1500000.0;

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

  List<String> options = ['Started', 'Closed'];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialFilters['code'] ?? '';
    _selectedOption = options.indexOf(widget.initialFilters['status'] ?? '');
    _minPrice = widget.initialFilters['minPrice'] ?? 300.0;
    _maxPrice = widget.initialFilters['maxPrice'] ?? 1500000.0;
  }

  void _applyFilter() {
    Map<String, dynamic> filters = {
      'code': _selectedValue,
      'status': _selectedOption == -1 ? null : options[_selectedOption],
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
          ? screenHeight * .55
          : screenHeight * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        color: Color(0xffffffff),
      ),
      padding: EdgeInsets.all(16.0),
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
                margin: EdgeInsets.only(left: 10, top: 20),
                child: Text(
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
                  margin: EdgeInsets.only(right: 20, top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey),
                  child: Center(
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
            max: 2000000.0,
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
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "Price: JOD ${_minPrice.toStringAsFixed(2)} - JOD ${_maxPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 10, top: 10),
          //   child: Text(
          //     "Filter by Code",
          //     style: TextStyle(
          //         fontFamily: 'Work Sans',
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Center(
          //   child: Container(
          //     width: screenWidth * .86,
          //     height: 50,
          //     margin: EdgeInsets.only(right: 10, left: 15),
          //     padding: EdgeInsets.only(right: 10, left: 10),
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 1, color: Colors.black),
          //       borderRadius: BorderRadius.circular(5),
          //     ),
          //     child: DropdownButtonHideUnderline(
          //       child: DropdownButton<String>(
          //         hint: Text(
          //           'Any Plate Code',
          //           style: TextStyle(
          //               fontFamily: 'Work Sans',
          //               fontSize: 12,
          //               color: Colors.black,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         value: _selectedValue!.isEmpty ? null : _selectedValue,
          //         isExpanded: true,
          //         items: _dropdownItems.map((String value) {
          //           return DropdownMenuItem<String>(
          //               value: value,
          //               child: Text(
          //                 value,
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w500),
          //               ));
          //         }).toList(),
          //         onChanged: (String? newValue) {
          //           setState(() {
          //             _selectedValue = newValue;
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Filter by Status Type",
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
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 10),
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
                    _minPrice = 300.0;
                    _maxPrice = 1500000.0;
                  });
                  _applyFilter();
                },
                child: Text(
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
