class SignUpBody{
  String name;
  String email;
  String phone;
  String password;

  SignUpBody({required this.name, required this.email, required this.phone, required this.password});


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map();
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["password"] = password;
    return data;
  }

}