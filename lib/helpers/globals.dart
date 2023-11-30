import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();

late SupabaseClient supabaseAuth;

String key =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zcnBybHlncWFxZ2xqcGZnZ2poIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxNzU2MjUsImV4cCI6MjAxNTc1MTYyNX0.JQUJ2i2mZlygBys5Gd5elAL_00TM_U2vJrXlIVuOtbk';

final supabase = Supabase.instance.client;