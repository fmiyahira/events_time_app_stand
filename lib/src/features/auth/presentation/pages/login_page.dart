import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_microapp_ds/events_time_microapp_ds.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _doLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      SelectConfigurationPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DSColors.neutral.s100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kLayoutSpacerS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DSText(
                'Bem-vindo!',
                type: DSTextType.HEADING2,
              ),
              const SizedBox(height: kLayoutSpacerM),
              const DSTextField(
                labelText: 'Usuário',
                suffixIcon: Icon(Icons.person_pin_rounded),
              ),
              const SizedBox(height: kLayoutSpacerXS),
              const DSTextField(
                labelText: 'Senha',
                type: DSTextFieldType.PASSWORD,
              ),
              const SizedBox(height: kLayoutSpacerS),
              DSButton(
                size: DSButtonSize.SMALL,
                text: 'Acessar',
                buttonStyle: DSButtonStyle.PRIMARY,
                onPressed: _doLogin,
              ),
              DSLinkButton(
                size: DSLinkButtonSize.SMALL,
                text: 'Não possui cadastro?',
                textType: DSInteractiveTextType.ACTION_SMALL,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
