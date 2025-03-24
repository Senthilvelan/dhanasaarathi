import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  var isAuthenticated = false.obs;

  Future<void> login(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      isAuthenticated.value = true;
      Get.offAllNamed('/dashboard');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await supabase.auth.signUp(email: email, password: password);
      Get.snackbar("Success", "Account created! Please log in.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    isAuthenticated.value = false;
    Get.offAllNamed('/auth');
  }
}
