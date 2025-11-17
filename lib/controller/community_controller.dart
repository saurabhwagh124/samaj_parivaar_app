import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/service/community_service.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class CommunityController extends GetxController {
  final service = CommunityService();
  RxBool isLoading = false.obs;
  RxList<CommunityModel> communities = <CommunityModel>[].obs;

  @override
  void onInit() {
    // getCommunities();
    super.onInit();
  }

  void getCommunities() async {
    isLoading.value = true;
    try {
      communities.addAll(await service.getCommunities());
      log(communities.toString());
    } catch (e) {
      MyErrorSnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
