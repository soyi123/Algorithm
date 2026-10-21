
int[] arr = {64, 25, 12, 22, 11, 90};

void setup() {
  println("Bubble Sort");
  println("정렬 전:");
  printArray(arr);

  bubbleSort(arr);

  println("정렬 후:");
  printArray(arr);
  exit();
}

void bubbleSort(int[] a) {
  for (int i = 0; i < a.length - 1; i++) {
    for (int j = 0; j < a.length - i - 1; j++) {
      if (a[j] < a[j + 1]) {
        int temp = a[j];
        a[j] = a[j + 1];
        a[j + 1] = temp;
      }
    }
  }
}
