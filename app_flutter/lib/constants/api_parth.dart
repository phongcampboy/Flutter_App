// ignore_for_file: prefer_interpolation_to_compose_strings

class ApiUrl {
  // ค่าตัวแปรสำหรับใช้งานจริง
   static const String localBaseURL = "https://10.0.2.2:443/demo/api";
   static const String baseURL = localBaseURL; // ทดสอบที่เครื่องใช้ค่านี้
  static const String login = baseURL + "/user/authen";
  static const String register = baseURL + "/user/create";
}