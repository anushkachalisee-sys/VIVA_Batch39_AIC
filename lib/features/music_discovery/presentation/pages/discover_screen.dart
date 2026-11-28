import 'package:flutter/material.dart';
import 'package:viva/features/profile/presentation/listener/pages/listener_profile_page.dart';
import 'package:viva/app/routes/app_routes.dart';
import 'package:viva/features/profile/presentation/listener/widgets/profile_bottom_navigation.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['For you', 'Songs', 'Artists', 'Playlists'];

  bool _isMidnightDreamsLiked = false;
  bool _isNeonMonsoonLiked = false;
  bool _isFollowingArtist = false;
  int _currentNavIndex = 1; // Discover is tab index 1

  void _onTabSelected(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    if (index == 0) {
      // Home -> Mood Selection or Home
      Navigator.pushReplacementNamed(context, AppRoutes.moodSelection);
    } else if (index == 1) {
      // Already on Discover
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Events screen tapped'), duration: Duration(seconds: 1)),
      );
    } else if (index == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Community screen tapped'), duration: Duration(seconds: 1)),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ListenerProfilePage()),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF19182F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF261F40)),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1C),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. Top App Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button
                        Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: Color(0xFF19182F),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        // Title with Icon
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF873BFF), Color(0xFFD32BDE)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Discover',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // Filter / Settings Button
                        Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: Color(0xFF19182F),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.tune_rounded, size: 18, color: Colors.white),
                            onPressed: () => _showSnackBar('Discovery filter settings'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // B. Main Heading
                    const Text(
                      'Find your next favourite',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Fresh finds, tuned to your taste. Updated daily.',
                      style: TextStyle(
                        color: Color(0xFFAAA8C4),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // C. Category Tabs
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final isSelected = _selectedCategoryIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategoryIndex = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF873BFF) : const Color(0xFF19182F),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF873BFF) : const Color(0xFF261F40),
                                  width: 1.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : const Color(0xFFAAA8C4),
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // D. Daily Mix Feature Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF19182F),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF261F40)),
                      ),
                      child: Row(
                        children: [
                          // Album Art
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              'assets/images/artists/lana_del_rey.jpg',
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'MADE FOR YOU · DAILY MIX',
                                  style: TextStyle(
                                    color: Color(0xFF00D9E8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Your late-night mix',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Dream pop, indie & a little escape.',
                                  style: TextStyle(
                                    color: Color(0xFFAAA8C4),
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '20 songs · 1 hr 08 min',
                                  style: TextStyle(
                                    color: Color(0xFF7E7D96),
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Play mix button
                                GestureDetector(
                                  onTap: () => _showSnackBar('Playing Your late-night mix'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF873BFF), Color(0xFFD32BDE)],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.play_arrow_rounded, size: 18, color: Colors.white),
                                        SizedBox(width: 4),
                                        Text(
                                          'Play mix',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // E. Picked for your rotation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Picked for your rotation',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showSnackBar('Viewing all rotation picks'),
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              color: Color(0xFF00D9E8),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Two cards side by side
                    Row(
                      children: [
                        Expanded(
                          child: _buildMusicCard(
                            imagePath: 'assets/images/artists/sza.jpg',
                            title: 'Midnight Dreams',
                            artistGenre: 'Luna Rae · Dream pop',
                            description: 'Because you like dream pop',
                            isLiked: _isMidnightDreamsLiked,
                            onLikeToggle: () {
                              setState(() {
                                _isMidnightDreamsLiked = !_isMidnightDreamsLiked;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildMusicCard(
                            imagePath: 'assets/images/artists/justin_bieber.jpg',
                            title: 'Neon Monsoon',
                            artistGenre: 'Aarya K · Indie electronic',
                            description: 'Inspired by your recent likes',
                            isLiked: _isNeonMonsoonLiked,
                            onLikeToggle: () {
                              setState(() {
                                _isNeonMonsoonLiked = !_isNeonMonsoonLiked;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // F. Artist Recommendation
                    const Text(
                      "An artist you'll connect with",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF19182F),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF261F40)),
                      ),
                      child: Row(
                        children: [
                          // Artist profile image
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/images/artists/lana_del_rey.jpg'),
                          ),
                          const SizedBox(width: 14),
                          // Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '98% TASTE MATCH',
                                  style: TextStyle(
                                    color: Color(0xFF00D9E8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Luna Rae',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Similar to your favourite artists',
                                  style: TextStyle(
                                    color: Color(0xFFAAA8C4),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Follow button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFollowingArtist = !_isFollowingArtist;
                              });
                              _showSnackBar(
                                _isFollowingArtist ? 'Following Luna Rae' : 'Unfollowed Luna Rae',
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                color: _isFollowingArtist ? Colors.transparent : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _isFollowingArtist ? const Color(0xFFAAA8C4) : Colors.white,
                                ),
                              ),
                              child: Text(
                                _isFollowingArtist ? 'Following' : 'Follow',
                                style: TextStyle(
                                  color: _isFollowingArtist ? Colors.white : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // G. Personalisation Information
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: Color(0xFFD32BDE)),
                        const SizedBox(width: 6),
                        const Text(
                          'Shaped by your likes, listening & favourite genres.',
                          style: TextStyle(
                            color: Color(0xFFAAA8C4),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // H. Bottom Navigation Bar
            ProfileBottomNavigation(
              selectedIndex: _currentNavIndex,
              onTabSelected: _onTabSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicCard({
    required String imagePath,
    required String title,
    required String artistGenre,
    required String description,
    required bool isLiked,
    required VoidCallback onLikeToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF19182F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF261F40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album Image with Heart Icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onLikeToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 16,
                      color: isLiked ? const Color(0xFFD32BDE) : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  artistGenre,
                  style: const TextStyle(
                    color: Color(0xFFAAA8C4),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF00D9E8),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
