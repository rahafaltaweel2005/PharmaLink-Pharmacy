import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_link/features/auth/presentation/login/view/login_screen.dart';
import 'package:pharma_link/features/auth/presentation/register/state/register_state.dart';
import '../../../../../core/constant/color_const.dart';
import '../../login/widget/pharma_button.dart';
import '../../login/widget/pharma_text_field.dart';
import '../cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController controller = PageController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();

  int currentPage = 0;

  bool isPasswordHidden = true;

  @override
  void dispose() {
    controller.dispose();

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();

    doctorNameController.dispose();
    locationController.dispose();
    licenseNumberController.dispose();

    super.dispose();
  }

  void register() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final phone = phoneNumberController.text.trim();
    final doctorName = doctorNameController.text.trim();
    final location = locationController.text.trim();
    final licenseNumber = licenseNumberController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phone.isEmpty ||
        doctorName.isEmpty ||
        location.isEmpty ||
        licenseNumber.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    context.read<RegisterCubit>().register(
      name: name,
      email: email,
      password: password,
      phoneNumber: phone,
      doctorName: doctorName,
      location: location,
      licenseNumber: licenseNumber,
    );
  }

  void togglePassword() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgLight,

      appBar: AppBar(
        backgroundColor: ColorConst.bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: const Text(
          "PharmaLink",

          style: TextStyle(
            color: ColorConst.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            fontFamily: 'Newsreader',
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              const Text(
                "Create your\naccount",

                style: TextStyle(
                  height: 1.1,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: ColorConst.primary,
                  fontFamily: 'Newsreader',
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "Join our network of premium pharmacies to\nstreamline your operations and patient care.",

                style: TextStyle(
                  color: ColorConst.neutral,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: List.generate(
                  3,

                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),

                      height: 5,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: index == currentPage
                            ? ColorConst.primary
                            : const Color(0xFFE7E5E4),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    }

                    if (state is RegisterSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },

                  builder: (context, state) {
                    return PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,

                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },

                      children: [
                        SingleChildScrollView(
                          child: _buildCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const Text(
                                  "Pharmacy Details",

                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConst.primary,
                                    fontFamily: 'Newsreader',
                                  ),
                                ),

                                const SizedBox(height: 28),

                                PharmaTextField(
                                  controller: nameController,
                                  title: "Pharmacy Name",
                                  hint: "e.g. Lavender Apothecary",
                                  prefixIcon: Icons.local_pharmacy_outlined,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 20),

                                PharmaTextField(
                                  controller: emailController,
                                  title: "Email Address",
                                  hint: "contact@pharmacy.com",
                                  prefixIcon: Icons.email_outlined,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 20),

                                PharmaTextField(
                                  controller: phoneNumberController,
                                  title: "Phone Number",
                                  hint: "+1 (555) 000-0000",
                                  prefixIcon: Icons.phone_outlined,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 20),

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

                                const SizedBox(height: 35),

                                PharmaButton(
                                  text: "Next Step",

                                  onPressed: () {
                                    controller.nextPage(
                                      duration: const Duration(
                                        milliseconds: 350,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: _buildCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const SizedBox(height: 28),

                                PharmaTextField(
                                  controller: doctorNameController,
                                  title: "doctor Name",
                                  hint: "Dr.Kamal",
                                  prefixIcon: Icons.person_outline,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 20),

                                PharmaTextField(
                                  controller: locationController,
                                  title: "Address",
                                  hint: "Amman",
                                  prefixIcon: Icons.location_on_outlined,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 20),

                                PharmaTextField(
                                  controller: licenseNumberController,
                                  title: 'License Number',
                                  hint: '........',
                                  prefixIcon: Icons.document_scanner_outlined,
                                  obscureText: false,
                                ),

                                const SizedBox(height: 35),
                                currentPage == 2
                                    ? PharmaButton(
                                        text: "Next Step",

                                        onPressed: () {
                                          controller.nextPage(
                                            duration: const Duration(
                                              milliseconds: 350,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                      )
                                    : PharmaButton(
                                        onPressed: () {
                                          controller.nextPage(
                                            duration: const Duration(
                                              milliseconds: 350,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                          context
                                              .read<RegisterCubit>()
                                              .register(
                                                name: nameController.text
                                                    .trim(),
                                                email: emailController.text
                                                    .trim(),
                                                password:
                                                    passwordController.text,
                                                phoneNumber:
                                                    phoneNumberController.text
                                                        .trim(),
                                                doctorName: doctorNameController
                                                    .text
                                                    .trim(),
                                                location: locationController
                                                    .text
                                                    .trim(),
                                                licenseNumber:
                                                    licenseNumberController.text
                                                        .trim(),
                                              );
                                        },
                                        text: "Create Account",
                                        buttonIcon:
                                            Icons.arrow_forward_ios_rounded,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: _buildCard(
                            child: Column(
                              children: [
                                const SizedBox(height: 28),

                                Text(
                                  "Account under review",
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConst.primary,
                                    fontFamily: 'Newsreader',
                                  ),
                                ),

                                const SizedBox(height: 10),
                                Text(
                                  "Our clinical verification team is \ncurrently reviewing your credentials \nto ensure the highest standards of \npharmacy safety.",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConst.primary,
                                    fontFamily: 'Newsreader',
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0x7BF1EAE1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFFEADFD9),
                                    ),
                                  ),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: Color(0xFF705450),
                                          size: 40,
                                        ),
                                        Text(
                                          "Timeframe",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConst.textDark,
                                            fontFamily: 'Newsreader',
                                          ),
                                        ),
                                        Text(
                                          "24-48 Hours",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConst.textDark,
                                            fontFamily: 'Newsreader',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Color(0x7BF1EAE1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFFEADFD9),
                                    ),
                                  ),
                                  child: Expanded(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.shield_outlined,
                                          color: Color(0xFF705450),
                                          size: 40,
                                        ),
                                        Text(
                                          "Compliance",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: ColorConst.textDark,
                                            fontFamily: 'Newsreader',
                                          ),
                                        ),
                                        Text(
                                          "Level 3 Audit",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConst.textDark,
                                            fontFamily: 'Newsreader',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 35),
                                PharmaButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  text: "Ok",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
        border: Border.all(color: const Color(0xFFE8DDD7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
