import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/service/community_service.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class CommunityController extends GetxController {
  final service = CommunityService();
  final authController = AuthController();
  RxBool isLoading = false.obs;
  RxList<CommunityModel> communities = <CommunityModel>[].obs;
  RxList<CommunityModel> myCommunities = <CommunityModel>[].obs;

  @override
  void onInit() {
    // getCommunities();
    super.onInit();
  }

  void getCommunities() async {
    isLoading.value = true;
    try {
      communities.value = await service.getCommunities();
      // log(communities.toString());
    } catch (e) {
      MyErrorSnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getUserCommunities() async {
    isLoading.value = true;
    try {
      myCommunities.value = await service.getUserCommunities(await getUserId());
    } catch (e) {
      MyErrorSnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getAntiUserCommunities() async {
    isLoading.value = true;
    try {
      communities.value = await service.getAntiUserCommunities(
        await getUserId(),
      );
    } catch (e) {
      MyErrorSnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<num> getUserId() async {
    final data = jsonDecode(await LocalStorage.i.getUser("current_user"));
    log("${data['id']} userId");
    return data['id'];
  }
}
