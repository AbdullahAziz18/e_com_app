import 'package:e_com_app/controllers/favourites_provider.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/ui/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.price,
      required this.id,
      required this.category,
      required this.image});

  final String name;
  final String price;
  final String id;
  final String category;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favouritesProivder =
        Provider.of<FavouritesProvider>(context, listen: true);
    favouritesProivder.getFavourites();
    bool selected = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (favouritesProivder.ids.contains(widget.id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FavouritePage()));
                        } else {
                          favouritesProivder.createFav({
                            'id': widget.id,
                            'name': widget.name,
                            'category': widget.category,
                            'price': widget.price,
                            'imageUrl': widget.image
                          });
                        }
                        setState(() {});
                      },
                      child: favouritesProivder.ids.contains(widget.id)
                          ? const Icon(AntDesign.heart)
                          : const Icon(AntDesign.hearto),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHt(
                          30, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style:
                          appStyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                      style: appStyle(24, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          'Colors',
                          style: appStyle(14, Colors.grey, FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 40, // Set width and height to be the same
                          height: 40,
                          child: ChoiceChip(
                            label: const Text(
                                ' '), // Keep label empty for a cleaner circular appearance
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                            shape: const CircleBorder(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
