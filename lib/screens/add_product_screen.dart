import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:missan_app/miscellaneous/theme.dart';
import 'package:missan_app/models/category_model.dart';
import 'package:missan_app/models/product_model.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddProductScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  CroppedFile? croppedFile;

  @override
  void initState() {
    super.initState();

    productModel = Product(
        name: '',
        price: 0,
        category: '',
        productId: 0,
        description: '',
        imageName: 'noimage.jpg',
        rank: 0,
        quantity: ValueNotifier(0));
  }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  bool isClick = true;
  Future _uploadFile() async {
    final path = 'files/${croppedFile!}';
    final file = File(croppedFile!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    setState(() {
      productModel.imageName = urlDownload;
    });
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    } else {
      setState(() {
        pickedFile = result.files.first;
        if (pickedFile != null) {
          cropImage();
        }
      });
    }
  }

  void cropImage() async {
    if (pickedFile != null) {
      final cropImage = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path!,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Your Image',
              toolbarColor: appbar_bgcolor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Your Image',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      setState(() {
        croppedFile = cropImage;
        _uploadFile();
      });
    }
  }

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late Product productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Product"),
        backgroundColor: appbar_font_color,
      ),
      body: createEditUI(),
    );
  }

  Widget createEditUI() {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
        child: Column(
          children: [
            if (croppedFile == null)
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: appbar_font_color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/add_image.png",
                          cacheHeight: 100,
                          cacheWidth: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.18,
                      child: RawMaterialButton(
                        onPressed: _selectFile,
                        elevation: 2.0,
                        fillColor: appbar_bgcolor,
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.edit,
                          color: appbar_font_color,
                          size: 25.0,
                        ),
                      )),
                ],
              ),
            if (croppedFile != null)
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(
                                File(croppedFile!.path),
                              ),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.18,
                      child: RawMaterialButton(
                        onPressed: _selectFile,
                        elevation: 2.0,
                        fillColor: appbar_bgcolor,
                        shape: const CircleBorder(),
                        child: Icon(
                          Icons.edit,
                          color: appbar_font_color,
                          size: 25.0,
                        ),
                      )),
                ],
              ),
            const SizedBox(
              height: 15,
            ),
            Form(
              key: globalFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormBuilderTextField(
                    name: "Product Name",
                    keyboardType: TextInputType.text,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Please enter Product name'),
                    ]),
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Product Name",
                        labelText: "Product Name"),
                    onChanged: (newValue) {
                      setState(() {
                        productModel.name = newValue.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderTextField(
                    name: "Price",
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Please enter Price'),
                    ]),
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Price",
                        labelText: "Price "),
                    onChanged: (newValue) {
                      setState(() {
                        productModel.price = int.parse(newValue!);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderTextField(
                    name: "Product Description",
                    initialValue: productModel.description,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter Product Description",
                        labelText: "Enter Product Description "),
                    onChanged: (newValue) {
                      setState(() {
                        productModel.description = newValue.toString();
                      });
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Please enter Product Description'),
                    ]),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormBuilderDropdown(
                    name: 'Category',
                    isExpanded: true,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Category',
                        hintText: 'Select Your Category'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Please select one product type')
                    ]),
                    items: Category.allCategories.map((item) {
                      return DropdownMenuItem<String>(
                        value: item.name,
                        child: Row(
                          children: [
                            // ignore: prefer_const_constructors
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              item.name,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        productModel.category = newValue.toString();
                        for (int i = 0;
                            i < Category.allCategories.length;
                            i++) {
                          if (productModel.category ==
                              Category.allCategories[i].name) {
                            productModel.productId =
                                int.parse(Category.allCategories[i].id);
                          }
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (validateAndSave()) {
                          createProduct(
                            productModel.name,
                            productModel.price,
                            productModel.productId,
                            0,
                            productModel.description,
                            productModel.category,
                            productModel.imageName,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(appbar_font_color)),
                      child: const Text("Save"),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future createProduct(String name, int price, int productId, int rank,
      String description, String category, String imageName) async {
    final docUser = FirebaseFirestore.instance.collection('Products').doc();
    final json = {
      'category': productModel.category,
      'productId': productModel.productId,
      'imageName': productModel.imageName,
      'description': productModel.description,
      'rank': 0,
      'name': productModel.name,
      'price': productModel.price,
    };
    await docUser.set(json);
  }
}
