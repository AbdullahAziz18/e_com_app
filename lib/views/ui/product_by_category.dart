import 'package:e_com_app/controllers/product_provider.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/shared/category_btn.dart';
import 'package:e_com_app/views/shared/custom_spacer.dart';
import 'package:e_com_app/views/shared/latest_shoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    'assets/images/adidas.png',
    'assets/images/gucci.png',
    'assets/images/jordan.png',
    'assets/images/nike.png',
  ];
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getMale();
    productProvider.getFemale();
    productProvider.getKid();
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/top_image.png'),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.5),
                    tabs: const [
                      Tab(
                        text: 'Men Shoes',
                      ),
                      Tab(
                        text: 'Women Shoes',
                      ),
                      Tab(
                        text: 'Kids Shoes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    LatestShoes(gender: productProvider.male),
                    LatestShoes(gender: productProvider.female),
                    LatestShoes(gender: productProvider.kids),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    // ignore: no_leading_underscores_for_local_identifiers, prefer_const_declarations
    final double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.84,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  const CustomSpacer(),
                  Text(
                    'Filter',
                    style: appStyle(40, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Text(
                    'Gender',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonClr: Colors.black,
                        label: 'Men',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Women',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Kids',
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Category',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    children: [
                      CategoryBtn(
                        buttonClr: Colors.black,
                        label: 'Shoes',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Apparrels',
                      ),
                      CategoryBtn(
                        buttonClr: Colors.grey,
                        label: 'Accessories',
                      ),
                    ],
                  ),
                  const CustomSpacer(),
                  Text(
                    'Price',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const CustomSpacer(),
                  Slider(
                    value: _value,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    thumbColor: Colors.black,
                    max: 500,
                    divisions: 50,
                    label: _value.toString(),
                    secondaryTrackValue: 200,
                    onChanged: (double value) {},
                  ),
                  const CustomSpacer(),
                  Text(
                    'Brands',
                    style: appStyle(20, Colors.black, FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: brand.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
