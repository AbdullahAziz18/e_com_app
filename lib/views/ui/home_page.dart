import 'package:e_com_app/controllers/product_provider.dart';
import 'package:e_com_app/views/shared/appstyle.dart';
import 'package:e_com_app/views/shared/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

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
              child: Container(
                padding: const EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Athletic shoes',
                      style: appStyleWithHt(
                          42, Colors.white, FontWeight.bold, 1.5),
                    ),
                    Text(
                      'Collection',
                      style: appStyleWithHt(
                          42, Colors.white, FontWeight.bold, 1.2),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    HomeWidget(
                      gender: productProvider.male,
                      tabIndex1: 0,
                    ),
                    HomeWidget(
                      gender: productProvider.female,
                      tabIndex1: 1,
                    ),
                    HomeWidget(
                      gender: productProvider.kids,
                      tabIndex1: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
