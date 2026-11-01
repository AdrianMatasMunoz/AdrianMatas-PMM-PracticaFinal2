import 'package:flutter/material.dart';
import 'package:practica_final_2/models/persona.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  bool _isInitialized = false;

  late Persona persona;
  late String _firstName;
  late String _surname;
  late String _email;
  late String _password;
  late DateTime _birthDate;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool _isFormValid() => !(_firstName.isEmpty || _surname.isEmpty || _email.isEmpty || !emailRegExp.hasMatch(_email) || _password.isEmpty);

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    String year = date.year.toString().padLeft(4, '0');
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(!_isInitialized) {
      _isInitialized = true;
      
      persona = ModalRoute.of(context)!.settings.arguments as Persona;
      _firstNameController.text = _firstName = persona.firstName;
      _surnameController.text = _surname = persona.firstSurname;
      _emailController.text = _email = persona.email;
      _password = "";
      _birthDate = persona.birthDate;
      _dateController.text = formatDate(_birthDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${persona.firstSurname} - Edit Profile"),
      ),
      body: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .max,
        children: [
          TextField(
            textCapitalization: .words,
            controller: _firstNameController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.person_rounded),
              hintText: "First name",
              labelText: "First name",
              errorText: _firstName.isEmpty ? "Required field" : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            onChanged: (String value) => setState(() {
              _firstName = value;
            }),
          ),
          SizedBox(height: 10,),
          TextField(
            textCapitalization: .words,
            controller: _surnameController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.person_rounded),
              hintText: "Surname",
              labelText: "Surname",
              errorText: _surname.isEmpty ? "Required field" : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            onChanged: (String value) => setState(() {
              _surname = value;
            })
          ),
          SizedBox(height: 10,),
          TextField(
            textCapitalization: .none,
            controller: _emailController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.alternate_email_outlined),
              hintText: "Email",
              labelText: "Email",
              errorText: _email.isEmpty ? "Required field" : (!emailRegExp.hasMatch(_email) ? "Not an email" : null),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            keyboardType: .emailAddress,
            onChanged: (String value) => setState(() {
              _email = value;
            })
          ),
          SizedBox(height: 10,),
          TextField(
            obscureText: true,
            textCapitalization: .none,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.password_rounded),
              hintText: "Password",
              labelText: "Password",
              errorText: _password.isEmpty ? "Required field" : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            onChanged: (String value) => setState(() {
              _password = value;
            })
          ),
          SizedBox(height: 10,),
          TextField(
            enableInteractiveSelection: false,
            controller: _dateController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.calendar_month_rounded),
              hintText: "Birth date",
              labelText: "Birth date",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            onTap: () {
              _selectDate(context);
            }
          ),
          SizedBox(height: 20,),
          Text(
            !_isFormValid() ? "Please correct the form." : "",
            style: TextStyle(
              color: Colors.red
            ),
          ),
          TextButton(
            onPressed: () {
              if(_isFormValid()) {
                Navigator.pop(context, Persona.create("$_firstName $_surname", _email, _birthDate));
              }
            },
            child: Text("Save and Return")
          )
        ],
      )
    );
  }

  Future<void> _selectDate(BuildContext context) async{
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if(selectedDate != null) {
      setState(() {
        _birthDate = selectedDate;
        _dateController.text = formatDate(_birthDate);
      });
    }
  }
}