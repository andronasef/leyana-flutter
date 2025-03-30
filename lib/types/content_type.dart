enum ContentType {
  verse,
  godName,
  blessing; // For future use

  String get label {
    switch (this) {
      case ContentType.verse:
        return "آيات";
      case ContentType.godName:
        return "أسماء الله";
      case ContentType.blessing:
        return "بركات روحية";
    }
  }
}
