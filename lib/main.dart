import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//models
import 'package:donora_dev/models/education_article.dart';
import 'package:donora_dev/models/user_role.dart';

//routes
import 'routes/app_routes.dart';
import 'package:donora_dev/routes/education_routes.dart';

//providers
import 'providers/auth_donor_provider.dart';
import 'providers/auth_seeker_provider.dart';
import 'providers/password_checkbox_provider.dart';
import 'providers/user_provider.dart';

//welcome screens
import 'screens/splash/splash_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/role/role_selection_screen.dart';

//education screens
import 'package:donora_dev/screens/education/education_detail_screen.dart';

//chatbot

//donor auth
import 'screens/auth/donor/donor_login_screen.dart';
import 'screens/auth/donor/donor_register_screen.dart';
import 'screens/auth/donor/donor_register_screen2.dart';
import 'screens/auth/password/donor_forget_password_screen.dart';
import 'screens/auth/password/donor_verification_code_screen.dart';
import 'screens/auth/password/donor_new_password_screen.dart';

//donor screens
import 'screens/donor/donor_nav.dart';
import 'screens/donor/donor_home_screen.dart';
import 'screens/donor/donor_notification_screen.dart';
import 'screens/donor/donor_history_screen.dart';
import 'screens/donor/donor_reward_screen.dart';

//seeker auth
import 'screens/auth/seeker/seeker_login_screen.dart';
import 'screens/auth/seeker/seeker_register_screen.dart';
import 'screens/auth/password/seeker_forget_password_screen.dart';
import 'screens/auth/password/seeker_verification_code_screen.dart';
import 'screens/auth/password/seeker_new_password_screen.dart';

//seeker screens
import 'screens/seeker/seeker_nav.dart';
import 'screens/seeker/seeker_home_screen.dart';
import 'screens/seeker/seeker_search_donor_screen.dart';
import 'screens/seeker/seeker_notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthDonorProvider()),
        ChangeNotifierProvider(create: (_) => AuthSeekerProvider()),
        ChangeNotifierProvider(create: (_) => PasswordCheckboxProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserFromPrefs()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return MaterialApp(
            title: 'Donora',
            debugShowCheckedModeBanner: false,
            // theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: (settings) {
              // Handle education routes
              if ((settings.name == AppRoutes.donorEducation || 
                   settings.name == AppRoutes.donorEducationDetail) && 
                  userProvider.role == UserRole.pendonor) {
                return EducationRoutes.generateRoute(settings, UserRole.pendonor);
              } 
              
              if ((settings.name == AppRoutes.seekerEducation || 
                   settings.name == AppRoutes.seekerEducationDetail) && 
                  userProvider.role == UserRole.pencari) {
                return EducationRoutes.generateRoute(settings, UserRole.pencari);
              }
              
              // Handle regular routes
              switch (settings.name) {
                case AppRoutes.splash:
                  return MaterialPageRoute(builder: (_) => const SplashScreen());
                case AppRoutes.onboarding:
                  return MaterialPageRoute(builder: (_) => const OnboardingScreen());
                case AppRoutes.selectRole:
                  return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
                
                // Handle Donor Auth Routes
                case AppRoutes.donorLogin:
                  return MaterialPageRoute(builder: (_) => DonorLoginScreen());
                case AppRoutes.donorRegister:
                  return MaterialPageRoute(builder: (_) => DonorRegisterScreen());
                case AppRoutes.donorRegisterSuccess:
                  return MaterialPageRoute(builder: (_) => DonorRegisterScreen2(
                    name: '',
                    dateOfBirth: '',
                    email: '',
                    gender: '',
                    address: '',
                    phoneNumber: '',
                    password: '',
                    confirmPassword: '',
                    profileImage: null,                  
                  ));
                case AppRoutes.donorForgetPassword:
                  return MaterialPageRoute(builder: (_) => const DonorForgotPasswordScreen());
                case AppRoutes.donorVerificationCode:
                  return MaterialPageRoute(builder: (_) => DonorVerificationCodeScreen(donorEmail: ''));
                case AppRoutes.donorNewPassword:
                  return MaterialPageRoute(builder: (_) => const DonorNewPasswordScreen());

                // Handle Donor Screen Routes
                case AppRoutes.donorNav:
                  return MaterialPageRoute(builder: (_) => const DonorNav());
                case AppRoutes.donorHome:
                  return MaterialPageRoute(builder: (_) => const DonorHomeScreen());
                case AppRoutes.donorNotification:
                  return MaterialPageRoute(builder: (_) => const DonorNotificationScreen());
                case AppRoutes.donorHistory:
                  return MaterialPageRoute(builder: (_) => const DonorHistoryScreen());
                case AppRoutes.donorReward:
                  return MaterialPageRoute(builder: (_) => const DonorRewardScreen());        

                // Handle Seeker Auth Routes
                case AppRoutes.seekerLogin:
                  return MaterialPageRoute(builder: (_) => SeekerLoginScreen());
                case AppRoutes.seekerRegister:
                  return MaterialPageRoute(builder: (_) => SeekerRegisterScreen());
                case AppRoutes.seekerForgetPassword:
                  return MaterialPageRoute(builder: (_) => const SeekerForgotPasswordScreen());
                case AppRoutes.seekerVerificationCode:
                  return MaterialPageRoute(builder: (_) => SeekerVerificationCodeScreen(seekerEmail: ''));
                case AppRoutes.seekerNewPassword:
                  return MaterialPageRoute(builder: (_) => const SeekerNewPasswordScreen());
                
                // Handle Seeker Screen Routes
                case AppRoutes.seekerNav:
                  return MaterialPageRoute(builder: (_) => const SeekerNav());
                case AppRoutes.seekerHome:                  
                  return MaterialPageRoute(
                    builder: (_) => const SeekerHomeScreen(),
                    settings: settings 
                  );
                case AppRoutes.seekerNotification:
                  return MaterialPageRoute(builder: (_) => const SeekerNotificationScreen());
                case AppRoutes.seekerSearchDonor:
                  return MaterialPageRoute(builder: (_) => const SeekerSearchDonorScreen());
                
                case AppRoutes.donorEducationDetail:
                  final article = settings.arguments as EducationArticle;
                  return MaterialPageRoute(
                    builder: (_) => EducationDetailScreen(
                      article: article,
                      userRole: UserRole.pendonor,
                    ),
                  );

                case AppRoutes.seekerEducationDetail:
                  final article = settings.arguments as EducationArticle;
                  return MaterialPageRoute(
                    builder: (_) => EducationDetailScreen(
                      article: article,
                      userRole: UserRole.pencari,
                    ),
                  );
                default:
                  // Return a 404 page or redirect to home
                  return MaterialPageRoute(builder: (_) => Scaffold(
                    body: Center(
                      child: Text('Route not found: ${settings.name}'),
                    ),
                  ));
              }
            },
          );
        }
      ),
    );
  }
}
