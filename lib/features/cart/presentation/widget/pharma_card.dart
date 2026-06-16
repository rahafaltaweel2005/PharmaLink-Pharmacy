import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/color_const.dart';
import '../../domain/entity/cart_item_entity.dart';
import '../cubit/cart_cubit.dart';

class PharmaCard extends StatelessWidget {
  final CartItemEntity item;

  const PharmaCard({super.key, required this.item});



  @override
  Widget build(BuildContext context) {
    final imagePath = item.medicine.imageUrl;
    final isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');
    final isLocalImage = imagePath.startsWith('/');

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,

        borderRadius: BorderRadius.circular(30),

        border: Border.all(color: ColorConst.border, width: 1),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLocalImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: File(imagePath).existsSync()
                      ? Image.file(
                          File(imagePath),
                          width: 82,
                          height: 82,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 82,
                          width: 82,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F5F5),
                          ),
                          child: const Icon(
                            Icons.image_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                )
              : isNetworkImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.network(
                    item.medicine.imageUrl,
                    width: 82,
                    height: 82,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        height: 82,
                        width: 82,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF5F5F5),
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      );
                    },
                  ),
                )
              : Container(
                  height: 82,
                  width: 82,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F5F5),
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.medicine.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: ColorConst.textDark,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF4E7E5),

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            context.read<CartCubit>().decrementQuantity(item);
                          }, icon: Icon(Icons.remove)),
                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: ColorConst.primary,
                            ),
                          ),
                          IconButton(onPressed: (){
                            context.read<CartCubit>().incrementQuantity(item);
                          }, icon: Icon(Icons.add)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  '\$${item.medicine.price.toStringAsFixed(2)}',

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConst.neutral,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
