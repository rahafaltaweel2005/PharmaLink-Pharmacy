import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pharma_link/core/constant/app_const.dart';
import 'package:pharma_link/core/storage/secure_storage_helper.dart';

import '../../../../core/constant/color_const.dart';
import '../../../../core/constant/svg_const.dart';
import '../../../auth/presentation/login/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  Future<void> checkLogin() async {
    await Future.delayed(Duration(seconds: 4));
    final token = await SecureStorageHelper.read(key: AppConst.accessTokenKey);
    if (!mounted) return;
    if (token == null || token.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    checkLogin();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                const Spacer(flex: 2),

                Container(
                  width: 150,
                  height: 150,

                  padding: const EdgeInsets.all(26),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: Colors.white,

                    border: Border.all(
                      width: 1.5,
                      color: ColorConst.border,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 28,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),

                  child: SvgPicture.asset(
                    SvgConst.pharmaLinkLogo,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 34),

                Text(
                  "PharmaLink",

                  textAlign: TextAlign.center,

                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Newsreader',
                    fontWeight: FontWeight.w700,
                    fontSize: 42,
                    color: ColorConst.primary,
                    letterSpacing: 0.3,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "ELEVATED CARE SYSTEMS",

                  textAlign: TextAlign.center,

                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'HankenGrotesk',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 2,
                    color: ColorConst.neutral.withValues(alpha: 0.7),
                  ),
                ),

                const Spacer(flex: 2),

                LoadingAnimationWidget.waveDots(
                  color: ColorConst.primary,
                  size: 30,
                ),

                const SizedBox(height: 18),

                Text(
                  "INITIALIZING SECURE VAULT",

                  textAlign: TextAlign.center,

                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: 'HankenGrotesk',
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.8,
                    color: ColorConst.neutral.withValues(alpha: 0.7),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
