import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';
import 'package:pettrove/bloc/auth/auth_event.dart';
import 'package:pettrove/bloc/auth/auth_state.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'package:pettrove/models/pets.dart';
import 'package:pettrove/presentation/screens/auth/_auth/otp.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';
import 'package:pettrove/presentation/screens/current_page.dart';

class ComplateProfileScreen extends StatelessWidget {
  const ComplateProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Complete Profile",
                       style: TextStyle(
                          color: Color.fromRGBO(22, 51, 0, 1),
                          fontSize: 36,
                          fontFamily: "Neue Plak",
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Complete your details or continue \nwith social media",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF757575)),
                    ),
                    // const SizedBox(height: 16),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const CompleteProfileForm(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        
                    const Text(
                      "By continuing your confirm that you agree \nwith our Term and Condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF757575),
                      ),
                    ),
                    ExistingUser()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class ExistingUser extends StatelessWidget {
  const ExistingUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Existing User ? ",
          style: TextStyle(color: Color(0xFF757575)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Color.fromRGBO(140, 207, 99, 1),
            ),
          ),
        ),
      ],
    );
  }
}
// CompleteProfileForm
class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<String> selectedPets = [];
    bool isLoading = false;


  final List<String> petOptions = ['Dog', 'Cat', 'Rabbit', 'Bird'];

  void togglePetSelection(String pet) {
    setState(() {
      if (selectedPets.contains(pet)) {
        selectedPets.remove(pet);
      } else {
        if (selectedPets.length < 4) {
          selectedPets.add(pet);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You can select up to 4 pets only")),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(22, 51, 0, 1),
                strokeWidth: 4,
              ),
            ),
          );
        } else if (state.isSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile Updated Successfully")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CurrentPage()),
            (route) => false,
          );
        } else if (state.isFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile Update Failed. Please try again.")),
          );
        }
      },
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Enter your name",
                labelText: "Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                  borderSide: const BorderSide(color: Color.fromRGBO(140, 207, 99, 1)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Color.fromRGBO(140, 207, 99, 1)),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Enter your password",
                labelText: "Password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                border: authOutlineInputBorder,
                enabledBorder: authOutlineInputBorder,
                focusedBorder: authOutlineInputBorder.copyWith(
                  borderSide: const BorderSide(color: Color.fromRGBO(140, 207, 99, 1)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Enter your phone",
                  labelText: "Phone",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: const TextStyle(color: Color(0xFF757575)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  border: authOutlineInputBorder,
                  enabledBorder: authOutlineInputBorder,
                  focusedBorder: authOutlineInputBorder.copyWith(
                    borderSide: const BorderSide(color: Color.fromRGBO(140, 207, 99, 1)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ✅ Pet Selection Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Your Pets (Up to 4)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(22, 51, 0, 1),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: petOptions.map((pet) {
                final isSelected = selectedPets.contains(pet);
                return GestureDetector(
                  onTap: () => togglePetSelection(pet),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromRGBO(140, 207, 99, 1)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      pet,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
                        const SizedBox(height: 24),

            BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return isLoading
              ? const Center(child: CircularProgressIndicator())
              :
              ElevatedButton(
                onPressed: () async {
                  if (!state.isVerified) {
                    setState(() {
                      isLoading = true;
                    });
                    // ✅ Trigger Email Verification
                    bool response = await AuthRepository().mailVerification(emailController.text);
                    setState(() {
                      isLoading = false;
                    });
                    if (response) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(email: emailController.text, type: "Verify"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Email verification failed")),
                      );
                    }
                  } else {
                    // ✅ Perform Registration after verification
                    final name = nameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    final phone = phoneController.text;

                    final pets = selectedPets.map((petName) => Pet(
                    id: '',
                    name: petName,
                    vaccinationCount: 0,
                    checkupCount: 0,
                    exerciseCount: 0,
                    feedingCount: 0,
                  )).toList();

                    context.read<RegisterBloc>().add(RegisterSubmitted(
                      name: name,
                      email: email,
                      password: password,
                      phone: phone,
                      pets: pets,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromRGBO(158, 232, 112, 1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    state.isVerified ? "Continue" : "Verify Email", // 
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}


// Icons
const userIcon =
    '''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M14.8331 14.6608C14.6271 14.9179 14.3055 15.0713 13.9729 15.0713H2.02715C1.69446 15.0713 1.37287 14.9179 1.16692 14.6608C0.972859 14.4191 0.906322 14.1271 0.978404 13.8382C1.77605 10.6749 4.66327 8.46512 8.0004 8.46512C11.3367 8.46512 14.2239 10.6749 15.0216 13.8382C15.0937 14.1271 15.0271 14.4191 14.8331 14.6608ZM4.62208 4.23295C4.62208 2.41197 6.13737 0.929467 8.0004 0.929467C9.86263 0.929467 11.3779 2.41197 11.3779 4.23295C11.3779 6.0547 9.86263 7.53565 8.0004 7.53565C6.13737 7.53565 4.62208 6.0547 4.62208 4.23295ZM15.9444 13.6159C15.2283 10.7748 13.0231 8.61461 10.2571 7.84315C11.4983 7.09803 12.3284 5.75882 12.3284 4.23295C12.3284 1.89921 10.387 0 8.0004 0C5.613 0 3.67155 1.89921 3.67155 4.23295C3.67155 5.75882 4.50168 7.09803 5.7429 7.84315C2.97688 8.61461 0.771665 10.7748 0.0556038 13.6159C-0.0861827 14.179 0.0460985 14.7692 0.419179 15.2332C0.808894 15.7212 1.39584 16 2.02715 16H13.9729C14.6042 16 15.1911 15.7212 15.5808 15.2332C15.9539 14.7692 16.0862 14.179 15.9444 13.6159Z" fill="#626262"/>
</svg>
''';

const phoneIcon =
    '''<svg width="11" height="18" viewBox="0 0 11 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M6.33333 15.0893C6.33333 15.5588 5.96 15.9384 5.5 15.9384C5.04 15.9384 4.66667 15.5588 4.66667 15.0893C4.66667 14.6197 5.04 14.2402 5.5 14.2402C5.96 14.2402 6.33333 14.6197 6.33333 15.0893ZM6.83333 2.63135C6.83333 2.91325 6.61 3.14081 6.33333 3.14081H4.66667C4.39 3.14081 4.16667 2.91325 4.16667 2.63135C4.16667 2.34945 4.39 2.12274 4.66667 2.12274H6.33333C6.61 2.12274 6.83333 2.34945 6.83333 2.63135ZM10 15.7923C10 16.4479 9.47667 16.9819 8.83333 16.9819H2.16667C1.52333 16.9819 1 16.4479 1 15.7923V2.2068C1 1.55215 1.52333 1.01807 2.16667 1.01807H8.83333C9.47667 1.01807 10 1.55215 10 2.2068V15.7923ZM8.83333 0H2.16667C0.971667 0 0 0.990047 0 2.2068V15.7923C0 17.01 0.971667 18 2.16667 18H8.83333C10.0283 18 11 17.01 11 15.7923V2.2068C11 0.990047 10.0283 0 8.83333 0Z" fill="#626262"/>
</svg>''';

const locationPointIcon =
    '''<svg width="15" height="18" viewBox="0 0 15 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M7.5 9.3384C6.38263 9.3384 5.47303 8.42383 5.47303 7.30037C5.47303 6.17691 6.38263 5.26235 7.5 5.26235C8.61737 5.26235 9.52697 6.17691 9.52697 7.30037C9.52697 8.42383 8.61737 9.3384 7.5 9.3384ZM7.5 4.24334C5.82437 4.24334 4.45955 5.61476 4.45955 7.30037C4.45955 8.98599 5.82437 10.3574 7.5 10.3574C9.17563 10.3574 10.5405 8.98599 10.5405 7.30037C10.5405 5.61476 9.17563 4.24334 7.5 4.24334ZM12.0894 12.1551L7.5 16.7695L2.9106 12.1551C0.380268 9.61098 0.380268 5.47125 2.9106 2.92711C4.17577 1.6542 5.83704 1.01816 7.5 1.01816C9.16212 1.01816 10.8242 1.65505 12.0894 2.92711C14.6197 5.47125 14.6197 9.61098 12.0894 12.1551ZM12.8064 2.20616C9.88 -0.735387 5.12 -0.735387 2.19356 2.20616C-0.731187 5.14771 -0.731187 9.93452 2.19356 12.8761L7.1419 17.8505C7.24072 17.9507 7.37078 18 7.5 18C7.62922 18 7.75928 17.9507 7.8581 17.8505L12.8064 12.8761C15.7312 9.93452 15.7312 5.14771 12.8064 2.20616Z" fill="#626262"/>
</svg>''';
