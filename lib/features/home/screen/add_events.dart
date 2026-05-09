import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sada/core/widgets/app_text_form_field.dart';
import 'package:sada/core/widgets/main_button.dart';

const _hijriMonths = [
  'محرم',
  'صفر',
  'ربيع الأول',
  'ربيع الثاني',
  'جمادى الأولى',
  'جمادى الآخرة',
  'رجب',
  'شعبان',
  'رمضان',
  'شوال',
  'ذو القعدة',
  'ذو الحجة',
];

const _weekDays = [
  'الأحد',
  'الاثنين',
  'الثلاثاء',
  'الأربعاء',
  'الخميس',
  'الجمعة',
  'السبت',
];

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

  DateTime? _selectedGregorianDate;
  File? _pickedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatHijri(DateTime gregorian) {
    final h = HijriCalendar.fromDate(gregorian);
    final dayName = _weekDays[gregorian.weekday % 7];
    final monthName = _hijriMonths[h.hMonth - 1];
    return '$dayName, ${h.hDay} $monthName ${h.hYear}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedGregorianDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
      locale: const Locale('ar'),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff0D986A),
            onPrimary: Colors.white,
            onSurface: Color(0xff013220),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _selectedGregorianDate = picked;
        _dateController.text = _formatHijri(picked);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (xFile != null) {
      setState(() => _pickedImage = File(xFile.path));
    }
  }

  Future<String> _uploadImage(File image) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('events/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  Future<void> _publishEvent() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      String imageUrl = '';
      if (_pickedImage != null) {
        imageUrl = await _uploadImage(_pickedImage!);
      }

      await FirebaseFirestore.instance.collection('events').add({
        'name': _nameController.text.trim(),
        'date': _dateController.text.trim(),
        'dateTimestamp': _selectedGregorianDate != null
            ? Timestamp.fromDate(_selectedGregorianDate!)
            : null,
        'location': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'imageUrl': imageUrl,
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
        setState(() {
          _selectedGregorianDate = null;
          _pickedImage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('حدث خطأ: $e'),
            backgroundColor: Colors.red,
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
      appBar: AppBar(
        title: Image.asset(
          'img/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        actions: const [SizedBox(width: 56)],
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
                // حقل التاريخ — يفتح date picker عند الضغط
                AppTextFormField(
                  controller: _dateController,
                  hintText: 'التاريخ',
                  readOnly: true,
                  onTap: _pickDate,
                  fillColor: Color(0xffE5E5E5).withOpacity(.37),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xff307E29),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Color(0xff307E29),
                    size: 20,
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
                const SizedBox(height: 12),
                // منطقة رفع الصورة
                GestureDetector(
                  onTap: _pickedImage == null ? _pickImage : null,
                  child: _pickedImage != null
                      ? Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                _pickedImage!,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 6,
                              left: 6,
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _pickedImage = null),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          width: 180,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xff7B968D).withOpacity(.37),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                ),
                const SizedBox(height: 24),
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
