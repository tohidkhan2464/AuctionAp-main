import 'package:flutter/material.dart';
import 'package:project/widget/order_card_list_widget.dart';
// import 'package:project/widget/bid_cardlist_Widget.dart';

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF5F5F5),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: CustomOrderCardListWidget(),
          );
        }),
      ),
    );
  }
}
