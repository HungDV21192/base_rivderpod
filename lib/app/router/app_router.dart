import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_demo/app/settings/auth_status_provider.dart';
import 'package:riverpod_demo/features/auth/sign_in/sign_in_page.dart';
import 'package:riverpod_demo/features/auth/sign_up/sign_up_screen.dart';
import 'package:riverpod_demo/features/home/views/home_page.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final isLoggedIn = ref.watch(authStatusProvider);

  return GoRouter(
    initialLocation: '/sign_in',
    // redirect: (context, state) {
    //   final isLoggingIn = state.matchedLocation == '/sign_in';
    //   // Nếu chưa sign_in mà cố tình vào các trang khác -> Đá về /sign_in
    //   if (!isLoggedIn) {
    //     return '/sign_in';
    //   }
    //   // Nếu đã sign_in rồi mà vẫn ở trang /sign_in -> Đẩy vào /home
    //   if (isLoggedIn && isLoggingIn) {
    //     return '/';
    //   }
    //   // Các trường hợp khác cho phép đi tiếp
    //   return null;
    // },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/sign_in', builder: (context, state) => const SignInScreen()),
      GoRoute(path: '/sign_up', builder: (context, state) => const SignUpScreen()),
    ],
    // Logic Redirect nếu cần bảo mật ở mức router
  );
}
