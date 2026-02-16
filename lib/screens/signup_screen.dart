import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _auth = AuthService();
  final _firestore = FirestoreService();
  bool _isLoading = false;
  bool _agreedToTerms = false;

  void _signup() async {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the terms and conditions')),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      final user = await _auth.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        // Create user profile in Firestore
        await _firestore.createUserData(
          user.uid, 
          user.email!, 
          _nameController.text.trim(),
        );

        if (mounted) {
          // Success! Navigate to Login
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account created! Please log in.')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Signup failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header / Brand
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'LIVETOURA',
                      style: TextStyle(
                        fontFamily: 'Cursive', // Fallback if not available
                        fontSize: 24,
                        color: Color(0xFFB3261E), // Red accent for brand
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (_) => const LoginScreen())
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 30),

                // 2. Hero Image Representation
                // Using a Container to mimic the "Dirtbike" image area, but with an illustration
                Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                     color: Colors.grey.shade50,
                     borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                       Icon(Icons.sports_soccer, size: 120, color: Colors.blue.withOpacity(0.2)),
                       const Positioned(
                         bottom: 20,
                         child: Icon(Icons.star, size: 40, color: Colors.orange),
                       )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 3. Title
                const Text(
                  'LIVETOURA CHAMPIONSHIP\nREGISTRATION',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    height: 1.2,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 40),

                // 4. Form Fields
                _buildLabel('Full Name'),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'John Doe',
                    suffixIcon: Icon(Icons.person_outline, color: Colors.grey.shade600),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),

                _buildLabel('Email ID'),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'john@example.com',
                    suffixIcon: Icon(Icons.alternate_email, color: Colors.grey.shade600),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 20),

                _buildLabel('Password'),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
                
                const SizedBox(height: 30),

                // 5. Terms Checkbox
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
                        activeColor: const Color(0xFFB3261E), // Red accent
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'I agree to all the terms & conditions',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // 6. Register Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB3261E), // Red to match original screenshot
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'REGISTER NOW',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                  ),
                ),
                
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text('Already have an account? Login', style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
