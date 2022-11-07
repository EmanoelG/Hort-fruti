import 'package:flutter/material.dart';
import 'package:sacolao_de_frutas/src/util/compentes/custom_textField.dart';
import 'package:sacolao_de_frutas/src/config/app_data.dart' as appdata;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: <Widget>[
          FormDefault(
            readOnly: true,
            initiValue: appdata.user.email,
            iconTitipo: Icon(Icons.email),
            isSecret: false,
            inputMenssagem: 'Usuario',
          ),
          const SizedBox(
            height: 10,
          ),
          FormDefault(
            readOnly: true,
            initiValue: appdata.user.name,
            iconTitipo: Icon(Icons.person),
            isSecret: false,
            inputMenssagem: 'Nome',
          ),
          const SizedBox(
            height: 10,
          ),
          FormDefault(
            readOnly: true,
            initiValue: appdata.user.celular,
            iconTitipo: Icon(Icons.phone),
            isSecret: false,
            inputMenssagem: 'Phone',
          ),
          const SizedBox(
            height: 10,
          ),
          FormDefault(
            readOnly: true,
            initiValue: appdata.user.cpf,
            iconTitipo: Icon(Icons.file_copy),
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
      ),
    );
  }

  Future<bool?> updatePassword() {
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
                      iconTitipo: Icon(Icons.lock),
                      isSecret: true,
                      inputMenssagem: 'Senha Atual',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormDefault(
                      iconTitipo: Icon(Icons.lock_outline),
                      isSecret: true,
                      inputMenssagem: 'Nova senha',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormDefault(
                      iconTitipo: Icon(Icons.lock_outline),
                      isSecret: true,
                      inputMenssagem: 'Confirmar senha',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'atualizar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
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
