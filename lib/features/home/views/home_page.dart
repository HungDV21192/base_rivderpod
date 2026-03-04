import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/features/home/application/counter_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Loading Demo")),
      body: Center(
        child: counterState.when(
          // 1. Giai đoạn DONE (Đã có dữ liệu)
          data: (count) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Giá trị hiện tại:", style: TextStyle(fontSize: 20)),
              Text("$count", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => ref.read(counterNotifierProvider.notifier).decrement(),
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

            ],
          ),

          // 2. Giai đoạn ERROR (Xảy ra lỗi)
          error: (error, stack) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              Text("Lỗi: $error"),
              ElevatedButton(
                onPressed: () => ref.invalidate(counterNotifierProvider),
                child: const Text("Thử lại"),
              )
            ],
          ),

          // 3. Giai đoạn LOADING (Đang tải)
          loading: () => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Đang tải dữ liệu..."),
            ],
          ),
        ),
      ),
    );
  }
}