import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberButton extends StatelessWidget {
  final String phoneNumber;
  final Function(String verificationId) onVerificationCompleted;

  VerifyPhoneNumberButton({required this.phoneNumber, required this.onVerificationCompleted});

  Future<void> _verifyPhoneNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        onVerificationCompleted(auth.currentUser!.uid);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure, e.g., wrong phone number format.
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID to be used later.
        onVerificationCompleted(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout, if needed.
        // You can handle this event if the verification code is not received automatically.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _verifyPhoneNumber,
      child: Text('Verify Phone Number'),
    );
  }
}
