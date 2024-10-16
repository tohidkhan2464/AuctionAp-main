import 'package:flutter/material.dart';

class MobileBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilter;
  final Map<String, dynamic> initialFilters;

  const MobileBottomSheet(
      {super.key, required this.onFilter, required this.initialFilters});

  @override
  State<MobileBottomSheet> createState() => _MobileBottomSheetState();
}

class _MobileBottomSheetState extends State<MobileBottomSheet> {
  int _selectedOption = -1;
  double _minPrice = 0.0;
  double _maxPrice = 50000.0; // Updated max price to 50000

  List<String> options = ['ORANGE', 'COUPLES', 'TRIPLETS', 'UMNIAH', 'ZAIN'];

  @override
  void initState() {
    super.initState();
    _selectedOption =
        options.indexOf(widget.initialFilters['service_provider'] ?? '');
    _minPrice = widget.initialFilters['minPrice'] ?? 0.0;
    _maxPrice = widget.initialFilters['maxPrice'] ??
        50000.0; // Updated max price to 50000
  }

  void _applyFilter() {
    Map<String, dynamic> filters = {
      'service_provider':
          _selectedOption == -1 ? null : options[_selectedOption],
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
          ? screenHeight * .58
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
                      fontSize: 20,
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
            max: 50000.0, // Updated max value to 50000
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
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "Price: JOD ${_minPrice.toStringAsFixed(2)} - JOD ${_maxPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontFamily: 'Work Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              "Filter by Service Provider",
              style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                    _minPrice = 0.0;
                    _maxPrice = 50000.0; // Updated reset max price to 50000
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
