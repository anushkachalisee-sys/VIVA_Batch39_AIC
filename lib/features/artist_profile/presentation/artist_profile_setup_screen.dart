import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../music_preferences/presentation/widgets/preference_chip.dart';

/// Screen for US29: Artist Profile Creation
/// Allows artists to enter their stage name, bio (with 200 char counter),
/// select multiple music genres, upload/select profile photo, optional social/location details,
/// and create their artist profile.
class ArtistProfileSetupScreen extends StatefulWidget {
  const ArtistProfileSetupScreen({super.key});

  @override
  State<ArtistProfileSetupScreen> createState() => _ArtistProfileSetupScreenState();
}

class _ArtistProfileSetupScreenState extends State<ArtistProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _youtubeController = TextEditingController();

  // Selected profile image (asset path or file path)
  String? _selectedImagePath;

  // Selected music genres
  final Set<String> _selectedGenres = {};

  bool _isLoading = false;

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

  static const List<String> _sampleArtistImages = [
    'assets/images/artists/ariana_grande.jpg',
    'assets/images/artists/daniel_caesar.jpg',
    'assets/images/artists/justin_bieber.jpg',
    'assets/images/artists/lana_del_rey.jpg',
    'assets/images/artists/sza.jpg',
    'assets/images/artists/the_weekend.jpg',
  ];

  @override
  void dispose() {
    _artistNameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _instagramController.dispose();
    _youtubeController.dispose();
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

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Profile Photo',
                    style: AppTextStyles.heading3,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose from sample artist avatars or upload from your library:',
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sampleArtistImages.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final imgPath = _sampleArtistImages[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImagePath = imgPath;
                        });
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.avatarPlaceholder,
                        backgroundImage: AssetImage(imgPath),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              GradientButton(
                text: 'Upload from Device Library',
                icon: const Icon(Icons.photo_library, color: Colors.white, size: 18),
                onPressed: () {
                  setState(() {
                    _selectedImagePath = _sampleArtistImages.first;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile photo selected successfully!'),
                      backgroundColor: AppColors.cardBackground,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _handleCreateProfile() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_selectedGenres.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one music genre.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primaryPurple, width: 1),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.accentCyan, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artist Profile Created Successfully!',
                    style: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome, ${_artistNameController.text}!',
                    style: const TextStyle(color: AppColors.secondaryText, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.primaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Create Artist Profile',
                    style: AppTextStyles.heading2,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ARTIST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.cardBorder, height: 1),

            // Scrollable Form Body
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
                                GestureDetector(
                                  onTap: _showImagePickerBottomSheet,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: _selectedImagePath == null ? AppColors.avatarGradient : null,
                                      border: Border.all(color: AppColors.primaryPurple, width: 2),
                                      image: _selectedImagePath != null
                                          ? DecorationImage(
                                              image: AssetImage(_selectedImagePath!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: _selectedImagePath == null
                                        ? const Icon(
                                            Icons.person,
                                            size: 48,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: _showImagePickerBottomSheet,
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
                            TextButton(
                              onPressed: _showImagePickerBottomSheet,
                              child: const Text(
                                'Add / Change Profile Photo',
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
                      const SizedBox(height: 24),

                      // Artist Name
                      CustomTextField(
                        controller: _artistNameController,
                        labelText: 'Artist Name *',
                        hintText: 'Enter your artist/stage name',
                        prefixIcon: const Icon(Icons.mic_outlined, color: AppColors.secondaryText),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your artist or stage name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Artist Bio
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Artist Bio',
                            style: AppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _bioController,
                            maxLength: 200,
                            maxLines: 4,
                            style: AppTextStyles.input,
                            cursorColor: AppColors.primaryPink,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Tell your fans about yourself and your music...',
                              hintStyle: AppTextStyles.hint,
                              filled: true,
                              fillColor: AppColors.searchBackground,
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
                      const SizedBox(height: 24),

                      // Music Genre Selection
                      const Text(
                        'Choose Your Music Genres *',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Select the genres that best describe your music (multiple selection).',
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
                      const SizedBox(height: 28),

                      // Additional Details Section (Optional)
                      const Text(
                        'Additional Details (Optional)',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _locationController,
                        labelText: 'Location',
                        hintText: 'e.g. Kathmandu, Nepal',
                        prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _instagramController,
                        labelText: 'Instagram Handle',
                        hintText: '@yourusername',
                        prefixIcon: const Icon(Icons.camera_alt_outlined, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _youtubeController,
                        labelText: 'YouTube Channel / Link',
                        hintText: 'youtube.com/@yourchannel',
                        prefixIcon: const Icon(Icons.play_circle_outline, color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 36),

                      // Create Profile Button
                      GradientButton(
                        text: 'Create Profile',
                        isLoading: _isLoading,
                        onPressed: _handleCreateProfile,
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Your profile helps fans discover your music.',
                          style: AppTextStyles.caption,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
