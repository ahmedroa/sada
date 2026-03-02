import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  int _selectedType = 0; // 0 = إقتراح, 1 = شكوى

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String? _attachedFileName;

  static const _kGreen = Color(0xff0D986A);
  static const _kLightGreen = Color(0xffE8F5EE);

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: إرسال البيانات للداتابيس
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم الإرسال بنجاح'), backgroundColor: _kGreen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('img/GreenGenieLogocropped.png', width: 48, height: 48),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined, color: Colors.black, size: 26),
                  onPressed: () {},
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: _kGreen, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitle(),
              const SizedBox(height: 20),
              _buildTypeSelector(),
              const SizedBox(height: 24),
              _buildFormFields(),
              const SizedBox(height: 20),
              _buildAttachment(),
              const SizedBox(height: 28),
              _buildSubmitButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Title ────────────────────────────────────────────────────────────────

  Widget _buildTitle() {
    return const Text(
      'نموذج الشكاوي والإقتراحات',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff013220)),
      textAlign: TextAlign.center,
    );
  }

  // ─── Type Selector ────────────────────────────────────────────────────────

  Widget _buildTypeSelector() {
    return Column(
      children: [
        const Text(
          'أختر نوع الخدمة',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff013220)),
        ),
        const SizedBox(height: 12),
        Row(children: [_typeButton('شكوى', 1), const SizedBox(width: 12), _typeButton('إقتراح', 0)]),
      ],
    );
  }

  Widget _typeButton(String label, int index) {
    final isSelected = _selectedType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: Color(0xff0D986A).withOpacity(.47), borderRadius: BorderRadius.circular(24)),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // ─── Form Fields ──────────────────────────────────────────────────────────

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'الأسم*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: _nameController,
          validator: (String? value) {
            return null;
          },
          borderRadius: BorderRadius.circular(20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color(0xffE5E5E5).withOpacity(.43),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'رقم الهويه ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: _idController,
          validator: (String? value) {
            return null;
          },
          borderRadius: BorderRadius.circular(20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color(0xffE5E5E5).withOpacity(.43),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'البريد الإلكتروني*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: _emailController,
          validator: (String? value) {
            return null;
          },
          borderRadius: BorderRadius.circular(20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color(0xffE5E5E5).withOpacity(.43),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'رقم الجوال',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: _phoneController,
          validator: (String? value) {
            return null;
          },
          borderRadius: BorderRadius.circular(20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color(0xffE5E5E5).withOpacity(.43),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'الرسالة*',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: _messageController,
          maxLines: 3,
          validator: (String? value) {
            return null;
          },
          borderRadius: BorderRadius.circular(20),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.kPrimaryColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Color(0xffE5E5E5).withOpacity(.43),
        ),
      ],
    );
  }

  // ─── Attachment ───────────────────────────────────────────────────────────

  Widget _buildAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('قم بأرفاق صور او ملفات إن وجد:', style: TextStyle(fontSize: 14, color: Colors.black87)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // TODO: فتح file picker
            setState(() => _attachedFileName = 'file_example.pdf');
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: ColorsManager.lighterGray, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.download_outlined, color: Colors.black54, size: 22),
                Text(_attachedFileName ?? '', style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Submit Button ────────────────────────────────────────────────────────

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: const Text('إرسال', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
