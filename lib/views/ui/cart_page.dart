import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/controllers/cart_provider.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/shared/check_out_button.dart';
import 'package:e_com_app/views/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCart();
    return Scaffold(
        backgroundColor: const Color(0xffe2e2e2),
        body: Padding(
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(AntDesign.close),
                  ),
                  Text(
                    'My Cart',
                    style: appStyle(36, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = cartProvider.cart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'] !=
                                                            null &&
                                                        data['imageUrl']
                                                            .isNotEmpty
                                                    ? data['imageUrl'][0]
                                                    : 'https://example.com/placeholder.png',
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.fill,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: -10,
                                              left: -16,
                                              child: GestureDetector(
                                                onTap: () {
                                                  cartProvider
                                                      .deleteCart(data['key']);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Mainscreen(),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(12),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    AntDesign.delete,
                                                    size: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12, left: 90),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(
                                                        14,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data['price'],
                                                        style: appStyle(
                                                            18,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Text(
                                                        'Size:',
                                                        style: appStyle(
                                                            18,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                      Text(
                                                        data['sizes'].isNotEmpty
                                                            ? data['sizes'][0]
                                                            : ' N/A',
                                                        style: appStyle(
                                                            15,
                                                            Colors.grey,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    AntDesign.minussquare,
                                                    size: 20,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Text(
                                                  data['qty'].toString(),
                                                  style: appStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Icon(
                                                    AntDesign.plussquare,
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CheckOutButton(label: 'Proceed to Checkout'),
              ),
            ],
          ),
        ));
  }
}
