import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/model/join_request.dart';
import 'package:samaj_parivaar_app/service/community_service.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/widgets/error_snackbar.dart';

class CommunityController extends GetxController {
  final service = CommunityService();
  final authController = AuthController();

  RxBool isCommunitiesLoading = false.obs;
  RxBool isMyCommunitiesLoading = false.obs;
  RxBool isJoinLoading = false.obs;

  RxList<CommunityModel> communities = <CommunityModel>[].obs;
  RxList<CommunityModel> myCommunities = <CommunityModel>[].obs;

  @override
  void onInit() {
    // getCommunities();
    super.onInit();
  }

  Future<num> getUserId() async {
    final data = jsonDecode(await LocalStorage.i.getUser("current_user"));
    log("${data['id']} userId");
    return data['id'];
  }

  void getCommunities() async {
    isCommunitiesLoading.value = true;
    try {
      communities.value = await service.getCommunities();
      // log(communities.toString());
    } catch (e) {
      MySnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isCommunitiesLoading.value = false;
    }
  }

  void getUserCommunities() async {
    isMyCommunitiesLoading.value = true;
    try {
      myCommunities.value = await service.getUserCommunities(await getUserId());
    } catch (e) {
      MySnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isMyCommunitiesLoading.value = false;
    }
  }

  void getAntiUserCommunities() async {
    isCommunitiesLoading.value = true;
    try {
      communities.value = await service.getAntiUserCommunities(
        await getUserId(),
      );
    } catch (e) {
      MySnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
    } finally {
      isCommunitiesLoading.value = false;
    }
  }

  Future<bool> createJoinRequest(num groupId, String message) async {
    isJoinLoading.value = true;
    final userId = await getUserId();
    try {
      final payload = JoinRequest(
        requestId: null,
        groupId: groupId,
        userId: userId,
        requestMessage: message,
        status: "pending",
        reviewedBy: null,
        reviewMessage: null,
        requestedAt: null,
        reviewedAt: null,
        user: null,
      );
      await service.createJoinRequest(payload);
      MySnackBar.showSuccessSnackBar("Success", "Request sent successfully");
      return true;
    } catch (e) {
      MySnackBar.showErrorSnackBar("Something went wrong", e.toString());
      log(e.toString());
      return false;
    } finally {
      isJoinLoading.value = false;
    }
  }
}
