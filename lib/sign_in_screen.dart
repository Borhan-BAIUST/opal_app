import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:opal_app/otp_screen.dart';
class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> createUserMutation() async {
    final String createUserMutation = '''
      mutation CreateUser(\$input: CreateUserInput!) {
        createUser(input: \$input) {
          user {
            id
            username
            cpf
            firstName
            lastName
          }
        }
      }
    ''';

    final MutationOptions options = MutationOptions(
      document: gql(createUserMutation),
      variables: <String, dynamic>{
        'input': {
          'username': _userNameController.text,
          'cpf': _cpfController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
        },
      },
    );

    final QueryResult result = await GraphQLProvider.of(context).value.mutate(options);

    if (!result.hasException) {
      final user = result.data!['createUser']['user'];
      final token = user['token'];
      print('User created: $user');
      print("User token:$token");
    } else {
      final errorMessage = result.exception.toString();
      print('Error creating user: $errorMessage');
    }
  }

  void _createUser() async{
    if (_formKey.currentState!.validate()) {
     await createUserMutation();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.blueAccent,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 140, left: 130, right: 113),
                  child: Text(
                    "App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'Username',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _cpfController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Cpf',
                            hintText: 'Cpf',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Cpf';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _firstNameController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: const InputDecoration(
                            labelText: 'FirstName',
                            hintText: 'FirstName',
                            border: OutlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: const InputDecoration(
                            labelText: 'LastName',
                            hintText: 'LastName',
                            border: OutlineInputBorder(),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.normal),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a last name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: _createUser,
                    child: Text("Create User"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
               /* Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpScreen()),
                      );
                    },
                    child: Text("Otp Screen"),
                  ),
                ),*/
                SizedBox(height: screenHeight * 0.02),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}