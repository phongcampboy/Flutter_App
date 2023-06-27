// ignore_for_file: prefer_interpolation_to_compose_strings
class ApiUrl {
  // ค่าตัวแปรสำหรับใช้งานจริง
  static const String localBaseURL =
      "http://tmnoffice.dyndns.tv:8000/flutter";
  static const String baseURL = localBaseURL; // ทดสอบที่เครื่องใช้ค่านี้
  static const String login = baseURL + "/tmn_login.php";
  static const String register = baseURL + "/tmn_reg.php";
  static const String addmemberplus = baseURL + "/tmn_addMember.php";
  static const String getmemberplus = baseURL + "/tmn_LoadmeberPlus.php";
  static const String loadmember = baseURL + "/load_member.php";
  static const String deluser = baseURL + "/tmndel.php";
}
