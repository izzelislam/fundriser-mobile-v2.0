class LoginModel{
  final String? phoneNumber;
  final String? password;

  LoginModel({this.phoneNumber, this.password});

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "password": password
  };
}