class Token {
  static String? token="";
  static void storeToken(String t){
    token=t;
  }
  static String? getToken(){
    return token;
  }


}