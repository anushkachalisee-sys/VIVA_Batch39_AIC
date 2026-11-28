import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';
import 'package:viva/features/search/presentation/widgets/category_tabs.dart';
import 'package:viva/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:viva/features/search/presentation/widgets/filter_button.dart';
import 'package:viva/features/search/presentation/widgets/search_history_section.dart';
import 'package:viva/features/search/presentation/widgets/search_suggestion_tile.dart';
import 'package:viva/features/search/presentation/widgets/sort_dropdown.dart';

/// Shared Search screen supporting an [initialCategory] ('All', 'Artists',
/// 'Communities', or 'Events') so different screens can open it pre-filtered.
class SearchScreen extends StatefulWidget {
  final String initialCategory;

  const SearchScreen({
    super.key,
    this.initialCategory = 'All',
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  late String _selectedCategory;
  String _selectedSort = SortDropdown.defaultOptions.first;
  final Set<String> _selectedFilters = <String>{};

  final List<String> _searchHistory = [
    'Sajjan Raj Vaidya',
    'Indie Rock Hub',
    'Kathmandu Acoustic Night',
    'Midnight Echoes',
  ];

  static const List<String> _availableFilters = [
    'Verified Only',
    'Live Tonight',
    'Trending',
    'Acoustic',
  ];

  static const List<_MockSuggestion> _mockSuggestions = [
    _MockSuggestion(
      title: 'Sajjan Raj Vaidya',
      subtitle: '1.2M monthly listeners • Indie Folk',
      category: 'Artists',
      icon: Icons.mic_external_on_rounded,
      accentColor: AppColors.primaryPink,
      tags: ['Verified Only', 'Trending', 'Acoustic'],
      popularity: 98,
      recencyRank: 2,
    ),
    _MockSuggestion(
      title: 'Aurora',
      subtitle: '840K monthly listeners • Art Pop',
      category: 'Artists',
      icon: Icons.person_rounded,
      accentColor: AppColors.primaryPink,
      tags: ['Verified Only', 'Trending'],
      popularity: 92,
      recencyRank: 4,
    ),
    _MockSuggestion(
      title: 'Indie Rock Hub',
      subtitle: '14.8K members • Active discussion',
      category: 'Communities',
      icon: Icons.people_alt_rounded,
      accentColor: AppColors.primaryPurple,
      tags: ['Trending'],
      popularity: 85,
      recencyRank: 1,
    ),
    _MockSuggestion(
      title: 'Acoustic Songwriters Circle',
      subtitle: '4.3K members • Weekly song shares',
      category: 'Communities',
      icon: Icons.graphic_eq_rounded,
      accentColor: AppColors.primaryPurple,
      tags: ['Acoustic'],
      popularity: 74,
      recencyRank: 5,
    ),
    _MockSuggestion(
      title: 'Kathmandu Acoustic Night',
      subtitle: 'Sat, Dec 12 • 7:30 PM • Patan',
      category: 'Events',
      icon: Icons.event_rounded,
      accentColor: AppColors.accentCyan,
      tags: ['Live Tonight', 'Acoustic'],
      popularity: 89,
      recencyRank: 3,
    ),
    _MockSuggestion(
      title: 'Midnight Echoes Live',
      subtitle: 'Fri, Dec 18 • 9:00 PM • Downtown Arena',
      category: 'Events',
      icon: Icons.festival_rounded,
      accentColor: AppColors.accentCyan,
      tags: ['Live Tonight', 'Trending', 'Verified Only'],
      popularity: 95,
      recencyRank: 6,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        CategoryTabs.defaultCategories.contains(widget.initialCategory)
            ? widget.initialCategory
            : CategoryTabs.defaultCategories.first;
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategory != widget.initialCategory &&
        CategoryTabs.defaultCategories.contains(widget.initialCategory)) {
      _selectedCategory = widget.initialCategory;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_MockSuggestion> get _filteredSuggestions {
    final trimmedQuery = _query.trim().toLowerCase();

    final filtered = _mockSuggestions.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesQuery = trimmedQuery.isEmpty ||
          item.title.toLowerCase().contains(trimmedQuery) ||
          item.subtitle.toLowerCase().contains(trimmedQuery) ||
          item.category.toLowerCase().contains(trimmedQuery);
      final matchesFilters = _selectedFilters.isEmpty ||
          _selectedFilters.every((filter) => item.tags.contains(filter));
      return matchesCategory && matchesQuery && matchesFilters;
    }).toList();

    switch (_selectedSort) {
      case 'Popularity':
        filtered.sort((a, b) => b.popularity.compareTo(a.popularity));
        break;
      case 'Newest First':
        filtered.sort((a, b) => a.recencyRank.compareTo(b.recencyRank));
        break;
      case 'Oldest First':
        filtered.sort((a, b) => b.recencyRank.compareTo(a.recencyRank));
        break;
      case 'Alphabetical':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Relevance':
      default:
        break;
    }

    return filtered;
  }

  Map<String, int> get _categoryCounts {
    return {
      for (final category in CategoryTabs.defaultCategories)
        category: category == 'All'
            ? _mockSuggestions.length
            : _mockSuggestions.where((item) => item.category == category).length,
    };
  }

  void _addToHistory(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _searchHistory.removeWhere(
        (item) => item.toLowerCase() == trimmed.toLowerCase(),
      );
      _searchHistory.insert(0, trimmed);
    });
  }

