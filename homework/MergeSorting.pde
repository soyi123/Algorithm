
int[] arr = {64, 25, 12, 22, 11, 90};

void setup() {
  println("Merge Sort");
  println("정렬 전:");
  printArray(arr);

  mergeSort(arr, 0, arr.length - 1);

  println("정렬 후:");
  printArray(arr);
  exit();
}

void mergeSort(int[] a, int left, int right) {
  if (left >= right) return;

  int mid = (left + right) / 2;
  mergeSort(a, left, mid);
  mergeSort(a, mid + 1, right);
  merge(a, left, mid, right);
}

void merge(int[] a, int left, int mid, int right) {
  int[] temp = new int[right - left + 1];
  int i = left;
  int j = mid + 1;
  int k = 0;

  while (i <= mid && j <= right) {
    if (a[i] >= a[j]) {
      temp[k++] = a[i++];
    } else {
      temp[k++] = a[j++];
    }
  }

  while (i <= mid) temp[k++] = a[i++];
  while (j <= right) temp[k++] = a[j++];

  for (i = 0; i < temp.length; i++) {
    a[left + i] = temp[i];
  }
}
