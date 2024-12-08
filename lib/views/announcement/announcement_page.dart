// lib/pages/announcement_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katalis/models/beasiswa_model.dart';
import 'package:katalis/models/event_model.dart';
import 'package:katalis/controllers/beasiswa_controller.dart'; // Controller for Beasiswa
import 'package:katalis/controllers/event_controller.dart'; // Controller for Event

class AnnouncementPage extends StatelessWidget {
  final BeasiswaController _beasiswaController =
      Get.put(BeasiswaController()); // Beasiswa Controller
  final EventController _eventController =
      Get.put(EventController()); // Event Controller

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beasiswa & Event'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Beasiswa'),
              Tab(text: 'Event'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Beasiswa Tab
            Obx(() => _buildBeasiswaTab()),

            // Event Tab
            Obx(() => _buildEventTab()),
          ],
        ),
      ),
    );
  }

  // Builds Beasiswa Tab
  Widget _buildBeasiswaTab() {
    if (_beasiswaController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_beasiswaController.beasiswaList.isEmpty) {
      return const Center(child: Text('Tidak ada data beasiswa.'));
    }

    return ListView.builder(
      itemCount: _beasiswaController.beasiswaList.length,
      itemBuilder: (context, index) {
        final beasiswa = _beasiswaController.beasiswaList[index];
        return _buildBeasiswaCard(context, beasiswa);
      },
    );
  }

  // Builds Event Tab
  Widget _buildEventTab() {
    if (_eventController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_eventController.events.isEmpty) {
      return const Center(child: Text('Tidak ada data event.'));
    }

    return ListView.builder(
      itemCount: _eventController.events.length,
      itemBuilder: (context, index) {
        final event = _eventController.events[index];
        return _buildEventCard(context, event);
      },
    );
  }

  // Builds Beasiswa Card
  // Inside the widget where _buildBeasiswaCard is called (e.g., a StatefulWidget or StatelessWidget)
  Widget _buildBeasiswaCard(BuildContext context, BeasiswaModel beasiswa) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          beasiswa.namaBeasiswa,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          beasiswa.deskripsi,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: beasiswa.gambar != null
            ? Image.network(
                beasiswa.gambar!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : null,
        onTap: () {
          _showBeasiswaDetail(context, beasiswa); // Now context is available
        },
      ),
    );
  }

  // Builds Event Card
  // Inside the AnnouncementPage widget
  Widget _buildEventCard(BuildContext context, EventModel event) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(
          event.namaEvent,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          event.deskripsi,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: event.gambar != null
            ? Image.network(
                event.gambar!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : null,
        onTap: () {
          _showEventDetail(context, event); // Now context is available
        },
      ),
    );
  }

  // Show Beasiswa Detail
  void _showBeasiswaDetail(BuildContext context, BeasiswaModel beasiswa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(beasiswa.namaBeasiswa),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (beasiswa.gambar != null) Image.network(beasiswa.gambar!),
                const SizedBox(height: 10),
                Text(
                  beasiswa.deskripsi,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Tutup'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // Show Event Detail
  void _showEventDetail(BuildContext context, EventModel event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.namaEvent),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (event.gambar != null) Image.network(event.gambar!),
                const SizedBox(height: 10),
                Text(
                  event.deskripsi,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Tutup'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
