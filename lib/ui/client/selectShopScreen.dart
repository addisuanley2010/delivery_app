import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/services/locationService.dart';
import 'package:delivery/ui/client/client_home.dart';
import 'package:delivery/ui/client/component/animation_route.dart';
import 'package:delivery/ui/client/component/shimmer_frave.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    final address = Provider.of<AddressController?>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const TextCustom(text: 'list of nearest shopes ', fontSize: 20),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: ColorsFrave.primaryColor, size: 17),
              TextCustom(
                  text: 'Back', fontSize: 17, color: ColorsFrave.primaryColor)
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<Address>?>(
          stream: ListShopesService(uid: user!.uid).getAddress,
          builder: (context, snapshot) => (!snapshot.hasData)
              ? Column(
                  children: const [
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                    SizedBox(height: 10.0),
                    ShimmerFrave(),
                  ],
                )
              : _ListAddressesClient(listAdresses: snapshot.data!)),
    );
  }
}

class _ListAddressesClient extends StatelessWidget {
  final List<Address> listAdresses;

  const _ListAddressesClient({required this.listAdresses});

  @override
  Widget build(BuildContext context) {
    final addressController = Provider.of<AddressController?>(context);
    final cartController = Provider.of<CartController?>(context);
    return (listAdresses.isNotEmpty)
        ? ListView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            itemCount: listAdresses.length,
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => {
                if (listAdresses[i].id != addressController!.address.id)
                  {
                    cartController!.clear(),
                  },
                addressController.setAddress(
                    listAdresses[i].id,
                    listAdresses[i].name,
                    listAdresses[i].lat,
                    listAdresses[i].long),
                Navigator.push(context, routeFrave(page: ClientHomeScreen()))
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                padding: const EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('የሱቅ ስም',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansEthiopic')),
                        Text(listAdresses[i].name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansEthiopic')),
                      ],
                    ),
                    const Divider(
                      height: 3,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ርቀት በ ኪ.ሜ',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'NotoSansEthiopic')),
                        Text(
                            '${listAdresses[i].distance.toStringAsFixed(2)} KM',
                            style: const TextStyle(
                                fontSize: 20,
                                color: ColorsFrave.secundaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'NotoSansEthiopic')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const TextCustom(
            text: 'No Location is added',
            fontSize: 40,
            fontWeight: FontWeight.w500);
  }
}
