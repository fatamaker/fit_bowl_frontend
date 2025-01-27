import 'package:fit_bowl_2/presentation/controllers/supplement_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOnOption extends StatefulWidget {
  final String suppId;
  final Set<String> selectedSupplements;

  const AddOnOption({
    super.key,
    required this.suppId,
    required this.selectedSupplements,
    required String name,
    required double price,
    double? calories,
  });

  @override
  State<AddOnOption> createState() => _AddOnOptionState();
}

class _AddOnOptionState extends State<AddOnOption> {
  late final SupplementController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _controller.getSupplementById(widget.suppId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplementController>(
      builder: (controller) {
        if (controller.supplement == null) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Text(
            'Failed to load supplement for ID ${widget.suppId}',
            style: const TextStyle(color: Colors.red),
          );
        } else {
          final supplement = controller.supplement;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${supplement!.name} +${supplement.price}D +${supplement.calories}cal',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Checkbox(
                value: widget.selectedSupplements.contains(widget.suppId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      widget.selectedSupplements.add(widget.suppId);
                    } else {
                      widget.selectedSupplements.remove(widget.suppId);
                    }
                  });
                },
              ),
            ],
          );
        }
      },
    );
  }
}
