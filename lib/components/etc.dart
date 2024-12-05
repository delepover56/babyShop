import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:toastification/toastification.dart';

ToastificationItem errorToast(String errorMessage) {
  return toastification.show(
    type: ToastificationType.error,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    description: Text(
      errorMessage,
      style: GoogleFonts.lato(
        fontSize: 12,
      ),
    ),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: const HugeIcon(
      icon: HugeIcons.strokeRoundedUnavailable,
      color: Colors.red,
      size: 24.0,
    ),
    showIcon: true,
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

ToastificationItem successToast(String message) {
  return toastification.show(
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    description: Text(message),
    alignment: Alignment.topCenter,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    icon: const HugeIcon(
      icon: HugeIcons.strokeRoundedTick01,
      color: Colors.green,
      size: 24.0,
    ),
    showIcon: true,
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: true,
    applyBlurEffect: false,
  );
}

String getCustomErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is not valid. Please enter a valid email address (e.g., user@example.com).';

    case 'email-already-in-use':
      return 'This email address is already associated with another account. Please use a different email address.';

    case 'weak-password':
      return 'Your password is too weak. Please use at least 6 characters with a mix of letters, numbers, and symbols.';

    case 'operation-not-allowed':
      return 'This operation is not allowed. Please contact support for assistance.';

    case 'password-does-not-meet-requirements':
      return 'Password should include an uppercase letter, a symbol, and a number. Password must be between 6-12 characters.';

    case 'missing-email':
      return 'Please enter your email address to continue.';

    case 'invalid-credential':
      return 'Incorrect email or password. Or the account doesn\'t exist';

    case 'user-not-found':
      return 'No user found with this email address. Please sign up to create a new account.';

    case 'user-disabled':
      return 'This account has been disabled. Please contact support for assistance.';

    case 'too-many-requests':
      return 'Too many attempts detected. Please try again later.';

    case 'network-request-failed':
      return 'Network error occurred. Please check your internet connection and try again.';

    case 'auth/weak-password':
      return 'The password is too weak. Please choose a stronger password.';

    case 'auth/email-already-in-use':
      return 'This email is already in use. Please use a different email address.';

    case 'auth/invalid-email':
      return 'Invalid email format. Please check the email and try again.';

    case 'auth/user-not-found':
      return 'No user found for this email address. Please check your email or sign up.';

    case 'auth/user-disabled':
      return 'Your account has been disabled. Please contact support for more details.';

    case 'auth/wrong-password':
      return 'Incorrect password. Please try again or reset your password.';

    default:
      return 'An unknown error occurred. Please try again or contact support if the issue persists.';
  }
}
