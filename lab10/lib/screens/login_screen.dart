import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscurePassword = true;
  String? emailError;
  String? passwordError;

  // User database
  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "username": "johnd",
      "password": "m38rmF\$",
      "email": "john@gmail.com",
      "name": {"firstname": "john", "lastname": "doe"}
    },
    {
      "id": 2,
      "username": "mor_2314",
      "password": "83r5^_",
      "email": "morrison@gmail.com",
      "name": {"firstname": "david", "lastname": "morrison"}
    },
    {
      "id": 3,
      "username": "kevinryan",
      "password": "kev02937@",
      "email": "kevin@gmail.com",
      "name": {"firstname": "kevin", "lastname": "ryan"}
    },
    {
      "id": 4,
      "username": "donero",
      "password": "ewedon",
      "email": "don@gmail.com",
      "name": {"firstname": "don", "lastname": "romer"}
    },
    {
      "id": 5,
      "username": "derek",
      "password": "jklg*_56",
      "email": "derek@gmail.com",
      "name": {"firstname": "derek", "lastname": "powell"}
    },
    {
      "id": 6,
      "username": "david_r",
      "password": "3478*#54",
      "email": "david_r@gmail.com",
      "name": {"firstname": "david", "lastname": "russell"}
    },
    {
      "id": 7,
      "username": "snyder",
      "password": "f238&@*\$",
      "email": "miriam@gmail.com",
      "name": {"firstname": "miriam", "lastname": "snyder"}
    },
    {
      "id": 8,
      "username": "hopkins",
      "password": "William56\$hj",
      "email": "william@gmail.com",
      "name": {"firstname": "william", "lastname": "hopkins"}
    },
    {
      "id": 9,
      "username": "kate_h",
      "password": "kfejk@*_",
      "email": "kate@gmail.com",
      "name": {"firstname": "kate", "lastname": "hale"}
    },
    {
      "id": 10,
      "username": "jimmie_k",
      "password": "klein*#%*",
      "email": "jimmie@gmail.com",
      "name": {"firstname": "jimmie", "lastname": "klein"}
    }
  ];

  bool _validateInputs() {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    bool isValid = true;

    if (emailController.text.isEmpty) {
      setState(() => emailError = "Username cannot be empty");
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      setState(() => passwordError = "Password cannot be empty");
      isValid = false;
    }

    return isValid;
  }

  void login() {
    if (!_validateInputs()) return;

    setState(() => isLoading = true);

    // Check credentials against user database
    final user = users.firstWhere(
      (u) => u["username"] == emailController.text && u["password"] == passwordController.text,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/products');
    } else {
      setState(() => isLoading = false);
      _showErrorDialog("Invalid Credentials", "Username or password is incorrect");
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade700, Colors.blue.shade400],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Header
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 60,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Welcome Text
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sign in to continue shopping",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Username Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "(ชื่อผู้ใช้)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: emailController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText: "",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.person, color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            errorText: emailError,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Password (รหัสผ่าน)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: passwordController,
                          enabled: !isLoading,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: "",
                            filled: true,

                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                              child: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.blue,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            errorText: passwordError,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                                ),
                              )
                            : const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Demo Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Text(
                        "Demo: Try 'johnd' / 'm38rmF\$'\nOr any username from the database",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}