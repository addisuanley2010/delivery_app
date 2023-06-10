import 'package:delivery/pages/registerShope.dart';
import 'package:delivery/screens/select_role.dart';
import 'package:flutter/material.dart';

class LicenseAgreementPage extends StatefulWidget {
  @override
  _LicenseAgreementPageState createState() => _LicenseAgreementPageState();
}

class _LicenseAgreementPageState extends State<LicenseAgreementPage> {
  bool _agreedToTerms = false;

  void _toggleAgreement(bool? value) {
    setState(() {
      _agreedToTerms = value ?? false;
    });
  }

  void _navigateToRegisterPage() {
    if (_agreedToTerms) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectRoleScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Agreement Not Accepted'),
            content: const Text(
                'Please read and accept the license agreement to proceed.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('License Agreement and business rule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/food-delivery-marker.png',
                  height: 150),
              const Text(
                'Welcome to Our Delivery App!',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Our delivery app is designed to make your shopping experience convenient and hassle-free. With our app, you can easily browse and order products from various shops, and have them delivered right to your doorstep. This document will provide an overview of the key features and functionality available in our app.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'User Registration and Login',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'To access the full features of our delivery app, users are required to create an account and log in. Registration is a simple process that involves providing basic information such as your name, email address, and contact details. Once registered, you can log in securely using your credentials for future access.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Shop Selection',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Our delivery app offers a wide range of shops where you can order products. Upon logging in, you will have the option to select a specific shop from the available list. Each shop may have its own unique inventory and product offerings. You can explore the different shops and choose the one that suits your preferences.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Product Ordering',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Once you have selected a shop, you can start browsing the available products. Our app provides a user-friendly interface that allows you to view detailed product information, including images, descriptions, and prices. To place an order, simply add the desired products to your cart and proceed to checkout.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Secure Payment Options',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We understand the importance of secure transactions, which is why our delivery app supports various payment methods. You can securely make payments using credit/debit cards, mobile wallets, or other available payment options. Our app ensures the privacy and security of your payment information throughout the transaction process.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Order Tracking and Delivery',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Once your order is confirmed, you can easily track its status within the app. We provide real-time updates, including order preparation, dispatch, and estimated delivery time. Our efficient delivery network ensures that your products are delivered promptly and safely to your specified location. You can also contact our customer support team for any delivery-related queries or concerns.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Product Reviews and Returns',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We value your feedback and want to ensure your satisfaction with the products you order. After receiving your order, you have the opportunity to leave reviews and ratings for the products and the overall shopping experience. In the rare event that you are not satisfied with a product, our app offers a return policy. You can initiate a return request within the specified timeframe, and our dedicated delivery personnel will facilitate the return process.',
              ),
              const Text(
                ' Customers may return the product on the same day via the delivery person.and then they can get other product again. If the product is rejected and not to be bought, only 95% will be returned for the user.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Customer Support',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We strive to provide excellent customer support to enhance your experience with our delivery app. If you have any questions, issues, or suggestions, our friendly customer support team is available to assist you. You can reach out to us via the in-app chat feature, email, or phone, and we will promptly address your concerns.',
              ),
              const SizedBox(height: 20.0),
              const Text(
                'related with charging',
                style: TextStyle(fontSize: 25.0, color: Colors.blue),
              ),
              const Text(
                '1. Shop owners will be charged 5% of each order made through the app.',
              ),
              const SizedBox(height: 10.0),
              const Text(
                '2. Customers will be charged 5% more than the total cost of the order for delivery service.',
              ),
              const SizedBox(height: 10.0),
              const Text(
                '3. Customers may return the product on the same day via the delivery person. If the product is rejected and not to be bought, only 95% will be returned for the user.',
              ),
              const SizedBox(height: 20.0),
              CheckboxListTile(
                title: const Text(
                  'I agree to the terms and conditions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                value: _agreedToTerms,
                onChanged: _toggleAgreement,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: Text('Register'),
                onPressed: _navigateToRegisterPage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
