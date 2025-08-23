import 'package:consist/features/habit/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.grey,
              size: 40,
            ),
            Text(
                "We are facing a technical glitch at the moment & couldn't get your details",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            if (onTap != null)
              AppButton(
                title: 'Retry',
                onPressed: onTap,
              )
          ],
        ),
      ),
    );
  }
}
