import 'package:flutter/material.dart';
import '../../../domain/entities/listener_profile.dart';
import '../../../domain/repositories/profile_repository.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository repository;

  ProfileProvider({required this.repository}) {
    loadProfile();
  }

  ListenerProfile? _profile;
  bool _isLoading = true;
  String? _error;
  String _activeMood = 'Chill';
  int _currentNavIndex = 4; // 4 = Profile tab selected
  bool _isDisposed = false;

  ListenerProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get activeMood => _activeMood;
  int get currentNavIndex => _currentNavIndex;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedProfile = await repository.getListenerProfile();
      _profile = fetchedProfile;
      _activeMood = fetchedProfile.activeMood;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectMood(String mood) {
    if (_activeMood != mood) {
      _activeMood = mood;
      notifyListeners();
    }
  }

  void setNavIndex(int index) {
    if (_currentNavIndex != index) {
      _currentNavIndex = index;
      notifyListeners();
    }
  }
}

