// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_project/screens/signin_screen.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           child: Text("Logout"),
//           onPressed: () {
//             FirebaseAuth.instance.signOut().then((value) {
//               print("Signed Out");
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => SignInScreen()));
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'checkout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<ProductData> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productList.addAll([
      ProductData(
          title: "Sport Shirt",
          amount: "1500",
          originalAmount: "1500",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Shoes Sneaker",
          amount: "2000",
          originalAmount: "2000",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Wrist Watch",
          amount: "1000",
          originalAmount: "1000",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Casual Shirt",
          amount: "3000",
          originalAmount: "3000",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Jacket",
          amount: "500",
          originalAmount: "500",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Sun Glasses",
          amount: "5000",
          originalAmount: "5000",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Sport Shirt",
          amount: "1500",
          originalAmount: "1500",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
      ProductData(
          title: "Pent",
          amount: "6000",
          originalAmount: "6000",
          image: "",
          quantity: "1",
          description: "Smoth stuff, wash and wear, good qaulity"),
    ]);
  }

  List<ProductData> cartProducts = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
          actions: [
            Container(
                child: Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                      onPressed: () {
                        if(cartProducts.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckOutScreen(
                                        cartItems: cartProducts,
                                      )));
                        }
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.redAccent),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(cartProducts.length.toString() ?? "0"),
                      ),
                    )
                  ],
                ))
          ],
        ),
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: EdgeInsetsDirectional.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productList[index].title ?? "",
                          ),
                          Text(
                            productList[index].amount ?? "",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      subtitle: Text(productList[index].description ?? ""),
                      // leading: Image.asset(productList[index].image ?? ""),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              if (cartProducts != null &&
                                  cartProducts.isNotEmpty) {
                                // for (var cart in cartProducts) {
                                if (!cartProducts
                                    .contains(productList[index])) {
                                  cartProducts.add(productList[index]);
                                }
                                // }
                              } else {
                                cartProducts.add(productList[index]);
                              }
                            });
                          },
                          icon: Icon(Icons.add)),
                    ),
                  );
                })),
      ),
    );
  }
}

class ProductData {
  String? title;
  String? description;
  String? amount;
  String? originalAmount;
  String? image;
  String? quantity;

  ProductData(
      {this.title, this.image, this.amount, this.description, this.quantity,this.originalAmount});
}
