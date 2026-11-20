import '../entities/listener_profile.dart';

abstract class ProfileRepository {
  Future<ListenerProfile> getListenerProfile();
}
