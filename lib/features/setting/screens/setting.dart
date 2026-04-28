import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sada/features/auth/login/ui/login.dart';
import 'package:sada/features/complaints/complaints_screen.dart';
import 'package:sada/features/setting/screens/favorites.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  static const _kGreen = Color(0xFF0D986A);

  String? _photoUrl;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentPhoto();
  }

  void _loadCurrentPhoto() {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.photoURL != null) {
      setState(() => _photoUrl = user!.photoURL);
    }
  }

  Future<void> _pickAndUpload(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 80);
    if (picked == null) return;

    setState(() => _isUploading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance.ref('profile_pictures/$uid.jpg');
      await ref.putFile(File(picked.path));
      final url = await ref.getDownloadURL();

      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);

      // حفظ رابط الصورة في Firestore ضمن doc المستخدم
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'photoUrl': url,
      });

      if (mounted) setState(() => _photoUrl = url);
    } catch (e) {
      debugPrint('Storage upload error: $e');
      if (mounted) {
        final msg =
            e.toString().contains('unauthorized') ||
                e.toString().contains('permission')
            ? 'غير مصرح — حدّث قواعد Firebase Storage'
            : e.toString().contains('bucket') ||
                  e.toString().contains('object-not-found')
            ? 'Firebase Storage غير مفعّل في المشروع'
            : 'خطأ: ${e.toString()}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg, textAlign: TextAlign.right),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'اختر مصدر الصورة',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: _kGreen),
                title: const Text('الكاميرا', textAlign: TextAlign.right),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUpload(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: _kGreen,
                ),
                title: const Text('مكتبة الصور', textAlign: TextAlign.right),
                onTap: () {
                  Navigator.pop(context);
                  _pickAndUpload(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // صورة البروفايل
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _kGreen,
                  shape: BoxShape.circle,
                  image: _photoUrl != null
                      ? DecorationImage(
                          image: NetworkImage(_photoUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _photoUrl == null
                    ? const Icon(Icons.person, color: Colors.white, size: 44)
                    : null,
              ),
              if (_isUploading)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // زر تعديل
          GestureDetector(
            onTap: _isUploading ? null : _showImageSourceSheet,
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: _kGreen.withOpacity(.9),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('img/edit.svg'),
                  const SizedBox(width: 10),
                  const Text(
                    'تعديل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          buildItem(
            title: 'المفضلة',
            icon: 'img/f.svg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Favorites()),
            ),
          ),
          buildItem(
            title: 'الشكاوي والإقتراحات',
            icon: 'img/qq.svg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ComplaintsScreen()),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 30),
            child: Divider(color: Colors.black, height: 1),
          ),
          const SizedBox(height: 20),
          buildItem(title: 'اللغة', icon: 'img/language.svg'),
          buildItem(title: 'الاشعارات', icon: 'img/notfiction.svg'),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 30),
            child: Divider(color: Colors.black, height: 1),
          ),
          const SizedBox(height: 20),
          buildItem(title: 'الامان', icon: 'img/s.svg'),
          buildItem(title: 'عن سدى', icon: 'img/sss.svg'),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 30),
            child: Divider(color: Colors.black, height: 1),
          ),
          const SizedBox(height: 20),

          // تسجيل الخروج
          GestureDetector(
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('تسجيل الخروج', textAlign: TextAlign.right),
                  content: const Text(
                    'هل أنت متأكد أنك تريد تسجيل الخروج؟',
                    textAlign: TextAlign.right,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text(
                        'إلغاء',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text(
                        'خروج',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                    (_) => false,
                  );
                }
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.login_outlined, color: Colors.black, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 30, top: 12, bottom: 12),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}
