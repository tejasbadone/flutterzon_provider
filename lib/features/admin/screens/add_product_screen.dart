import 'dart:io';
import 'package:amazon_clone_flutter/common/widgets/custom_elevated_button.dart';
import 'package:amazon_clone_flutter/common/widgets/custom_textfield.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = 'addProduct';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  final OutlineInputBorder inputBorderStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black38),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  );

  List<String> productCategories = [
    'Category',
    'Mobiles',
    'Fashion',
    'Electronics',
    'Home',
    'Beauty',
    'Appliances',
    'Grocery',
    'Books',
    'Essentials',
  ];
  String category = 'Category';
  bool isLoading = false;

  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProducts() {
    if (_addProductFormKey.currentState!.validate() &&
        images.isNotEmpty &&
        category != 'Category') {
      setState(() {
        isLoading = true;
      });

      try {
        adminServices.sellProducts(
            context: context,
            name: productNameController.text,
            description: descriptionController.text,
            price: double.parse(priceController.text),
            quantity: int.parse(quantityController.text),
            category: category,
            images: images,
            onSuccess: () {
              showSnackBar(context, 'Product added succesfully!');
              Navigator.pop(context);
              setState(() {
                isLoading = false;
              });
            });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: const Text('Add product'),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _addProductFormKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      images.isNotEmpty
                          ? Column(
                              children: [
                                CarouselSlider(
                                  items: images.map((i) {
                                    return Builder(
                                        builder: (context) => Image.file(
                                              i,
                                              fit: BoxFit.cover,
                                            ));
                                  }).toList(),
                                  options: CarouselOptions(
                                    height: 200,
                                    viewportFraction: 1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton.icon(
                                    onPressed: selectImages,
                                    style: const ButtonStyle(
                                        side: MaterialStatePropertyAll(
                                            BorderSide(
                                                width: 1,
                                                color: GlobalVariables
                                                    .secondaryColor))),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add photos'))
                              ],
                            )
                          : GestureDetector(
                              onTap: selectImages,
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open_outlined,
                                        size: 40,
                                      ),
                                      Text('Select product images',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade400))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 6,
                      ),
                      CustomTextfield(
                          controller: productNameController,
                          hintText: 'Product name'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                        controller: descriptionController,
                        hintText: 'Description',
                        maxLines: 8,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                          controller: priceController, hintText: 'Price'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextfield(
                          controller: quantityController, hintText: 'Quantity'),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: inputBorderStyle,
                            enabledBorder: inputBorderStyle,
                            border: inputBorderStyle,
                          ),
                          items: productCategories.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                              ),
                            );
                          }).toList(),
                          value: category,
                          onChanged: (newVal) {
                            setState(() {
                              category = newVal!;
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomElevatedButton(
                          buttonText: 'Sell', onPressed: sellProducts),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
