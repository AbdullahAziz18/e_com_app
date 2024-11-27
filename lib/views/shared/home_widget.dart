import 'package:e_com_app/controllers/product_provider.dart';
import 'package:e_com_app/models/sneakers_model.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/shared/new_shoes.dart';
import 'package:e_com_app/views/shared/product_card.dart';
import 'package:e_com_app/views/ui/product_by_category.dart';
import 'package:e_com_app/views/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> gender,
    required this.tabIndex1,
  }) : _male = gender;

  final Future<List<Sneakers>> _male;
  final int tabIndex1;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                final male = snapshot.data;
                return ListView.builder(
                    itemCount: male!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          productProvider.shoesSizes = shoe.sizes;
                          productProvider.getShoes(shoe.category, shoe.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                  id: shoe.id, category: shoe.category),
                            ),
                          );
                        },
                        child: ProductCard(
                            name: shoe.name,
                            price: '\$${shoe.price}',
                            id: shoe.id,
                            category: shoe.category,
                            image: shoe.imageUrl[0]),
                      );
                    });
              }
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Latest Shoes',
                    style: appStyle(24, Colors.black, FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductByCategory(
                            tabIndex: tabIndex1,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Show All',
                          style: appStyle(22, Colors.black, FontWeight.w500),
                        ),
                        const Icon(
                          AntDesign.caretright,
                          size: 22,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.13,
          child: FutureBuilder(
            future: _male,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              } else {
                final male = snapshot.data;
                return ListView.builder(
                    itemCount: male!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final shoe = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewShoes(imageurl: shoe.imageUrl[1]),
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}
