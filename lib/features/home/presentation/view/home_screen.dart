import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharma_link/core/constant/svg_const.dart';

import '../../../../core/constant/color_const.dart';
import '../../../auth/presentation/profile/view/profile_screen.dart';
import '../../../cart/presentation/view/cart_screen.dart';
import '../../../inventory/presentation/getPharmacyInventory/view/get_pharmacy_inventory_screen.dart';
import '../../../medicine/presentation/getMedicine/view/get_medicines_screen.dart';
import '../../../order/presentation/getMyOrder/view/get_my_order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              SvgConst.pharmaLinkLogo,
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 10),
            const Text("PharmaLink"),
          ],
        ),
        centerTitle: false,
      ),
     body:  IndexedStack(
          index: currentIndex,
          children: [
            const GetMedicinesScreen(),
            const GetPharmacyInventoryScreen(),
            const GetMyOrderScreen(),
            const CartScreen(),
            const ProfileScreen(),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        selectedItemColor: ColorConst.primary,
        unselectedItemColor: ColorConst.neutral,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medication_outlined),
            label: 'Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'inventory',
          ), BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            label: 'order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),

        ],
      ),
    );
  }
}
