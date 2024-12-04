import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katalis/models/member_model.dart';

import '../services/member_service.dart';

class MemberController extends GetxController {
  final MemberService memberService = MemberService();
  final textEditingController = TextEditingController();

  RxList<Member> members = <Member>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMembers();
  }

  Future<void> fetchMembers() async {
    try {
      isLoading(true);
      errorMessage('');
      members.value = await memberService.getAllMembers();
    } catch (e) {
      errorMessage('Failed to fetch members: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchMembers(String query) async {
    if (query.isEmpty) {
      return fetchMembers();
    }
    try {
      isLoading(true);
      errorMessage('');
      members.value = await memberService.searchMembers(query);
    } catch (e) {
      errorMessage('Failed to search members: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
