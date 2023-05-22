class SignUpBody{
  String name;
  String email;
  String phone;
  String password;
  SignUpBody({
    required this.password,
    required this.email,
    required this.phone,
    required this.name,
});

  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data=new Map<String,dynamic>();
    data["f_name"]=this.name;
    data["phone"]=this.phone;
    data["password"]=this.password;
    data["email"]=this.email;
    return data;
  }
}