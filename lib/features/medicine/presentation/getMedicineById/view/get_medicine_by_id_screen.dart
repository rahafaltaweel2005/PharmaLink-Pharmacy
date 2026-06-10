import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/color_const.dart';
import '../cubit/get_medicine_by_id_cubit.dart';
import '../state/get_medicine_by_id_state.dart';

class GetMedicineByIdScreen extends StatefulWidget {
  final int id;

  const GetMedicineByIdScreen({super.key, required this.id});

  @override
  State<GetMedicineByIdScreen> createState() => _GetMedicineByIdScreenState();
}

class _GetMedicineByIdScreenState extends State<GetMedicineByIdScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetMedicineByIdCubit>().getMedicineById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,

        title: const Text(
          "Medicine Details",
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
        ),
      ),

      body: BlocBuilder<GetMedicineByIdCubit, GetMedicineByIdState>(
        builder: (context, state) {
          if (state is GetMedicineByIdLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetMedicineByIdErrorState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          if (state is GetMedicineByIdLoadedState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(34),

                      child: Image.network(
                        state.medicine.imageUrl,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),

                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Text(
                      state.medicine.type.name,

                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: ColorConst.primary,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    state.medicine.name,

                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),

                    decoration: BoxDecoration(
                      color: ColorConst.primary,
                      borderRadius: BorderRadius.circular(40),
                    ),

                    child: Text(
                      '\$${state.medicine.price.toStringAsFixed(2)}',

                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "PRODUCT DESCRIPTION",
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                      color: ColorConst.neutral,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Container(
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,

                      borderRadius: BorderRadius.circular(24),

                      border: Border.all(color: ColorConst.border, width: 1),
                    ),

                    child: Text(
                      state.medicine.description ?? "",

                      style: TextStyle(
                        height: 1.7,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),

                  const SizedBox(height: 34),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),

                      onPressed: () {},

                      child: Text(
                        "Add To Cart",

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

          return const Center(
            child: Text(
              "Something wrong",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          );
        },
      ),
    );
  }
}
