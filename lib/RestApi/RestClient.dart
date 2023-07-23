import 'dart:convert';
import 'package:crud_api_app/style/style.dart';
import 'package:http/http.dart' as http;

Future<bool> CreateProduct(products) async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostHeader = {"Content-Type": "application/json"};
  var PostBody = json.encode(products);
  var response = await http.post(url, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody["status"] == "success") {
    SuccessToast("Product Created Successfully");
    return true;
  } else {
    FailedToast("Failed to Create Product");
    return false;
  }
}

Future<List> GetProduct() async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var postHeader = {"Content-Type": "application/json"};
  var response = await http.get(url, headers: postHeader);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody["status"] == "success") {
    return ResultBody["data"];
  } else {
    FailedToast("Failed to Get Product");
    return [];
  }
}

Future<bool> DeleteProduct(id) async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
  var PostHeader = {"Content-Type": "application/json"};

  var response = await http.get(url, headers: PostHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody["status"] == "success") {
    SuccessToast("Product Deleted Successfully");
    return true;
  } else {
    FailedToast("Failed to Delete Product");
    return false;
  }
}

Future<bool> UpdateProduct(products, id) async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/+$id");
  var PostHeader = {"Content-Type": "application/json"};
  var PostBody = json.encode(products);
  var response = await http.post(url, headers: PostHeader, body: PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);
  if (ResultCode == 200 && ResultBody["status"] == "success") {
    SuccessToast("Product Updated Successfully");
    return true;
  } else {
    FailedToast("Failed to Update Product");
    return false;
  }
}
