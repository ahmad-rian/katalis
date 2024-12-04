import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/member_model.dart';
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
      print('Members fetched: ${members.length}');
    } catch (e) {
      print('Error fetching members: $e');
      errorMessage(e.toString());
      // Check if error is due to unauthorized access
      if (e.toString().contains('Unauthorized') ||
          e.toString().contains('401')) {
        print('Unauthorized access detected, redirecting to login');
        await Get.offAllNamed('/login');
      }
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
      print('Search results: ${members.length}');
    } catch (e) {
      print('Error searching members: $e');
      errorMessage(e.toString());
      if (e.toString().contains('Unauthorized') ||
          e.toString().contains('401')) {
        print('Unauthorized access detected, redirecting to login');
        await Get.offAllNamed('/login');
      }
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
