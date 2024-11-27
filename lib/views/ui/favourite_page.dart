import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com_app/controllers/favourites_provider.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    var favouritesProivder =
        Provider.of<FavouritesProvider>(context, listen: true);
    favouritesProivder.getAllData();
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_image.png'),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'My Favourites',
                  style: appStyle(36, Colors.white, FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: favouritesProivder.fav.length,
                padding: const EdgeInsets.only(top: 100),
                itemBuilder: (context, index) {
                  final shoe = favouritesProivder.fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade500,
                                spreadRadius: 5,
                                blurRadius: 0.3,
                                offset: const Offset(0, 1)),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe['imageUrl'] != null &&
                                            shoe['imageUrl'].isNotEmpty
                                        ? shoe['imageUrl']
                                        : 'https://example.com/placeholder.png', // Replace with a valid placeholder URL
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.fill,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe['name'],
                                        style: appStyle(
                                            16, Colors.black, FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        shoe['category'],
                                        style: appStyle(
                                            14, Colors.grey, FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${shoe['price']}',
                                            style: appStyle(18, Colors.black,
                                                FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GestureDetector(
                                onTap: () {
                                  favouritesProivder.deleteFav(shoe['key']);
                                  favouritesProivder.ids.removeWhere(
                                      (element) => element == shoe['id']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mainscreen()));
                                },
                                child: const Icon(Ionicons.md_heart_dislike),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
