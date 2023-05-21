import 'package:delivery/models/product.dart';
import 'package:delivery/services/database.dart';
import 'package:delivery/ui/admin/components/components.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/bottom_navigation_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:delivery/ui/client/details_product_screen.dart';
import 'package:flutter/material.dart';

class SearchClientScreen extends StatefulWidget {
  const SearchClientScreen({super.key});

  @override
  _SearchClientScreenState createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final productBloc = BlocProvider.of<ProductsBloc>(context);
    const searchProduct = 0;

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
                          // productBloc.add(OnSearchProductEvent(value));
                          // if (value.length != 0)
                          //   productServices.searchProductsForName(value);
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
              // BlocBuilder<ProductsBloc, ProductsState>(
              //   builder: (_, state) =>
              Expanded(
                  //child: (state.searchProduct.length != 0)
                  child:
                      (searchProduct != 0) ? listProducts() : _HistorySearch()),
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationFrave(1),
    );
  }

  // return FutureBuilder<List<Product>>(
  //     //future: ClientHomeScreen().products,
  //     builder: (_, snapshot) {
  //       final List<Product> listProduct = ClientHomeScreen().products;

  Widget listProducts() {
    return StreamBuilder<List<Product>>(
        stream: Products().productsList,
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

          // final listProduct = snapshot.data!;

          return _ListProductSearch(listProduct: listProduct!);
        });
  }
}

class _ListProductSearch extends StatelessWidget {
  //final List<Productsdb> listProduct;
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
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                scale: 8,
                                image: AssetImage(listProduct[i].picture))),
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
          title: TextCustom(text: 'Burger', color: Colors.grey),
        )
      ],
    );
  }
}
