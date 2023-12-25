import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import '../widget/input_field.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key});
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber,
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('asset/image/thumbnail.png'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      showAdaptiveActionSheet(
                        context: context,
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                              title: const Text('Choose Gallery'),
                              onPressed: (context) {}),
                          BottomSheetAction(
                              title: const Text('Open Camera'),
                              onPressed: (context) {}),
                        ],
                        cancelAction: CancelAction(
                          title: const Text('Cancel'),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 208, 208, 208),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            InputField(
              controller: nameController,
              hintText: 'Product name',
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              controller: priceController,
              hintText: 'Product price',
            ),
            const SizedBox(
              height: 15,
            ),
            InputField(
              controller: descriptionController,
              hintText: 'Product descriptions',
              maxLines: 7,
            ),
          ],
        ),
      ),
    );
  }
}
