import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/widgets/custom_text_field.dart';
import 'package:viva/core/widgets/gradient_button.dart';
import 'package:viva/features/music_preferences/presentation/widgets/preference_chip.dart';
import '../widgets/change_profile_photo_bottom_sheet.dart';

/// Edit Profile screen allowing users to edit Full Name, Username, Bio (with 150 char counter),
/// Location, Profile Photo, and Music Preferences.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;
  late final TextEditingController _locationController;

  String? _selectedImagePath; // null means default placeholder avatar
  final Set<String> _selectedGenres = {'Pop', 'Alternative', 'R&B', 'Indie', 'Electronic'};

  static const List<String> _availableGenres = [
    'Pop',
    'Alternative',
    'Hip-Hop',
    'R&B',
    'Rock',
    'Indie',
    'Electronic',
    'Jazz',
    'Classical',
    'Folk',
    'Acoustic',
    'Bollywood',
    'Nepali',
    'Other',
  ];

  static const List<String> _samplePhotos = [
    'assets/images/artists/ariana_grande.jpg',
    'assets/images/artists/lana_del_rey.jpg',
    'assets/images/artists/sza.jpg',
    'assets/images/artists/justin_bieber.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Anushka');
    _usernameController = TextEditingController(text: 'anushka');
    _bioController = TextEditingController(text: 'Music lover • Concert explorer');
    _locationController = TextEditingController(text: 'Kathmandu, Nepal');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  void _showChangePhotoBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ChangeProfilePhotoBottomSheet(
          onGalleryTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedImagePath = _samplePhotos[0];
            });
            _showSnackBar('Profile photo updated from Gallery');
          },
          onCameraTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedImagePath = _samplePhotos[1];
            });
            _showSnackBar('Profile photo captured from Camera');
          },
          onRemoveTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedImagePath = null;
            });
            _showSnackBar('Profile photo removed');
          },
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primaryPurple),
        ),
      ),
    );
  }

  void _handleSaveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      _showSnackBar('Profile updated successfully!');
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Edit Profile',
                      style: AppTextStyles.heading2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: _handleSaveChanges,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.cardBorder, height: 1),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: AppDimensions.screenPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Photo Section
                      Center(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.primaryGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryPink.withValues(alpha: 0.3),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: _showChangePhotoBottomSheet,
                                    child: CircleAvatar(
                                      radius: 48,
                                      backgroundColor: AppColors.avatarPlaceholder,
                                      backgroundImage: _selectedImagePath != null
                                          ? AssetImage(_selectedImagePath!)
                                          : null,
                                      child: _selectedImagePath == null
                                          ? const Text(
                                              'A',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: _showChangePhotoBottomSheet,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColors.background, width: 2),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: _showChangePhotoBottomSheet,
                              child: const Text(
                                'Change Profile Photo',
                                style: TextStyle(
                                  color: AppColors.primaryPurple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Personal Information Fields
                      CustomTextField(
                        controller: _nameController,
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        prefixIcon: const Icon(Icons.person_outline, color: AppColors.secondaryText),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Name cannot be empty' : null,
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        controller: _usernameController,
                        labelText: 'Username',
                        hintText: 'Enter username',
                        prefixIcon: const Icon(Icons.alternate_email, color: AppColors.secondaryText),
                        validator: (v) => v == null || v.trim().isEmpty ? 'Username cannot be empty' : null,
                      ),
                      const SizedBox(height: 20),

                      // Bio with 150 char counter
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bio',
                            style: AppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _bioController,
                            maxLength: 150,
                            maxLines: 3,
                            style: AppTextStyles.input,
                            cursorColor: AppColors.primaryPink,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Music lover • Concert explorer',
                              hintStyle: AppTextStyles.hint,
                              filled: true,
                              fillColor: AppColors.searchBackground,
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 32),
                                child: Icon(Icons.chat_bubble_outline, color: AppColors.secondaryText),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
                                borderSide: const BorderSide(color: AppColors.searchBorder),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
                                borderSide: const BorderSide(color: AppColors.searchBorder),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
                                borderSide: const BorderSide(color: AppColors.primaryPurple),
                              ),
                              counterStyle: AppTextStyles.caption,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        controller: _locationController,
                        labelText: 'Location',
                        hintText: 'Add your location',
                        prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 32),

                      // Music Preferences Section
                      const Text(
                        'Music Preferences',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your taste. Your people. Pick all that fit.',
                        style: AppTextStyles.subtitle,
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        runSpacing: 10,
                        children: _availableGenres.map((genre) {
                          final isSelected = _selectedGenres.contains(genre);
                          return PreferenceChip(
                            label: genre,
                            isSelected: isSelected,
                            onTap: () => _toggleGenre(genre),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // Fixed Bottom Action Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                border: const Border(top: BorderSide(color: AppColors.cardBorder)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientButton(
                    text: 'Save Changes',
                    onPressed: _handleSaveChanges,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
