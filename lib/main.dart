import 'package:daytask/services/splash_services/splash_screen.dart'
    show SplashScreen;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFrY3ZvcmxscWNrcWh6dGZlYXdtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyNTY4NjAsImV4cCI6MjA2MDgzMjg2MH0.cwcCL89L0hVcQLGeu413mCIPel17hPruL6t8xFiGD_g',
    url: 'https://qkcvorllqckqhztfeawm.supabase.co',
  );

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}
