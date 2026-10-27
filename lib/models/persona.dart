final RegExp emailRegExp = RegExp("^\\w+@\\w+\\.\\w+\$", multiLine: true);

class Persona {
  String fullName = "";
  String _email = "abc@def.com";
  DateTime _birthDate = DateTime(2000);

  Persona();
  Persona.create(this.fullName, String email, DateTime birthDate) {
    this.email = email;
    this.birthDate = birthDate;
  }

  String get email => _email;
  set email(String value) {
    if(!emailRegExp.hasMatch(value)) {
      throw ArgumentError.value(value, "value");
    }
    _email = value;
  }

  DateTime get birthDate => _birthDate;
  set birthDate(DateTime value) {
    if(value.year <= 1900 || value.isAfter(DateTime.now())) {
      throw ArgumentError.value(value.toString(), "value");
    }
    _birthDate = value;
  }
}