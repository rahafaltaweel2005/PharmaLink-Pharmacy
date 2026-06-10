import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/constant/color_const.dart';
import '../../../domain/entity/medicine_entity.dart';

class PharmaCard extends StatelessWidget {
  final MedicineEntity medicine;

  const PharmaCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final imagePath = medicine.imageUrl;
    final isNetworkImage =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');
    final isLocalImage = imagePath.startsWith('/');
    print("imagePath = ${medicine.imageUrl}");
    print("isLocalImage = $isLocalImage");
    print("isNetworkImage = $isNetworkImage");
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
                    medicine.imageUrl,
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
                        medicine.name,

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
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF4E7E5),

                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text(
                        medicine.type.name,

                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ColorConst.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  medicine.description ?? "",

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConst.neutral,
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  '\$${medicine.price.toStringAsFixed(2)}',

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: ColorConst.primary,
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
