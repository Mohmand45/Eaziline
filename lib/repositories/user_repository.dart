import 'package:eaziline/models/user.dart';
import 'package:eaziline/services/authentication_service.dart';
import 'package:eaziline/services/user_service.dart';

class UserRepository {
  final AuthenticationService _authenticationService;
  final UserService _userService;

  UserRepository({
    required AuthenticationService authenticationService,
    required UserService userService,
  })  : _authenticationService = authenticationService,
        _userService = userService;

  // User registration
  Future<String?> registerUser(
      {required String email, required String password}) async {
    return await _authenticationService.userSignup(email, password);
  }

  // User login
  Future<String?> loginUser(
      {required String email, required String password}) async {
    return await _authenticationService.userLogin(email, password);
  }

  // User logout
  Future<void> logoutUser() async {
    await _authenticationService.logout();
  }

  // Update user profile
  Future<void> updateUserProfile(
      {required String userId, required String name}) async {
    await _userService.updateUserProfile(userId: userId, name: name);
  }

  // Get user profile
  Future<User?> getUserProfile({required String userId}) async {
    final profileSnapshot = await _userService.getUserProfile(userId: userId);
    return profileSnapshot != null
        ? User.fromMap(profileSnapshot.data() as Map<String, dynamic>)
        : null;
  }

  // Get user attendance records
  Future<List<dynamic>?> getUserAttendanceRecords(
      {required String userId}) async {
    final attendanceSnapshot =
        await _userService.getUserAttendanceRecords(userId: userId);
    return attendanceSnapshot?.docs.map((doc) => doc.data()).toList();
  }
}
