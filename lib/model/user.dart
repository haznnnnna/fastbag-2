class User{
  final String mobileNumber;
  User({required this.mobileNumber});
  Map<String,dynamic> toJson(){
    return{
      "mobile_number":mobileNumber
    };
  }
}