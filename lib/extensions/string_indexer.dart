extension StringIndexer on String {
  String get(int index) {
    return this.substring(index, index+1);
  }
}
