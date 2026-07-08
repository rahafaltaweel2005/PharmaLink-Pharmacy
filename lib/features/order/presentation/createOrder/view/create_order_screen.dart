
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_link/features/home/presentation/view/home_screen.dart';
import 'package:pharma_link/features/order/presentation/createOrder/cubit/create_order_cubit.dart';

import '../../../../../core/constant/color_const.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../state/create_order_state.dart';
import '../widget/pharma_text_field.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final TextEditingController locationController = TextEditingController();

  int selectedDeliveryOption = 0;

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final cartItems = cartCubit.items;
    final totalPrice = cartCubit.totalPrice;
    final size = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
          listener: (context, state) {
            if (state is CreateOrderErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                    textAlign: TextAlign.center,

                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }
            if (state is CreateOrderSuccessState) {
              showDialog(
                  context: context,
                  builder: (_) {
                   return AlertDialog(
                      title: Text(
                        "Order created successfully",
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>HomeScreen()),
                            );
                            cartCubit.clearCart();
                          },

                          child: Text("Ok"),
                        ),
                      ],
                    );

                  }

              );
            }
          },
          builder: (context, state) {
            if (state is CreateOrderLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Method",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConst.primary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDeliveryOption = 0;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: theme.colorScheme.surface,
                        border: Border.all(
                          color: selectedDeliveryOption == 0
                              ? ColorConst.primary
                              : ColorConst.border,
                          width: 1,
                        ),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            color: ColorConst.primary,
                            size: 24,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Standard Delivery",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text("3-5 Business Days"),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConst.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDeliveryOption = 1;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: theme.colorScheme.surface,
                        border: Border.all(
                          color: selectedDeliveryOption == 1
                              ? ColorConst.primary
                              : ColorConst.border,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.ac_unit_outlined,
                            color: ColorConst.primary,
                            size: 24,
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Priority Cold Chain",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text("Next Day Delivery"),
                            ],
                          ),
                          Spacer(),
                          Text(
                            "\$5",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConst.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConst.primary,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: size.height * .39,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: theme.colorScheme.surface,
                      border: Border.all(color: ColorConst.border, width: 1),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          cartItems.isEmpty
                              ? Text("No items in cart")
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Image.network(
                                      cartItems[index].medicine.imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItems[index].medicine.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Quantity: ${cartItems[index]
                                              .quantity}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConst.textDark,
                                          ),
                                        ),
                                        Text(
                                          "Price: \$${cartItems[index].medicine
                                              .price}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConst.textDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  PharmaTextField(
                    controller: locationController,
                    title: "Location",
                    hint: "Enter your location here",
                    prefixIcon: Icons.location_on_outlined,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: size.height * .2,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConst.textDark,
              ),
            ),
            Text(
              selectedDeliveryOption == 0
                  ? "\$${totalPrice.toStringAsFixed(2)}"
                  : "\$${(totalPrice + 5.0).toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: ColorConst.primary,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              onPressed: () {
                if (cartItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "No items in cart",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                  return;
                }
                context.read<CreateOrderCubit>().createOrder(
                  orderItems: cartItems
                      .map((item) => item.toOrderItemEntity())
                      .toList(),
                  notes: locationController.text,
                );
              },
              child: Text(
                "Place Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
