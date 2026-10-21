
int[] arr = {64, 25, 12, 22, 11, 90};

void setup() {
  println("Selection Sort");
  println("정렬 전:");
  printArray(arr);

  selectionSort(arr);

  println("정렬 후:");
  printArray(arr);
  exit();
}

void selectionSort(int[] a) {
  for (int i = 0; i < a.length - 1; i++) {
    int maxIndex = i;

    for (int j = i + 1; j < a.length; j++) {
      if (a[j] > a[maxIndex]) {
        maxIndex = j;
      }
    }

    int temp = a[i];
    a[i] = a[maxIndex];
    a[maxIndex] = temp;
  }
}
