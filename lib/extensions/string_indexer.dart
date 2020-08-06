extension StringIndexer on String {
  String get(int index) {
    return this.substring(index, index+1);
  }

  String first(){
    return this.get(0);
  }

  String last() {
    return this.get(this.length-1);
  }
}
