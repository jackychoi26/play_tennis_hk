import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/components/custom_text.dart';
import 'package:play_tennis_hk/components/custom_text_form_field.dart';
import 'package:play_tennis_hk/core/error_resolver.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/user_profile_provider.dart';
import 'package:play_tennis_hk/features/profile/ui/profile_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  var usernameController = TextEditingController(
    text: "Hemingway",
  );
  var passwordController = TextEditingController(
    text: "Test0000",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppLocalizations.of(context)?.loginAccount,
          textType: CustomTextType.subtitle,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              controller: usernameController,
              textInputType: TextInputType.name,
              labelText: AppLocalizations.of(context)?.username,
            ),
            CustomTextFormField(
              controller: passwordController,
              textInputType: TextInputType.visiblePassword,
              isPassword: true,
              labelText: AppLocalizations.of(context)?.password,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextButton(
                    child: CustomText(AppLocalizations.of(context)?.register),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(userProfileProvider.notifier)
                      .login(usernameController.text, passwordController.text);

                  if (context.mounted) Navigator.of(context).pop();
                } catch (e) {
                  if (context.mounted) {
                    ErrorResolver().resolveError(e, context);
                  }
                }
              },
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 80,
                  ),
                ),
              ),
              child: CustomText(AppLocalizations.of(context)?.login),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
