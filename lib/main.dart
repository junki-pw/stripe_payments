import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51HqvK5GoVFpvGYbs1qyHhu0F8Td9pIyjGFAw1M34JyZ11rgM9vw7MOjgKnGJtYkkj0ijYKxV07G8iKgAT03LYamS001ZRn1FSq';
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _StripeTestScreen(),
    );
  }
}

class _StripeTestScreen extends StatelessWidget {
  const _StripeTestScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        child: const Text('test'),
        onPressed: () async {
          // 2. PaymentSheet を初期化
          try {
            const String customerEphemeralKeySecret =
                'ek_test_YWNjdF8xSHF2SzVHb1ZGcHZHWWJzLEVyV1dUUWRNYzhxZk5kdFk5Z3NsQTdVWUFYekRjVlM_00V4Fh6OsJ';
            const String customerId = 'cus_OZDnNjJbmYwpTB';
            const String setupIntentClientSecret =
                'seti_1Nm5MFGoVFpvGYbsAg7MXyPn_secret_OZDn5dVlkR4I0PZEQ2nlljJxzBcidMn';

            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: const SetupPaymentSheetParameters(
                // customFlow: true,
                merchantDisplayName: 'ウーオ',
                // customerEphemeralKeySecret: customerEphemeralKeySecret,
                setupIntentClientSecret: setupIntentClientSecret,
                customerId: customerId,
                // 決済フォーム入力完了直後に決済処理を実行しない場合に立てる
                // allowsDelayedPaymentMethods: true,
                primaryButtonLabel: '追加する',
                billingDetails: BillingDetails(
                  address: Address(
                    city: '',
                    country: 'JP',
                    line1: '',
                    line2: '',
                    postalCode: '',
                    state: '',
                  ),
                ),
              ),
            );

            // await Stripe.instance.initPaymentSheet(
            //   paymentSheetParameters: SetupPaymentSheetParameters(
            //     merchantDisplayName: 'Flutter Stripe Example',
            //     paymentIntentClientSecret:
            //         'pi_3Nm57FGoVFpvGYbs0Bmsa4XY_secret_nWNs9oUF3CtyXMoVMTff51gLa',
            //     customerEphemeralKeySecret:
            //         'ek_test_YWNjdF8xSHF2SzVHb1ZGcHZHWWJzLE1yUXNhakpUcXZIeWdicUkyckFaY2tQcXZ5R0REODg_00qKWKms90',
            //     customerId: 'cus_OZDYuywCVjMce2',
            //   ),
            // );

            // 3. PaymentSheet を表示
            await Stripe.instance.presentPaymentSheet();

            // // 4. 決済を確定
            // await Stripe.instance.confirmPaymentSheetPayment();
            //
            // // 5. 決済内容を取得
            // final paymentIntent = await Stripe.instance.retrievePaymentIntent(
            //     'pi_3Nm57FGoVFpvGYbs0Bmsa4XY_secret_nWNs9oUF3CtyXMoVMTff51gLa');
          } catch (e) {
            debugPrint('エラー: ${e.toString()}');
          }
        },
      ),
    );
  }
}
