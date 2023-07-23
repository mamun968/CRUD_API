import 'package:crud_api_app/style/style.dart';
import 'package:flutter/material.dart';

import '../RestApi/RestClient.dart';
import 'ProductGridViewScreen.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  bool isLoading = false;
  void _submitForm() async {
    if (products["Img"]!.length == 0) {
      FailedToast("Image is required");
    } else if (products["ProductCode"]!.length == 0) {
      FailedToast("Product Code is required");
    } else if (products["ProductName"]!.length == 0) {
      FailedToast("Product Name is required");
    } else if (products["Qty"]!.length == 0) {
      FailedToast("Qty is required");
    } else if (products["TotalPrice"]!.length == 0) {
      FailedToast("Total Price is required");
    } else if (products["UnitPrice"]!.length == 0) {
      FailedToast("Unit Price is required");
    } else {
      setState(() {
        isLoading = true;
      });
      await CreateProduct(products);
    }
    setState(() {
      isLoading = false;
    });
  }
  // map key must be similar as in the api
  // we shall collect data from the text field then add to the map
  // the the map should me encoded to jason format and use post method

  Map<String, dynamic> products = {
    "Img": "",
    "ProductCode": "",
    "ProductName": "",
    "Qty": "",
    "TotalPrice": "",
    "UnitPrice": ""
  };

  InputValue(Mapkey, Textvalue) {
    products.update(Mapkey, (value) => Textvalue);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkBlue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorDarkBlue,
        title: const Text(
          "Create Product Screen",
          style: TextStyle(color: colorWhite),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProductGridViewScreen();
              }));
            },
            icon: const Icon(Icons.arrow_back, color: colorWhite)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // ScreenBack(context),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          InputValue("ProductName", value);
                        },
                        decoration: AppInputDeco("Product Name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputValue("ProductCode", Textvalue);
                        },
                        decoration: AppInputDeco("Product Code"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputValue("Img", Textvalue);
                        },
                        decoration: AppInputDeco("Product Image"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputValue("UnitPrice", Textvalue);
                        },
                        decoration: AppInputDeco("Product Unit Price"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (Textvalue) {
                          InputValue("TotalPrice", Textvalue);
                        },
                        decoration: AppInputDeco("Total Price"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppDropDown(DropdownButton(
                          value: products["Qty"],
                          isExpanded: true,
                          underline: Container(),
                          items: const [
                            DropdownMenuItem(
                              value: "",
                              child: Text("Select Quantity"),
                            ),
                            DropdownMenuItem(value: "1", child: Text("1pcs")),
                            DropdownMenuItem(value: "2", child: Text("2pcs")),
                            DropdownMenuItem(value: "3", child: Text("3pcs")),
                            DropdownMenuItem(value: "4", child: Text("4pcs")),
                          ],
                          onChanged: (Textvalue) {
                            InputValue("Qty", Textvalue);
                            setState(() {});
                          })),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: (double.infinity),
                        child: ElevatedButton(
                          onPressed: () {
                            _submitForm();
                          },
                          style: AppBtnS(),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
