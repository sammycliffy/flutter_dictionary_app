import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoading = StateProvider<bool>((ref) => false);
final isPlaying = StateProvider<bool>((ref) => false);
final isUrlEmpty = StateProvider<bool>((ref) => false);
final token = StateProvider<String>((ref) => "");
// final wordData = StateProvider<WordModel?>((ref) => null);