import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/core/widgets/main_button.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _publishEvent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('events').add({
        'name': _nameController.text.trim(),
        'date': _dateController.text.trim(),
        'location': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'imageUrl': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم نشر الفعالية بنجاح ✅'),
            backgroundColor: Color(0xff0D986A),
          ),
        );
        _nameController.clear();
        _dateController.clear();
        _locationController.clear();
        _descriptionController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'نموذج معلومات الفعالية',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff013220),
                  ),
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: _nameController,
                  hintText: 'إسم الفعالية',
                  fillColor: Color(0xffE5E5E5).withOpacity(.37),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff307E29),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب إدخال إسم الفعالية';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: _dateController,
                  hintText: 'التاريخ',
                  fillColor: Color(0xffE5E5E5).withOpacity(.37),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff307E29),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب إدخال التاريخ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: _locationController,
                  hintText: 'الموقع',
                  fillColor: Color(0xffE5E5E5).withOpacity(.37),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff307E29),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب إدخال الموقع';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppTextFormField(
                  controller: _descriptionController,
                  hintText: 'الوصف',
                  maxLines: 3,
                  fillColor: Color(0xffBDD4BA).withOpacity(.43),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff307E29),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يجب إدخال وصف الفعالية';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'قم بأرفاق صور إن وجد :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff013220),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 180,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff7B968D).withOpacity(.37),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 20),
                MainButton(
                  width: 130,
                  height: 40,
                  borderRadius: 10,
                  text: _isLoading ? 'جاري النشر...' : 'نشر',
                  onTap: _isLoading ? () {} : _publishEvent,
                  color: Color(0xff0D986A).withOpacity(.76),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
