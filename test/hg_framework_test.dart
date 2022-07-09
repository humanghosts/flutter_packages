void main() {
  try {
    print(1);
    return;
    print(3);
  } catch (e) {
    print(2);
  } finally {
    print("123");
  }
}
