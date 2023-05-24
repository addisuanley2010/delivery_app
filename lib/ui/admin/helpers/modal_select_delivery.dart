import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/ui/admin/components/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:delivery/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListDeliveryModal extends StatefulWidget {
  ListDeliveryModal({super.key});

  @override
  State<ListDeliveryModal> createState() => _ListDeliveryModalState();
}

class _ListDeliveryModalState extends State<ListDeliveryModal> {
  int? selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
            height: 500,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('customers')
                          .where('role', isEqualTo: 'delivery')
                          .where('shopId', isEqualTo: user.uid)
                          .snapshots(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        return (documents.isNotEmpty)
                            ? ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                itemCount: documents.length,
                                itemBuilder: (context, i) => InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedItemIndex = i;
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: (selectedItemIndex == i)
                                          ? Colors.blue
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                documents[i].get('imageUrl'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              documents[i].get('name'),
                                              maxLines: 1,
                                              style:
                                                  GoogleFonts.getFont('Inter'),
                                            ),
                                            const SizedBox(height: 5.0),
                                            TextCustom(
                                              text: documents[i].get('phone'),
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/empty-cart.svg',
                                      height: 290,
                                    ),
                                    const SizedBox(height: 20.0),
                                    const TextCustom(
                                      text: 'Without Delivery Men',
                                      color: ColorsFrave.primaryColor,
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button functionality here
                      },
                      child: const Text('Send Order'),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
