import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_pagination/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  final scrollControler = ScrollController();

  void _scrollListener() {
    if (scrollControler.position.pixels ==
        scrollControler.position.maxScrollExtent) {
      controller.getAPI(controller.list.length + 20);
    }
  }

  @override
  void initState() {
    scrollControler.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => SizedBox(
                child: controller.isLoading.value
                    ? const LinearProgressIndicator()
                    : const SizedBox(
                        height: 0,
                      ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Obx(
                  () => Text(
                    'Length List ${controller.list.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                controller.getAPI(10);
              },
              child: const Text('Get Data'),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: scrollControler,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            index.toString(),
                          ),
                        ),
                        title: Text(controller.list[index]['name'] as String),
                        subtitle: Text(controller.list[index]['url'] as String),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
