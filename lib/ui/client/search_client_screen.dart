import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/ui/admin/components/components.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/bottom_navigation_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:delivery/ui/client/details_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchClientScreen extends StatefulWidget {
  @override
  _SearchClientScreenState createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {
  late TextEditingController _searchController;
  late String address;
  List<Product> filteredProducts = [];
  List<Product> listProduct = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    Future.delayed(Duration.zero, () {
      final addressController =
          Provider.of<AddressController>(context, listen: false);
      address = addressController.address.id;
      print('addrss');

      fetchProducts(); // Call the method to fetch and populate the products list
    });
  }

  void fetchProducts() {
    Products(addressId: address).productsListByAddress.listen((snapshot) {
      if (snapshot != null) {
        setState(() {
          listProduct = snapshot;
          print('${listProduct}');
          print(address);
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    final cartController = Provider.of<CartController>(context);
    final addressController = Provider.of<AddressController>(context);
    address = addressController.address.id;
    // Products(addressId: addressController.address.id).productsList,
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context, routeFrave(page: ClientHomeScreen())),
                    child: Container(
                      height: 44,
                      child: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.0)),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            filteredProducts = List<Product>.from(
                                listProduct.where((product) => product.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase())));
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search products',
                            hintStyle: GoogleFonts.getFont('Inter',
                                color: Colors.grey)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                  child: (filteredProducts.isNotEmpty)
                      ? listProducts()
                      : _HistorySearch()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationFrave(1),
    );
  }

  Widget listProducts() {
    final addressController = Provider.of<AddressController>(context);

    return StreamBuilder<List<Product>>(
        stream: Products(addressId: addressController.address.id)
            .productsListByAddress,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          final List<Product>? listProduct = snapshot.data;
          if (snapshot.data == null) return _HistorySearch();

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return ListTile(
              title: TextCustom(
                  text: 'Without results for ${_searchController.text}'),
            );
          }

          return _ListProductSearch(listProduct: filteredProducts);
        });
  }
}

class _ListProductSearch extends StatelessWidget {
  final List<Product> listProduct;

  const _ListProductSearch({required this.listProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    routeFrave(
                        page: DetailsProductScreen(
                            product: listProduct[i], quantity: 1))),
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                scale: 8,
                                // image: AssetImage(listProduct[i].picture)
                                image: AssetImage('assets/phone/iphone.png'))),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextCustom(text: listProduct[i].name),
                            const SizedBox(height: 5.0),
                            TextCustom(
                                text: '\$ ${listProduct[i].price}',
                                color: Colors.grey),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class _HistorySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TextCustom(text: 'RECENT SEARCH', fontSize: 16, color: Colors.grey),
        SizedBox(height: 10.0),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          minLeadingWidth: 20,
          leading: Icon(Icons.history),
          title: TextCustom(text: 'phone', color: Colors.grey),
        )
      ],
    );
  }
}
