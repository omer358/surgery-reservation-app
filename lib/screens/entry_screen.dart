import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:surgery_picker/controllers/entry_screen_controller.dart';

class EntryScreen extends StatelessWidget {
  final EntryScreenController controller = Get.put(EntryScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                _buildHeaderText(),
                const SizedBox(
                  height: 20,
                ),
                _buildSvgImage(),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(),
                const SizedBox(height: 20),
                _buildSearchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        "مرحبا بك في تطبيق حجز العمليات العيون",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      "assets/images/medical.svg",
      width: 200,
      height: 200,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller.patientIdController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      textDirection: TextDirection.rtl,
      onTap: controller.resetButtonClicked,
      decoration: InputDecoration(
        hintTextDirection: TextDirection.rtl,
        hintText: 'ادخل رقم المريض التعريفي ',
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        // Show error message only when button is clicked
        errorText: controller.buttonClicked.value &&
                (controller.patientIdController.text.isEmpty ||
                    double.tryParse(controller.patientIdController.text) ==
                        null)
            ? 'يجب إدخال رقم المريض التعريفي أولاً'
            : null,
      ),
    );
  }

  Widget _buildSearchButton() {
    return Obx(() => controller.isLoading.value
        ? const CircularProgressIndicator()
        : Container(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.handleSearch,
              child: const Text(
                "بحث",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ));
  }

}
