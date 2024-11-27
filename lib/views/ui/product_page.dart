import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/controllers/cart_provider.dart';
import 'package:e_com_app/controllers/favourites_provider.dart';
import 'package:e_com_app/controllers/product_provider.dart';
import 'package:e_com_app/models/sneakers_model.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/shared/check_out_button.dart';
import 'package:e_com_app/views/ui/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var productProvider = Provider.of<ProductProvider>(context);
    var favouritesProivder =
        Provider.of<FavouritesProvider>(context, listen: true);
    favouritesProivder.getFavourites();

    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: FutureBuilder<Sneakers>(
        future: productProvider.sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductProvider>(
              builder: (context, productProvider, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                productProvider.shoeSizes.clear();
                                Navigator.pop(context);
                              },
                              child: const Icon(AntDesign.close),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(Ionicons.ellipsis_horizontal),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker!.imageUrl.length,
                                controller: pageController,
                                onPageChanged: (page) {
                                  productProvider.activePage = page;
                                },
                                itemBuilder: (context, int index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: Consumer<FavouritesProvider>(
                                            builder: (context,
                                                favouriteProvider, child) {
                                              return GestureDetector(
                                                onTap: () {
                                                  if (favouriteProvider.ids
                                                      .contains(widget.id)) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const FavouritePage()),
                                                    );
                                                  } else {
                                                    favouritesProivder
                                                        .createFav({
                                                      'id': sneaker.id,
                                                      'name': sneaker.name,
                                                      'category':
                                                          sneaker.category,
                                                      'price': sneaker.price,
                                                      'image':
                                                          sneaker.imageUrl[0],
                                                    });
                                                    setState(() {});
                                                  }
                                                  setState(() {});
                                                },
                                                child: favouriteProvider.ids
                                                        .contains(sneaker.id)
                                                    ? const Icon(
                                                        AntDesign.heart,
                                                      )
                                                    : const Icon(
                                                        AntDesign.hearto,
                                                        color: Colors.grey,
                                                      ),
                                              );
                                            },
                                          )),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                            sneaker.imageUrl.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productProvider
                                                            .activePage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sneaker.name,
                                            style: appStyle(35, Colors.black,
                                                FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                sneaker.category,
                                                style: appStyle(20, Colors.grey,
                                                    FontWeight.w400),
                                              ),
                                              const SizedBox(width: 20),
                                              RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  size: 18,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${sneaker.price}',
                                                style: appStyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Colors',
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor:
                                                        Colors.black,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const CircleAvatar(
                                                    radius: 7,
                                                    backgroundColor: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Select size',
                                                    style: appStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    'View size guide',
                                                    style: appStyle(
                                                        20,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                height: 40,
                                                child: ListView.builder(
                                                  itemCount: productProvider
                                                      .shoeSizes.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes =
                                                        productProvider
                                                            .shoeSizes[index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: ChoiceChip(
                                                        backgroundColor: Colors
                                                            .grey.shade200,
                                                        showCheckmark: false,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(60),
                                                        ),
                                                        side: const BorderSide(
                                                            color: Colors.black,
                                                            width: 0.5,
                                                            style: BorderStyle
                                                                .solid),
                                                        disabledColor:
                                                            Colors.white,
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appStyle(
                                                              18,
                                                              sizes['isSelected']
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              FontWeight.w500),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8),
                                                        selectedColor:
                                                            Colors.black,
                                                        selected:
                                                            sizes['isSelected'],
                                                        onSelected: (newState) {
                                                          if (productProvider
                                                              .sizes
                                                              .contains(sizes[
                                                                  'size'])) {
                                                            productProvider
                                                                .sizes
                                                                .remove(sizes[
                                                                    'size']);
                                                          } else {
                                                            productProvider
                                                                .sizes
                                                                .add(sizes[
                                                                    'size']);
                                                          }
                                                          print(productProvider
                                                              .sizes);
                                                          productProvider
                                                              .toggleCheck(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Divider(
                                                  indent: 10,
                                                  endIndent: 10,
                                                  color: Colors.black),
                                              const SizedBox(height: 10),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Text(
                                                  sneaker.title,
                                                  style: appStyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w700),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                sneaker.description,
                                                textAlign: TextAlign.justify,
                                                maxLines: 4,
                                                style: appStyle(14, Colors.grey,
                                                    FontWeight.normal),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12),
                                                  child: CheckOutButton(
                                                    onTap: () async {
                                                      cartProvider.createCart({
                                                        'id': sneaker.id,
                                                        'name': sneaker.name,
                                                        'category':
                                                            sneaker.category,
                                                        'sizes': productProvider
                                                            .sizes,
                                                        'imageUrl':
                                                            sneaker.imageUrl,
                                                        'price': sneaker.price,
                                                        'qty': 1,
                                                      });
                                                      productProvider.sizes
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    label: 'Add to Cart',
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
