import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sada/core/theme/colors.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  int _selectedType = 0;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  String? _attachedFileName;
  File? _attachedFile;
  bool _isUploading = false;

  static const _kGreen = Color(0xff0D986A);

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _attachedFile = File(result.files.single.path!);
        _attachedFileName = result.files.single.name;
      });
    }
  }

  void _removeFile() => setState(() {
    _attachedFile = null;
    _attachedFileName = null;
  });

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // رفع الملف إذا وُجد
      String? fileUrl;
      if (_attachedFile != null) {
        final ref = FirebaseStorage.instance.ref(
          'complaints/${DateTime.now().millisecondsSinceEpoch}_$_attachedFileName',
        );
        await ref.putFile(_attachedFile!);
        fileUrl = await ref.getDownloadURL();
      }

      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('Complaints and suggestions')
          .add({
            'type': _selectedType == 1 ? 'شكوى' : 'إقتراح',
            'name': _nameController.text.trim(),
            'nationalId': _idController.text.trim(),
            'email': _emailController.text.trim(),
            'phone': _phoneController.text.trim(),
            'message': _messageController.text.trim(),
            'uid': user?.uid,
            'userEmail': user?.email,
            'sentAt': FieldValue.serverTimestamp(),
            if (fileUrl != null) 'attachmentUrl': fileUrl,
            if (_attachedFileName != null) 'attachmentName': _attachedFileName,
          });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('تم الإرسال بنجاح', textAlign: TextAlign.right),
            backgroundColor: _kGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        _nameController.clear();
        _idController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
        setState(() {
          _attachedFile = null;
          _attachedFileName = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'حدث خطأ، حاول مجدداً',
              textAlign: TextAlign.right,
            ),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'img/GreenGenieLogocropped.png',
          width: 48,
          height: 48,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.black,
                    size: 26,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: _kGreen,
                      shape: BoxShape.circle,
                    ),
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
              Text(
                'نموذج الشكاوي والإقتراحات',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff013220),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'أختر نوع الخدمة',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff013220),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _typeButton('شكوى', 1),
                  const SizedBox(width: 12),
                  _typeButton('إقتراح', 0),
                ],
              ),

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

  Widget _typeButton(String label, int index) {
    final isSelected = _selectedType == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xff0D986A).withOpacity(.47),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? const Color(0xff0D986A) : Colors.transparent,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Form Fields ──────────────────────────────────────────────────────────

  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
        AppTextFormField(
          hintText: '',
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator ?? (value) => null,
          borderRadius: BorderRadius.circular(20),

          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.kPrimaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.kPrimaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: const Color(0xffE5E5E5).withOpacity(.43),
          inputTextStyle: const TextStyle(color: Colors.black),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField('الأسم*', _nameController),
        _buildField(
          'رقم الهويه',
          _idController,
          keyboardType: TextInputType.number,
        ),
        _buildField(
          'البريد الإلكتروني*',
          _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        _buildField(
          'رقم الجوال',
          _phoneController,
          keyboardType: TextInputType.phone,
        ),
        _buildField('الرسالة*', _messageController, maxLines: 3),
      ],
    );
  }

  // ─── Attachment ───────────────────────────────────────────────────────────

  Widget _buildAttachment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'إرفاق ملف أو صورة (اختياري):',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        if (_attachedFileName == null)
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: ColorsManager.lighterGray,
                borderRadius: BorderRadius.circular(12),
                //
                //
                //border: Border.all(color: _kGreen.withOpacity(.4), width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file, color: _kGreen, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'اضغط لاختيار ملف',
                    style: TextStyle(
                      fontSize: 13,
                      color: _kGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _kGreen.withOpacity(.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kGreen.withOpacity(.4), width: 1.2),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  color: _kGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _attachedFileName!,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: _removeFile,
                  child: const Icon(Icons.close, color: Colors.red, size: 18),
                ),
              ],
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
        onPressed: _isLoading ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'إرسال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
