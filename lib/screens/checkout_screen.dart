import 'package:flutter/material.dart';

import 'home_screen.dart';

class CheckOutScreen extends StatefulWidget {
  final List<ProductData>? cartItems;

  CheckOutScreen({this.cartItems});

  @override
  _CheckOutScreenState createState() {
    return _CheckOutScreenState();
  }
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String discount = "0";
  String curencyLabel = "\$";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("CheckOut"),
            centerTitle: true,
          ),
          body: Container(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cartItems?.length,
                      itemBuilder: (context, int index) {
                        var item = widget.cartItems![index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(width: 1, color: Colors.black12)),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset("images/logo.png"),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      item.title ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              // removeQuantity(item);
                                              setState(() {
                                                int currentQauntiy = int.tryParse(
                                                    item.quantity ?? "0") ??
                                                    0;
                                                int originalAmount = int.tryParse(
                                                    item.originalAmount ??
                                                        "0") ??
                                                    0;
                                                if (currentQauntiy > 0) {
                                                  currentQauntiy -= 1;
                                                  item.quantity =
                                                      currentQauntiy.toString();
                                                  originalAmount *= currentQauntiy;
                                                  item.amount =
                                                      originalAmount.toString();
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.remove)),
                                        Text(item.quantity ?? ""),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                int currentQauntiy = int.tryParse(
                                                    item.quantity ?? "0") ??
                                                    0;
                                                int currentAmount = int.tryParse(
                                                    item.amount ?? "0") ??
                                                    0;
                                                currentQauntiy += 1;
                                                item.quantity =
                                                    currentQauntiy.toString();
                                                currentAmount *= currentQauntiy;
                                                item.amount =
                                                    currentAmount.toString();
                                              });
                                            },
                                            icon: Icon(Icons.add))
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        item.originalAmount ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        item.amount ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Disounct:"),
                          Text(discount + "%" ?? ""),
                        ],
                      ),
                      Text("-" +
                          discountedValue(widget.cartItems!) +
                          " " +
                          curencyLabel ??
                          ""),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount"),
                      Text(totalAmount(widget.cartItems!) ?? "" ?? ""),
                    ],
                  )
                ],
              )),
        ));
  }


  discountedValue(List<ProductData> totalProducts) {
    int totalAmount = 0;
    totalProducts.forEach((element) {
      totalAmount += int.tryParse(element.amount ?? "0") ?? 0;
    });
    double result = (totalAmount * 20) / 100;
    discount = result.toString();
    return discount;
  }

  totalAmount(List<ProductData> totalProducts) {
    int totalAmount = 0;
    totalProducts.forEach((element) {
      totalAmount += int.tryParse(element.amount ?? "0") ?? 0;
    });
    final actualDiscount = double.tryParse(discount) ?? 0;
    final result = (totalAmount-actualDiscount).toInt();
    return result.toString();
  }
}
