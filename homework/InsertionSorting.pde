
int[] arr = {64, 25, 12, 22, 11, 90};

void setup() {
  println("Insertion Sort");
  println("정렬 전:");
  printArray(arr);

  insertionSort(arr);

  println("정렬 후:");
  printArray(arr);
  exit();
}

void insertionSort(int[] a) {
  for (int i = 1; i < a.length; i++) {
    int key = a[i];
    int j = i - 1;

    while (j >= 0 && a[j] < key) {
      a[j + 1] = a[j];
      j--;
    }

    a[j + 1] = key;
  }
}
