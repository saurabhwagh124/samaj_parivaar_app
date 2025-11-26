import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:samaj_parivaar_app/utils/api_endpoints.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class UtilService extends GetxService {
  Future<num> getUserId() async {
    final data = jsonDecode(await LocalStorage.i.getUser("current_user"));
    log("${data['id']} userId");
    return data['id'];
  }

  Future<String?> uploadImage(File file) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiEndpoints.uploadImage),
      );
      log("File path ${file.path}");
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: http.MediaType('Image', 'jpeg'),
        ),
      );
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data["url"];
      }
    } catch (e) {
      MySnackBar.showErrorSnackBar("Image upload error", e.toString());
      return null;
    }
    return null;
  }
}
