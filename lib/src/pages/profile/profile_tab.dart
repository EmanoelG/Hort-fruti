import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacolao_de_frutas/src/pages/auth/controller/auth_controller.dart';
import 'package:sacolao_de_frutas/src/util/compentes/custom_textField.dart';
import 'package:sacolao_de_frutas/src/util/push_function.dart';
import '../../service/validators.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String senhaAtualController = '';
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          logout_user(),
        ],
      ),
      body: profile_info(),
    );
  }

  topProfilePicAndName(width, height) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
              "https://avatars.githubusercontent.com/u/91388754?v=4"),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              authController.userModel.name.toString().substring(0, 15),
              maxLines: 1,
            ),
            const Text(
              "Flutter Developer",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit_outlined,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  profile_info() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FadeAnimation(
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            topProfilePicAndName(width, height),
            _infoProfile(),
          ],
        ),
      ),
    );
  }

  _infoProfile() {
    return Column(
      //  padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      children: <Widget>[
        FormDefault(
          validatorValue: (email) {
            if (email == null) return 'Preencha e-mail ou senha corretamente !';
            return null;
          },
          readOnly: true,
          initiValue: authController.userModel.email,
          iconTitipo: const Icon(Icons.email),
          isSecret: false,
          inputMenssagem: 'Usuario',
        ),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
          validatorValue: (email) {
            if (email == null) return 'Preencha e-mail ou senha corretamente !';
            return null;
          },
          readOnly: true,
          initiValue: authController.userModel.name,
          iconTitipo: const Icon(Icons.person),
          isSecret: false,
          inputMenssagem: 'Nome',
        ),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
          validatorValue: (email) {
            if (email == null) return 'Preencha e-mail ou senha corretamente !';
            return null;
          },
          readOnly: true,
          initiValue: authController.userModel.celular,
          iconTitipo: const Icon(Icons.phone),
          isSecret: false,
          inputMenssagem: 'Phone',
        ),
        const SizedBox(
          height: 10,
        ),
        FormDefault(
          validatorValue: (email) {
            if (email == null) return 'Preencha e-mail ou senha corretamente !';
            return null;
          },
          readOnly: true,
          initiValue: authController.userModel.cpf,
          iconTitipo: const Icon(Icons.file_copy),
          isSecret: true,
          inputMenssagem: 'CPF',
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              side: const BorderSide(
                color: Colors.green,
              ),
            ),
            onPressed: () {
              updatePassword();
            },
            child: const Text(
              'Atualizar senha ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  logout_user() {
    AuthController auth = AuthController();
    return IconButton(
      onPressed: () async {
        auth.signOut();
        // Get.offNamed(PagesRoutes.singInRoute);
      },
      icon: const Icon(Icons.logout),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordControlller = TextEditingController();
    final passwordNow = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Atualizaçao de senha',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormDefault(
                        keyboardType: TextInputType.text,
                        readOnly: false,
                        type: TextInputType.none,
                        controller: passwordNow,
                        iconTitipo: const Icon(Icons.email),
                        inputMenssagem: 'Senha Atual',
                        isSecret: true,
                        validatorValue: passwordValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormDefault(
                        readOnly: false,
                        keyboardType: TextInputType.text,
                        type: TextInputType.text,
                        validatorValue: passwordValidator,
                        iconTitipo: const Icon(Icons.lock_outline),
                        controller: newPasswordControlller,
                        isSecret: true,
                        inputMenssagem: 'Nova senha',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormDefault(
                        readOnly: false,
                        keyboardType: TextInputType.text,
                        type: TextInputType.text,
                        iconTitipo: const Icon(Icons.lock_outline),
                        isSecret: true,
                        inputMenssagem: 'Confirmar nova senha',
                        validatorValue: (newPassword) {
                          final result = passwordValidator(newPassword);
                          if (result != null) {
                            return result;
                          }
                          if (newPassword == newPasswordControlller.text) {
                            return null;
                          } else {
                            return 'As senhas não são equivalentes ';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        child: Obx(() => ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        authController.changePassword(
                                          senhaAtual: passwordNow.text,
                                          novaSenha:
                                              newPasswordControlller.text,
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'atualizar',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: (() {
                    pop(context);
                  }),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
