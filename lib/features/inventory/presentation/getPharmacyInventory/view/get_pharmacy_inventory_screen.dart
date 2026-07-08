import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/login/widget/pharma_text_field.dart';
import '../../../domain/entity/inventory_entity.dart';
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
  int currentIndex = 1;
  TextEditingController searchController = TextEditingController();
  List<InventoryEntity> allInventory = [];
  List<InventoryEntity> filteredInventory = [];


  @override
  void initState() {
    super.initState();
    context.read<GetPharmacyInventoryCubit>().getPharmacyInventory();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  void search(String searchController) {
    setState(() {
      filteredInventory = allInventory.where((inventory) {
        return inventory.medicineName.toLowerCase().contains(searchController.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPharmacyInventoryCubit, GetPharmacyInventoryState>(
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
          if (allInventory.isEmpty) {
            allInventory = state.inventory;
            filteredInventory = state.inventory;
          }
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

          return Column(
            children: [
              PharmaTextField(
                controller: searchController,
                hint: "Search by medicine name",
                prefixIcon: Icons.search_outlined,
                obscureText: false,
                onChange: (value) {
                  search(value ?? "");
                },
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),

                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

                  itemCount: filteredInventory.length,

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
                          child: PharmaCard(inventory: filteredInventory[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
    );
  }
}
