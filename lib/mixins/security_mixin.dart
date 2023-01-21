mixin SecurityMixin {
  bool meetsRequirement(String entered) {
    final reg = RegExp(r'(?:[\p{L},\p{P}|\p{S},\p{N}]+)+', unicode: true);
    final result = reg.firstMatch(entered);
    return (result != null && result.group(0) == entered);
  }
}
