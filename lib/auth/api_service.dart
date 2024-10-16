import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String _baseUrl = "https://app.raqamak.vip";
  final String _baseUrl2 = "http://192.168.0.100/raqamak";

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final String url = "$_baseUrl/?rest_route=/simple-jwt-login/v1/auth";

    final String username = 'xxxrpenggd';
    final String password = 'g3jsnGSrUR';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    // print("body $body");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: jsonEncode(body),
      );

      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      // print("Error: $e");
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    final String url = "$_baseUrl/wp-json/custom-plugin/usermanage";

    const String username = 'xxxrpenggd';
    const String password = 'g3jsnGSrUR';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    print("UserData: ${jsonEncode(userData)}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: jsonEncode(userData),
      );

      print("signup Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // var data = jsonDecode(response.body);
        // if (data['error'] != '') {
        //   Map<String, dynamic> error = {"data": '1'};
        //   return error;
        // }
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to sign up: ${response.body}');
      }
    } catch (e) {
      // print("Error: $e");
      throw Exception('Signup failed: $e');
    }
  }

  Future<dynamic> fetchbillingdetails(String user_id) async {
    final String url =
        "$_baseUrl/wp-json/app/v1/user/getbillingdetails?user_id=$user_id";
    // print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("UserData: ${response.body}");
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<List<dynamic>> fetchProductlistnew(
      String categoryName, String user_id) async {
    final String url =
        "$_baseUrl/wp-json/app/v1/products?category_name=$categoryName&user_id=$user_id";
    // print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("fetchProductlistnew: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body;
    } else if (jsonDecode(response.body)['code'] == "no_data") {
      List<dynamic> body = [
        {"status": true}
      ];
      return body;
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<List<dynamic>> getProductdetailsnew(
      String product_id, String user_id) async {
    final String url =
        "$_baseUrl/wp-json/app/v1/product/product-name/?product_id=$product_id&user_id=$user_id";
    // print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("product_id: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to fetch product_id');
    }
  }

  Future<dynamic> fetchUserdetails(String user_id) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/details?user_id=$user_id";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("fetchUser details : ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to fetch user Details');
    }
  }

  update_user_details(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/update-details";

    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    if (response.statusCode == 200) {
      print("Update user Details response ${response.body}");
      return response.body;
    } else {
      throw Exception('Failed to Update user details');
    }
  }

  Future<List<dynamic>> fetchAuctions(String userId) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/auctions?user_id=$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("fetchAuctions Data: ${response.statusCode}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  fetch_Orders(String userId) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/orders?user_id=$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    print("fetch_Orders Data: ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  fetchOrderDetails(String orderId) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/order?id=$orderId";
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    print("fetchOrderDetails: ${response.body}");
    if (response.statusCode == 200) {
      // List<dynamic> body = jsonDecode(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  order_refund(String orderId) async {
    final String url = "$_baseUrl/wp-json/app/v1/refund/$orderId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    print("order_refund Data: ${response.body}");
    if (response.statusCode == 200) {
      return (response.body);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<List<dynamic>> fetch_watchlists(String userId) async {
    final String url =
        "$_baseUrl/wp-json/app/v1/user/watchlist?user_id=$userId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        // "Authorization":
        //     "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    // print("fetch_watchlists: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body;
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  add_to_watchlists(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/add-to-watchlists/";

    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    // print("add_to_watchlists ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add in watchlist');
    }
  }

  pay_fee(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/pay-fee";
    print("pay_fee response: ${body}");
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("pay_fee response: ${response.body}");
    if (response.statusCode == 200) {
      var newresponse = response.body;

      return newresponse;
    } else {
      throw Exception('Failed to pay_fee');
    }
  }

  place_bid(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/placebid";

    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("place_bid: ${response.body}");
    if (response.statusCode == 200) {
      var newresponse = jsonDecode(response.body);
      return newresponse;
    } else {
      throw Exception('Failed to add in watchlist');
    }
  }

  changeOrderStatus(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/ordercomplete";
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("changeOrderStatus ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to changeOrderStatus');
    }
  }

  orderprocess(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/orderprocess";
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add in watchlist');
    }
  }

  buy_now(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/buy-now";
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("buy now API Service ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to buy_now');
    }
  }

  paymentRequest(body) async {
    final String url = "https://secure-jordan.paytabs.com/payment/request";
    print("body ${jsonDecode(body)}");
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "authorization": "S6J9RZKLK2-JJHGBGBM2Z-DZ2TTBRBWZ",
          "Content-Type": "application/json"
        },
        body: body);
    print("paymentRequest ${response.body}");
    if (response.statusCode == 200) {
      var newresponse = response.body;

      return newresponse;
    } else {
      throw Exception('Failed paymentRequest');
    }
  }

  fetchProfilePhoto(String userId) async {
    final String url = "$_baseUrl/wp-json/app/v1/getphoto/$userId";
    print(url);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Basic ${base64Encode(utf8.encode('xxxrpenggd:g3jsnGSrUR'))}",
      },
    );
    print("fetchProfilePhoto: ${response.body}");
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<String> uploadProfilePhoto(String userId, File photo) async {
    final String url = "$_baseUrl/wp-json/app/v1/upload-profile-pic";

    // Create a multipart request
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Add fields to the request
    request.fields['user_id'] = userId;

    // Add the file to the request
    request.files
        .add(await http.MultipartFile.fromPath('user_pic', photo.path));

    // Set the headers
    request.headers.addAll({
      "Accept": "multipart/form-data",
      "Content-Type": "multipart/form-data",
      "Authorization": 'Basic eHh4cnBlbmdnZDpnM2pzbkdTclVS',
    });

    // Send the request
    final response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print("Upload profile photo response: $responseBody");
      return responseBody;
    } else {
      throw Exception('Failed to upload profile photo');
    }
  }

  forgotPassword(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/forgot-password";

    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("forgot_password: ${response.body}");
    if (response.statusCode == 200) {
      var newresponse = jsonDecode(response.body);
      return newresponse;
    } else {
      throw Exception('Failed to add in watchlist');
    }
  }

  payNow(body) async {
    final String url = "$_baseUrl/wp-json/app/v1/user/buy-now";
    final response = await http.post(Uri.parse('${url}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: body);
    print("Pay now API Service ${response.body}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to buy_now');
    }
  }

  static getdata(key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //print(key);
    //print(preferences.getString(key));
    return preferences.getString(key);
  }

  static saveData(data, sessionid, logindata) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('sessionid', sessionid);
    preferences.setString('userdata', data);
    preferences.setString('logindata', logindata);
  }

  static saveSessiondata(key, data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, data);
  }

  static removeSessionData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}
