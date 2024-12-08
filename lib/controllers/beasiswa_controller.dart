import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katalis/models/beasiswa_model.dart';
import 'package:katalis/services/beasiswa_service.dart';

class BeasiswaController extends GetxController {
  final BeasiswaService beasiswaService = BeasiswaService();

  // TextEditingController untuk pencarian
  final TextEditingController textEditingController = TextEditingController();

  // State management dengan Rx
  RxList<BeasiswaModel> beasiswaList = <BeasiswaModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBeasiswa(); // Ambil data beasiswa saat inisialisasi
  }

  /// Fungsi untuk mengambil semua data beasiswa
  Future<void> fetchBeasiswa() async {
    try {
      isLoading(true);
      errorMessage('');
      final List<BeasiswaModel> fetchedBeasiswa =
          await beasiswaService.getAllBeasiswa();
      beasiswaList.assignAll(fetchedBeasiswa);
      print('Beasiswa fetched: ${beasiswaList.length}');
    } catch (e) {
      print('Error fetching beasiswa: $e');
      errorMessage(e.toString());
      // Handle error unauthorized
      if (e.toString().contains('Unauthorized') ||
          e.toString().contains('401')) {
        print('Unauthorized access detected, redirecting to login');
        await Get.offAllNamed('/login');
      }
    } finally {
      isLoading(false);
    }
  }

  /// Fungsi untuk mencari data beasiswa berdasarkan query
  Future<void> searchBeasiswa(String query) async {
    if (query.isEmpty) {
      return fetchBeasiswa();
    }
    try {
      isLoading(true);
      errorMessage('');
      final List<BeasiswaModel> searchResults =
          await beasiswaService.searchBeasiswa(query);
      beasiswaList.assignAll(searchResults);
      print('Search results: ${beasiswaList.length}');
    } catch (e) {
      print('Error searching beasiswa: $e');
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
