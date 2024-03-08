import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

class Api {
  String? status, message;
  List<dynamic>? data;

  Api({this.status, this.message, this.data});

  factory Api.result(dynamic object) {
    return Api(
        status: object['status'],
        message: object['message'],
        data: object['data']);
  }

  static Future<Api?> getData(BuildContext context, String url) async {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
      contentType: "application/json;charset=utf-8",
    );

    Dio dio = Dio(options);

    try {
      Response response = await dio.get(url);

      Api? apiResponse;

      if (response.statusCode == 200) {
        dynamic listData = response.data;

        apiResponse = Api.result(listData);
      } else {
        dynamic listData = {
          "status": "failed",
          "message": "Koneksi Bermasalah",
          "data": null
        };

        apiResponse = Api.result(listData);
      }
      g.Get.snackbar(
        apiResponse.status!,
        apiResponse.message!,
        colorText: Colors.white,
        backgroundColor: apiResponse.status == "success"
            ? Colors.green[900]
            : Colors.red[900],
      );
      return apiResponse;
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Center(
              child: Text("Terdapat Error"),
            ),
            content: Text(
              e.toString(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  g.Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                ),
                child: const Text(
                  "Tutup",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      }

      dynamic listData = {
        "status": "failed",
        "message": "Error ${e.toString()}",
        "data": null
      };

      Api data = Api.result(listData);

      return data;
    }
  }

  static Future<Api?> postData(
      BuildContext context, String url, var data) async {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
      contentType: "application/json;charset=utf-8",
    );

    Dio dio = Dio(options);

    try {
      Response response = await dio.post(url, data: data);

      Api? apiResponse;

      if (response.statusCode == 200) {
        dynamic listData = response.data;

        apiResponse = Api.result(listData);
      } else {
        dynamic listData = {
          "status": "failed",
          "message": "Koneksi Bermasalah",
          "data": null
        };

        apiResponse = Api.result(listData);
      }
      g.Get.snackbar(
        apiResponse.status!,
        apiResponse.message!,
        colorText: Colors.white,
        backgroundColor: apiResponse.status == "success"
            ? Colors.green[900]
            : Colors.red[900],
      );
      return apiResponse;
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Center(
              child: Text("Terdapat Error"),
            ),
            content: Text(
              e.toString(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  g.Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                ),
                child: const Text(
                  "Tutup",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      }

      dynamic listData = {
        "status": "failed",
        "message": "Error ${e.toString()}",
        "data": null
      };

      Api data = Api.result(listData);

      return data;
    }
  }

  static Future<Api?> postDataMultiPart(
      BuildContext context, String url, FormData formData) async {
    BaseOptions options = BaseOptions(
      baseUrl: url,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 30),
      contentType: "application/json;charset=utf-8",
    );

    Dio dio = Dio(options);

    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      Api? apiResponse;

      if (response.statusCode == 200) {
        dynamic listData = response.data;

        apiResponse = Api.result(listData);
      } else {
        dynamic listData = {
          "status": "failed",
          "message": "Koneksi Bermasalah",
          "data": null
        };

        apiResponse = Api.result(listData);
      }
      g.Get.snackbar(
        apiResponse.status!,
        apiResponse.message!,
        colorText: Colors.white,
        backgroundColor: apiResponse.status == "success"
            ? Colors.green[900]
            : Colors.red[900],
      );
      return apiResponse;
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Center(
              child: Text("Terdapat Error"),
            ),
            content: Text(
              e.toString(),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  g.Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[900],
                ),
                child: const Text(
                  "Tutup",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        );
      }

      dynamic listData = {
        "status": "failed",
        "message": "Error ${e.toString()}",
        "data": null
      };

      Api data = Api.result(listData);

      return data;
    }
  }
}
