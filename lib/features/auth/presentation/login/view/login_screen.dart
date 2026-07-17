import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharma_link/features/auth/presentation/register/view/register_screen.dart';

import '../../../../../core/constant/color_const.dart';
import '../../../../../core/constant/svg_const.dart';
import '../../../../home/presentation/view/home_screen.dart';
import '../cubit/login_cubit.dart';
import '../state/login_state.dart';
import '../widget/pharma_button.dart';
import '../widget/pharma_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    context.read<LoginCubit>().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: Text(state.error),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        if (state is LoginSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConst.bgLight,

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const SizedBox(height: 20),

                  Container(
                    width: 110,
                    height: 110,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,

                      border: Border.all(color: ColorConst.border, width: 1),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),

                    child: SvgPicture.asset(SvgConst.pharmaLinkLogo),
                  ),

                  const SizedBox(height: 34),

                  Text(
                    "Welcome back",

                    textAlign: TextAlign.center,

                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Newsreader',
                      fontWeight: FontWeight.w700,
                      fontSize: 42,
                      color: ColorConst.primary,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Access your premium pharmacy dashboard",

                    textAlign: TextAlign.center,

                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'HankenGrotesk',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorConst.neutral,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 36),

                  Container(
                    width: size.width,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(36),

                      border: Border.all(color: ColorConst.border, width: 1),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.035),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        PharmaTextField(
                          controller: emailController,
                          title: 'Email Address',
                          hint: 'dr.smith@pharmalink.com',
                          prefixIcon: Icons.mail_outline,
                          obscureText: false,
                        ),

                        const SizedBox(height: 24),

                        PharmaTextField(
                          controller: passwordController,
                          title: 'Password',
                          hint: '........',
                          prefixIcon: Icons.lock_outline,
                          obscureText: isPasswordHidden,

                          suffixIcon: TextButton(
                            onPressed: () {
                              togglePassword();
                            },

                            child: isPasswordHidden
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: ColorConst.primary,
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    color: ColorConst.primary,
                                  ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        PharmaButton(
                          onPressed: () {
                            login();
                          },
                          text: "Sign In",
                          buttonIcon: Icons.arrow_forward_ios_rounded,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 26),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Text(
                        "Need an account?",

                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: ColorConst.neutral,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },

                        child: const Text(
                          "Click here",

                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: ColorConst.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
