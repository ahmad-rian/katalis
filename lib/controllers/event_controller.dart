import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katalis/models/event_model.dart';
import 'package:katalis/services/event_service.dart';

class EventController extends GetxController {
  final EventService eventService = EventService();

  // TextEditingController untuk pencarian
  final TextEditingController textEditingController = TextEditingController();

  // State management dengan Rx
  RxList<EventModel> events = <EventModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents(); // Ambil data event saat inisialisasi
  }

  /// Fungsi untuk mengambil semua data event
  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      errorMessage('');
      final List<EventModel> fetchedEvents = await eventService.getAllEvents();
      events.assignAll(fetchedEvents);
      print('Events fetched: ${events.length}');
    } catch (e) {
      print('Error fetching events: $e');
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

  /// Fungsi untuk mencari data event berdasarkan query
  Future<void> searchEvents(String query) async {
    if (query.isEmpty) {
      return fetchEvents();
    }
    try {
      isLoading(true);
      errorMessage('');
      final List<EventModel> searchResults =
          await eventService.searchEvents(query);
      events.assignAll(searchResults);
      print('Search results: ${events.length}');
    } catch (e) {
      print('Error searching events: $e');
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
