import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_link/features/order/presentation/createOrder/view/create_order_screen.dart';
import '../../../../core/constant/color_const.dart';
import '../../../medicine/presentation/getMedicineById/view/get_medicine_by_id_screen.dart';
import '../cubit/cart_cubit.dart';
import '../state/cart_state.dart';
import '../widget/pharma_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
            },
            icon: Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartStateLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartStateErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Text(
                  state.error,
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFB42318),
                  ),
                ),
              ),
            );
          }

          if (state is CartStateSuccessState) {
            final cart = state.items;
            if (cart.isEmpty) {
              return const Center(
                child: Text(
                  'No medicine found',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),

                    itemCount: state.items.length,

                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),

                        child: Material(
                          color: Theme.of(context).colorScheme.surface,

                          borderRadius: BorderRadius.circular(30),

                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),

                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (context) => GetMedicineByIdScreen(
                                    id: state.items[index].medicine.id,
                                  ),
                                ),
                              );
                            },

                            child: Padding(
                              padding: const EdgeInsets.all(8),

                              child: PharmaCard(item: state.items[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Material(
                      color: Theme.of(context).colorScheme.surface,

                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,

                          borderRadius: BorderRadius.circular(30),

                          border: Border.all(
                            color: ColorConst.border,
                            width: 1,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              " ${state.items.length} Items ",

                              style: TextStyle(
                                fontSize: 14,

                                fontWeight: FontWeight.w500,

                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${state.totalPrice.toStringAsFixed(2)}',

                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: ColorConst.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox(
            child: Center(
              child: Text(
                "Something wrong",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartStateSuccessState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOrderScreen(),
                          ),
                        );
                      },

                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox(
            child: Center(
              child: Text(
                "Something wrong",

                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
