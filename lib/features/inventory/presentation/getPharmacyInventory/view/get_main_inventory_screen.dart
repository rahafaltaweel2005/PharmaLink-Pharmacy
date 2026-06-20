import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../medicine/presentation/getMedicineById/view/get_medicine_by_id_screen.dart';
import '../cubit/get_pharmacy_inventory_cubit.dart';
import '../state/get_pharmacy_inventory_state.dart';
import '../widget/pharma_card.dart';

class GetPharmacyInventoryScreen extends StatefulWidget {
  const GetPharmacyInventoryScreen({super.key});

  @override
  State<GetPharmacyInventoryScreen> createState() =>
      _GetPharmacyInventoryScreenState();
}

class _GetPharmacyInventoryScreenState
    extends State<GetPharmacyInventoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetPharmacyInventoryCubit>().getPharmacyInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inventory",
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded, size: 26),
          ),
        ],
      ),

      body: BlocConsumer<GetPharmacyInventoryCubit, GetPharmacyInventoryState>(
        listener: (context, state) {},

        builder: (context, state) {
          if (state is GetPharmacyInventoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetPharmacyInventoryErrorState) {
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

          if (state is GetPharmacyInventoryLoadedState) {
            final inventory = state.inventory;

            if (inventory.isEmpty) {
              return const Center(
                child: Text(
                  'No inventory found',

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280),
                  ),
                ),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),

              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

              itemCount: inventory.length,

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

                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: PharmaCard(inventory: state.inventory[index]),
                      ),

                  ),
                );
              },
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
