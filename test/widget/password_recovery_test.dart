import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:viva/app/routes/app_routes.dart';
import 'package:viva/app/theme/app_theme.dart';
import 'package:viva/features/authentication/presentation/artist/artist_login_page.dart';
import 'package:viva/features/authentication/presentation/listener/user_login_page.dart';
import 'package:viva/features/authentication/presentation/password/check_your_inbox_screen.dart';
import 'package:viva/features/authentication/presentation/password/forgot_password_screen.dart';
import 'package:viva/shared/enums/auth_role.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      routes: AppRoutes.routes,
      home: child,
    );
  }

  group('ForgotPasswordScreen Tests', () {
    testWidgets('renders all required Figma UI components', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ForgotPasswordScreen(role: AuthRole.listener),
        ),
      );

      // 1. Back button & VIVA branding
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('VIVA'), findsOneWidget);

      // 2. Heading and Description
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(
        find.text(
          'No worries! Enter your email address and we\'ll help you reset your password.',
        ),
        findsOneWidget,
      );

      // 3. Email Input Label and Field
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Enter your email address'), findsOneWidget);
      expect(find.byIcon(Icons.mail_outline_rounded), findsOneWidget);

      // 4. Action Button
      expect(find.text('Send Reset Link'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);

      // 5. Footer Link
      expect(find.text('Remember your password?'), findsOneWidget);
      expect(find.text('Back to Login'), findsOneWidget);
    });

    testWidgets('validates empty email field', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ForgotPasswordScreen(role: AuthRole.listener),
        ),
      );

      // Tap Send Reset Link without entering email
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter your email address'), findsOneWidget);
    });

    testWidgets('validates invalid email format', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ForgotPasswordScreen(role: AuthRole.listener),
        ),
      );

      // Enter invalid email
      await tester.enterText(find.byType(TextFormField), 'invalidemail');
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('accepts valid email and enters loading state on submission',
        (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ForgotPasswordScreen(role: AuthRole.listener),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField),
        'user@example.com',
      );
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump(); // Trigger setState for loading

      // Verify progress indicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Advance simulated timer and navigate
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Screen transitioned to Check Your Inbox
      expect(find.text('Check Your Inbox'), findsOneWidget);
    });
  });

  group('CheckYourInboxScreen Tests', () {
    testWidgets('renders all required Figma UI components', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const CheckYourInboxScreen(role: AuthRole.listener),
        ),
      );

      // 1. Back button & VIVA branding
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('VIVA'), findsOneWidget);

      // 2. Heading and Description
      expect(find.text('Check Your Inbox'), findsOneWidget);
      expect(
        find.text(
          'If an account matches your email address, you\'ll receive a password reset link. Open the email and follow the link to choose a new password.',
        ),
        findsOneWidget,
      );

      // 3. Action Button
      expect(find.text('Back to Login'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);

      // 4. Footer Guidance
      expect(find.text('Can\'t find the email?'), findsOneWidget);
      expect(
        find.text('Check your spam or junk folder.'),
        findsOneWidget,
      );
      expect(
        find.text('It may take a few minutes to arrive.'),
        findsOneWidget,
      );
    });

    testWidgets('navigates to listener login when originating role is listener',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          home: const CheckYourInboxScreen(role: AuthRole.listener),
        ),
      );

      await tester.tap(find.text('Back to Login'));
      await tester.pumpAndSettle();

      // Verifies Listener UserLoginPage is mounted
      expect(find.byType(UserLoginPage), findsOneWidget);
      expect(find.text('Welcome Back!'), findsOneWidget);
    });

    testWidgets('navigates to artist login when originating role is artist',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          home: const CheckYourInboxScreen(role: AuthRole.artist),
        ),
      );

      await tester.tap(find.text('Back to Login'));
      await tester.pumpAndSettle();

      // Verifies Artist LoginPage is mounted
      expect(find.byType(ArtistLoginPage), findsOneWidget);
      expect(find.text('FOR ARTISTS'), findsOneWidget);
    });
  });

  group('Full Role-Preserving Navigation Flows', () {
    testWidgets('Listener Login -> Forgot Password -> Check Your Inbox -> Listener Login',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          home: const UserLoginPage(),
        ),
      );

      // Tap Forgot Password? on Listener login
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordScreen), findsOneWidget);

      // Submit valid email
      await tester.enterText(find.byType(TextFormField), 'listener@test.com');
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.byType(CheckYourInboxScreen), findsOneWidget);

      // Tap Back to Login
      await tester.tap(find.text('Back to Login'));
      await tester.pumpAndSettle();

      // Returns to Listener login
      expect(find.byType(UserLoginPage), findsOneWidget);
    });

    testWidgets('Artist Login -> Forgot Password -> Check Your Inbox -> Artist Login',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          routes: AppRoutes.routes,
          home: const ArtistLoginPage(),
        ),
      );

      // Tap Forgot Password? on Artist login
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordScreen), findsOneWidget);

      // Submit valid email
      await tester.enterText(find.byType(TextFormField), 'artist@test.com');
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.byType(CheckYourInboxScreen), findsOneWidget);

      // Tap Back to Login
      await tester.tap(find.text('Back to Login'));
      await tester.pumpAndSettle();

      // Returns to Artist login
      expect(find.byType(ArtistLoginPage), findsOneWidget);
    });
  });
}
