import 'package:crud_api_app/RestApi/RestClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';
import 'ProductCreateScreen.dart';
import 'ProductUpdateScreen.dart';

class ProductGridViewScreen extends StatefulWidget {
  const ProductGridViewScreen({super.key});

  @override
  State<ProductGridViewScreen> createState() => _ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen> {
  List products = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    callData();
  }

  callData() async {
    isLoading = true;
    var data = await GetProduct();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  DeleteItem(id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Delete"),
              content: const Text("Are you sure you want to delete this item?"),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                OutlinedButton(
                    onPressed: () async {
                      // first we need to pop the screen
                      // second loading screen will be show
                      // third call the delete api
                      // fourth call the data again

                      Navigator.of(context).pop();
                      setState(() {
                        isLoading = true;
                      });
                      await DeleteProduct(id);
                      await callData();
                    },
                    child: const Text("Delete")),
              ]);
        });
  }

  GoToUpdate(context, productItem) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProductUpdateScreen(productItem);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorDarkBlue,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorDarkBlue,
          title: const Text(
            " Product Screen",
            style: TextStyle(color: colorWhite),
          )),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())

          // refreshindicator will be used to swipe screen to refresh screen data
          : RefreshIndicator(
              onRefresh: () async {
                await callData();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Image.network(
                                products[index]["Img"],
                                fit: BoxFit.fill,
                                width: double.infinity,
                              )),
                              Text(products[index]["ProductName"]),
                              const SizedBox(height: 5),
                              // ignore: prefer_interpolation_to_compose_strings
                              Text(
                                  "${"Price:" + products[index]["UnitPrice"]}Taka"),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          GoToUpdate(context, products[index]);
                                        },
                                        child: const Icon(
                                            CupertinoIcons
                                                .ellipsis_vertical_circle,
                                            size: 12,
                                            color: colorGreen)),
                                    OutlinedButton(
                                        onPressed: () {
                                          DeleteItem(products[index]["_id"]);
                                        },
                                        child: const Icon(CupertinoIcons.delete,
                                            size: 12, color: colorRed)),
                                  ]),
                              const SizedBox(height: 5),
                            ]),
                      );
                    }),
              ),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProductCreateScreen();
            }));
          },
          child: const Icon(Icons.add)),
    );
  }
}
