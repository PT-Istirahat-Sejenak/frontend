class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';

  static const selectRole = '/select-role';

  //Donor Auth Routes
  static const donorLogin = '/donor/login';
  static const donorRegister = '/donor/register';
  static const donorRegisterSuccess = '/donor/register-success';
  static const donorForgetPassword = '/donor/forget-password';
  static const donorVerificationCode = '/donor/verification-code';
  static const donorNewPassword = '/donor/new-password';

  //Donor Screen Routes
  static const donorNav = '/donor/nav';
  static const donorHome = '/donor/home';
  static const donorNotification = '/donor/notification';
  static const donorHistory = '/donor/history';
  static const donorReward = '/donor/reward';
  static const donorRewardHistory = '/donor/reward/history';
  static const donorRewardDetail = '/donor/reward/detail';
  static const donorProfile = '/donor/profile';
  static const donorRequest = '/donor/request';

  //Seeker Auth Routes
  static const seekerLogin = '/seeker/login';
  static const seekerRegister = '/seeker/register';
  static const seekerForgetPassword = '/seeker/forget-password';
  static const seekerVerificationCode = '/seeker/verification-code';
  static const seekerNewPassword = '/seeker/new-password';

  //Seeker Screen Routes
  static const seekerNav = '/seeker/nav';
  static const seekerHome = '/seeker/home';
  static const seekerNotification = '/seeker/notification';
  static const seekerSearchDonor = '/seeker/search-donor';
  static const seekerProfile = '/seeker/profile';

  //Education Routes
  static const donorEducation = '/donor/education';
  static const seekerEducation = '/seeker/education';
  static const String donorEducationDetail = '/donor/education/detail';
  static const String seekerEducationDetail = '/seeker/education/detail';

  //Chatbot Routes
  static const donorChatbot = '/donor/education/chatbot';
  static const seekerChatbot = '/seeker/education/chatbot';
}