  void _applyQuery(String value) {
    _searchController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    setState(() {
      _query = value;
    });
  }

  void _handleSuggestionTap(_MockSuggestion item) {
    _applyQuery(item.title);
    _addToHistory(item.title);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected "${item.title}" (${item.category})',
          style: AppTextStyles.body,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.cardRadius),
        ),
        side: BorderSide(color: AppColors.cardBorder),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.space24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Temporary Filters',
                          style: AppTextStyles.heading3,
                        ),
                        if (_selectedFilters.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              setState(() => _selectedFilters.clear());
                              setModalState(() {});
                            },
                            child: Text(
                              'Reset',
                              style: AppTextStyles.buttonSmall.copyWith(
                                color: AppColors.primaryPink,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.space8),
                    const Text(
                      'Select mock filters to test FilterButton and SearchBar states.',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppDimensions.space16),
                    Wrap(
                      spacing: AppDimensions.space8,
                      runSpacing: AppDimensions.space8,
                      children: _availableFilters.map((filter) {
                        final isSelected = _selectedFilters.contains(filter);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedFilters.remove(filter);
                              } else {
                                _selectedFilters.add(filter);
                              }
                            });
                            setModalState(() {});
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: AppDimensions.chipPadding,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.chipRadius,
                              ),
                              gradient:
                                  isSelected ? AppColors.primaryGradient : null,
                              color:
                                  isSelected ? null : AppColors.unselectedChip,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : AppColors.unselectedChipBorder,
                              ),
                            ),
                            child: Text(
                              filter,
                              style: isSelected
                                  ? AppTextStyles.chipSelected
                                  : AppTextStyles.chipUnselected,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppDimensions.space24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final suggestions = _filteredSuggestions;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.horizontalScreenPadding,
            vertical: AppDimensions.verticalScreenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. CustomSearchBar
              CustomSearchBar(
                controller: _searchController,
                hintText: 'Search songs, artists or lyrics...',
                showFilterIcon: true,
                hasActiveFilter: _selectedFilters.isNotEmpty,
                onFilterTap: _openFilterSheet,
                onChanged: (value) => setState(() => _query = value),
                onSubmitted: _addToHistory,
                onClear: () => setState(() => _query = ''),
              ),
              const SizedBox(height: AppDimensions.space16),

              // 2. CategoryTabs
              CategoryTabs(
                categories: CategoryTabs.defaultCategories,
                selectedCategory: _selectedCategory,
                categoryCounts: _categoryCounts,
                onCategoryChanged: (category) {
                  setState(() => _selectedCategory = category);
                },
              ),
              const SizedBox(height: AppDimensions.space12),

              // 3. FilterButton & 4. SortDropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(
                    label: 'Filters',
                    hasActiveFilters: _selectedFilters.isNotEmpty,
                    activeFilterCount: _selectedFilters.isNotEmpty
                        ? _selectedFilters.length
                        : null,
                    onTap: _openFilterSheet,
                  ),
                  const SizedBox(width: AppDimensions.space8),
                  Flexible(
                    child: SortDropdown(
                      options: SortDropdown.defaultOptions,
                      selectedOption: _selectedSort,
                      prefixLabel: 'Sort:',
                      onSelected: (option) {
                        setState(() => _selectedSort = option);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space16),

              // Scrollable search suggestions & history area
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 5. SearchSuggestionTile list
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Suggestions',
                            style: AppTextStyles.sectionTitle,
                          ),
                          Text(
                            '${suggestions.length} results',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.accentCyan,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.space12),
                      if (suggestions.isEmpty)
                        Container(
                          padding: AppDimensions.cardPadding,
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusL,
                            ),
                            border: Border.all(color: AppColors.cardBorder),
                          ),
                          child: const Text(
                            'No matching suggestions for the current search or filters.',
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: suggestions.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppDimensions.space8),
                          itemBuilder: (context, index) {
                            final item = suggestions[index];
                            return SearchSuggestionTile(
                              title: item.title,
                              subtitle: item.subtitle,
                              categoryLabel: item.category,
                              leadingIcon: item.icon,
                              leadingIconColor: item.accentColor,
                              categoryColor: item.accentColor,
                              isCircularLeading: item.category == 'Artists',
                              onTap: () => _handleSuggestionTap(item),
                              onTrailingTap: () => _applyQuery(item.title),
                            );
                          },
                        ),
                      const SizedBox(height: AppDimensions.space24),

                      // 6. SearchHistorySection
                      SearchHistorySection(
                        items: _searchHistory,
                        emptySubtitle:
                            'Tap a suggestion or submit a query to add one.',
                        onItemTap: _applyQuery,
                        onRemoveItem: (query) {
                          setState(() => _searchHistory.remove(query));
                        },
                        onClearAll: () {
                          setState(() => _searchHistory.clear());
                        },
                      ),
                      const SizedBox(height: AppDimensions.space16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockSuggestion {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color accentColor;
  final List<String> tags;
  final int popularity;
  final int recencyRank;

  const _MockSuggestion({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.tags,
    required this.popularity,
    required this.recencyRank,
  });
}
