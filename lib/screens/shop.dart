import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qop_timbu/components/widgets/product_tile.dart';
import '../components/widgets/error_box.dart';
import '../components/widgets/product_details.dart';
import '../models/product.dart';
import '../services/api_services.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<List<Product>> futureProducts;
  List<Product> allProducts = [];
  String selectedCategory = 'All'; //initializing dropdownmenu selection

  //category dropdownmenu list
  final List<String> categories = [
    'All',
    'wears',
    'stickers',
    'journals',
    'accessories ',
    'bags',
    'gift box',
    'decor',
    'wares',
  ];

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    //Filter products by category
    List<Product> filteredProducts = (selectedCategory == 'All')
        ? List.from(allProducts)
        : allProducts
            .where((product) => product.category == selectedCategory)
            .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quills on Pages',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/bag_icon.png',
                        scale: 1.8,
                      ),
                      Positioned(
                        right: 2,
                        top: 4,
                        child: Visibility(
                          visible: productsInBag.isEmpty ? false : true,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.redAccent,
                            child: Center(
                                child: Text(
                              productsInBag.length.toString(),
                              style: const TextStyle(fontSize: 10),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Our Store',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  // CupertinoPicker(
                  //   itemExtent: null,
                  // ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (category) {
                      filterByCategory(category!);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Expanded(
                child: FutureBuilder<List<Product>>(
                  future: futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black87,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return RefreshIndicator(
                        onRefresh: () {
                          setState(() {
                            futureProducts = fetchProducts();
                            selectedCategory = categories[0];
                          });
                          return futureProducts;
                        },
                        color: Colors.black87,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: const ErrorBox(
                              message:
                                  'We\'re having some problems reaching the store. \n Please refresh',
                            ),
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const ErrorBox(
                        message:
                            'We are currently out of stock. Please check back later',
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: () {
                          setState(() {
                            futureProducts = fetchProducts();
                            selectedCategory = categories[0];
                          });
                          return futureProducts;
                        },
                        color: Colors.black87,
                        child: ListView.builder(
                          itemCount: filteredProducts.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          cacheExtent: 9999,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return ProductTile(
                              productInfo: product,
                              tapped: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  builder: (BuildContext context) {
                                    return ProductDetails(product: product);
                                  },
                                );
                              },
                              onAddToBag: () {
                                final snack = cartSnack(product.name);
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                  productsInBag.add(product.name);
                                });
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Function to get product list
  Future<List<Product>> fetchProducts() async {
    final products = await ApiService().getProducts();
    final productList = products.map((item) => Product.fromJson(item)).toList();
    setState(() {
      allProducts = productList;
    });
    return productList;
  }

  //Function to set category set
  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  //Snackbar popup on adding items to bag
  cartSnack(String productName) {
    final snack = SnackBar(
      content: Text(
        '$productName added to bag',
        style:
            const TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
      ),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 1),
    );
    return snack;
  }
}
