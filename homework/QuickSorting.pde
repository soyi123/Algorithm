
int[] arr = {64, 25, 12, 22, 11, 90};

void setup() {
  println("Quick Sort");
  println("정렬 전:");
  printArray(arr);

  quickSort(arr, 0, arr.length - 1);

  println("정렬 후:");
  printArray(arr);
  exit();
}

void quickSort(int[] a, int low, int high) {
  if (low >= high) return;

  int i = low;
  int j = high;
  int pivot = a[(low + high) / 2];

  while (i <= j) {
    while (a[i] > pivot) i++;
    while (a[j] < pivot) j--;

    if (i <= j) {
      int temp = a[i];
      a[i] = a[j];
      a[j] = temp;
      i++;
      j--;
    }
  }

  if (low < j) quickSort(a, low, j);
  if (i < high) quickSort(a, i, high);
}
