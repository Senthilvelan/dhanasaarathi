import 'package:supabase_flutter/supabase_flutter.dart';


/**
 *
 * Supabase is configured and got the url and key.
 * Configured twillo for sms.
 *
 *
 * whitelisted mobiles
 * test with 9742839040, default OTP 123456
 * test with 8100005474, default OTP 123456
 * */
class SupabaseMyClient {
  static Future<bool> sendOtpToMobile(String mobile) async {
    try {
      final supabase = Supabase.instance;
      await supabase.client.auth.signInWithOtp(phone: mobile);

      // AuthResponse response = await supabase.client.auth.verifyOTP(
      //     phone: "+919742839040", type: OtpType.sms, token: "123456");
      // if (response.user!.aud.toString().toLowerCase() == "authenticated") {}

      return true;
    } catch (e) {
      print("Error sending OTP: $e");
      //e.message
      return false;
    }
  }

  static Future<bool> verifyOtpToMobile(String mobile, String otp) async {
    try {
      final supabase = Supabase.instance;

      AuthResponse response = await supabase.client.auth
          .verifyOTP(phone: mobile, type: OtpType.sms, token: otp);

      if (response.user!.aud.toString().toLowerCase() == "authenticated") {
        return true;
      }

      return false;
    } catch (e) {
      print("Error sending OTP: $e");
      //e.message
      return false;
    }
  }
}
