
int n = 8;
int xstep = 400;
int ystep = 50;
int radius = 30;
int traversal = 0;
int textcolor = 0;

PFont font;
BTree tree = new BTree();

boolean searchMode = false;
String searchInput = "";

void setup() {
  size(1200, 600);

  font = createFont("Arial", 16);
  textFont(font, 16);
  textAlign(CENTER, CENTER);
  stroke(192, 0, 0);

  newTree();
}

void draw() {
}

void mousePressed() {
  if (searchMode) return;

  if (mouseButton == LEFT) {
    if (tree.value == -1) {
      int x = (int)(100.0 * mouseX / width);

      if (tree.insert(x)) {
        println("Insert: " + x);
      } else {
        println("Duplicate value: " + x);
      }
    } else {
      int deletedValue = tree.value;
      tree.remove(deletedValue);
      println("Delete: " + deletedValue);
    }

    drawTree();
  }
}

void mouseMoved() {
  tree.findNode();

  if (tree.value != -1) {
    drawTree();

    fill(92);
    ellipse(tree.x, tree.y, radius, radius);

    fill(0);
    text(tree.value, tree.x, tree.y);
  } else {
    drawTree();
  }
}

void keyPressed() {
  // Search mode: type a number and press Enter
  if (searchMode) {
    if (key == ENTER || key == RETURN) {
      if (searchInput.length() > 0) {
        int target = int(searchInput);

        if (tree.contains(target)) {
          println("Search " + target + ": Found");
        } else {
          println("Search " + target + ": Not found");
        }
      }

      searchMode = false;
      searchInput = "";
      drawTree();
      return;
    }

    if (key == BACKSPACE) {
      if (searchInput.length() > 0) {
        searchInput = searchInput.substring(
          0, searchInput.length() - 1
        );
      }
    } else if (key >= '0' && key <= '9') {
      if (searchInput.length() < 3) {
        searchInput += key;
      }
    }

    drawTree();
    return;
  }

  if (key == 'c' || key == 'C') {
    tree.clear();
    drawTree();
    println("Tree cleared");
  }
  else if (key == 'v' || key == 'V' || key == ' ') {
    drawTree();
    tree.printTree();
  }
  else if (key == 'b' || key == 'B') {
    newTree();
  }
  else if (key == 't' || key == 'T') {
    traversal++;
    if (traversal == 3) traversal = 0;

    drawTree();
    println("Traversal mode changed");
  }
  else if (key == 'd' || key == 'D') {
    textcolor = 1 - textcolor;
    drawTree();
  }
  else if (key == 's' || key == 'S') {
    searchMode = true;
    searchInput = "";
    drawTree();
  }
}

void newTree() {
  tree.clear();

  for (int i = 0; i < n; i++) {
    int value = (int)random(99);

    while (!tree.insert(value)) {
      value = (int)random(99);
    }
  }

  drawTree();
}

void drawMode() {
  textFont(font, 16);
  textAlign(LEFT, CENTER);
  noStroke();

  fill(200);
  rect(0, height - 65, width, 65);

  fill(0);

  String modeName = "";

  if (traversal == 0) modeName = "Inorder";
  else if (traversal == 1) modeName = "Preorder";
  else modeName = "Postorder";

  text("Traversal: " + modeName + " (T)", 15, height - 48);
  text("Search: S, type number, Enter", 280, height - 48);
  text("Insert: click empty area | Delete: click node", 15, height - 25);
  text("New tree: B | Clear: C | Print: V | Text color: D",
    530, height - 25);

  if (searchMode) {
    fill(255, 255, 150);
    rect(850, 15, 320, 40);

    fill(0);
    text("Search number: " + searchInput, 865, 35);
  }

  stroke(192, 0, 0);
  textAlign(CENTER, CENTER);
}

void drawTree() {
  background(200);
  tree.assignPosition();
  tree.drawTree();
  drawMode();
}

class BTree {
  Node root;
  int x, y, value, index;

  void clear() {
    root = null;
    x = y = value = -1;
  }

  boolean isEmpty() {
    return root == null;
  }

  boolean contains(int in) {
    return contains(in, root);
  }

  boolean contains(int in, Node curr) {
    if (curr == null) return false;

    if (in < curr.val) {
      return contains(in, curr.left);
    } else if (in > curr.val) {
      return contains(in, curr.right);
    }

    return true;
  }

  int findMax() {
    if (isEmpty()) {
      println("The tree is empty");
      return 0;
    }

    return findMax(root).val;
  }

  Node findMax(Node curr) {
    if (curr == null || curr.right == null) {
      return curr;
    }

    return findMax(curr.right);
  }

  int findMin() {
    if (isEmpty()) {
      println("The tree is empty");
      return 0;
    }

    return findMin(root).val;
  }

  Node findMin(Node curr) {
    if (curr == null || curr.left == null) {
      return curr;
    }

    return findMin(curr.left);
  }

  int treeHeight() {
    return treeHeight(root);
  }

  int treeHeight(Node curr) {
    if (curr == null) return -1;

    return 1 + max(
      treeHeight(curr.left),
      treeHeight(curr.right)
    );
  }

  boolean insert(int in) {
    if (contains(in)) return false;

    root = insertNode(in, root);
    return true;
  }

  Node insertNode(int in, Node curr) {
    if (curr == null) {
      return new Node(in);
    }

    if (in < curr.val) {
      curr.left = insertNode(in, curr.left);
    } else if (in > curr.val) {
      curr.right = insertNode(in, curr.right);
    }

    return curr;
  }

  void remove(int in) {
    root = removeNode(in, root);
  }

  Node removeNode(int in, Node curr) {
    if (curr == null) return null;

    if (in < curr.val) {
      curr.left = removeNode(in, curr.left);
    } else if (in > curr.val) {
      curr.right = removeNode(in, curr.right);
    } else {
      // No child or one child
      if (curr.left == null) return curr.right;
      if (curr.right == null) return curr.left;

      // Two children: use the smallest value on the right
      curr.val = findMin(curr.right).val;
      curr.right = removeNode(curr.val, curr.right);
    }

    return curr;
  }

  void assignPosition() {
    if (!isEmpty()) {
      assignPosition(root, 0, 0);
    }
  }

  void assignPosition(Node curr, float dx, float dy) {
    if (curr == null) return;

    assignPosition(
      curr.left, dx - 1.0 / pow(2.0, dy + 1), dy + 1
    );

    curr.x = dx;
    curr.y = dy;

    assignPosition(
      curr.right, dx + 1.0 / pow(2.0, dy + 1), dy + 1
    );
  }

  void printTree() {
    index = 0;

    if (isEmpty()) {
      println("The tree is empty");
      return;
    }

    println("----- " + getTraversalName() + " -----");
    printTree(root);
    println("------------------------");
  }

  String getTraversalName() {
    if (traversal == 0) return "Inorder";
    if (traversal == 1) return "Preorder";
    return "Postorder";
  }

  void printTree(Node curr) {
    if (curr == null) return;

    if (traversal == 0) {
      // Inorder: Left, Root, Right
      printTree(curr.left);
      printNodeIndex(curr);
      printTree(curr.right);
    }
    else if (traversal == 1) {
      // Preorder: Root, Left, Right
      printNodeIndex(curr);
      printTree(curr.left);
      printTree(curr.right);
    }
    else {
      // Postorder: Left, Right, Root
      printTree(curr.left);
      printTree(curr.right);
      printNodeIndex(curr);
    }
  }

  void printNodeIndex(Node curr) {
    println(curr.val + " index=" + index);
    fill(0, 0, 255);

    text(
      index,
      (int)(curr.x * xstep + width / 2 - radius / 2 - 2),
      (int)(curr.y * ystep + radius - radius / 2 - 2)
    );

    index++;
  }

  void findNode() {
    x = y = value = -1;

    if (!isEmpty()) {
      findNode(root);
    }
  }

  void findNode(Node curr) {
    if (curr == null || value != -1) return;

    findNode(curr.left);

    if (value != -1) return;

    int nodeX = (int)(curr.x * xstep + width / 2);
    int nodeY = (int)(curr.y * ystep + radius);

    int dx = mouseX - nodeX;
    int dy = mouseY - nodeY;

    if (dx * dx + dy * dy < radius * radius / 4) {
      x = nodeX;
      y = nodeY;
      value = curr.val;
      return;
    }

    findNode(curr.right);
  }

  void drawTree() {
    if (isEmpty()) return;

    drawTreeLine(root);
    drawTree(root);
  }

  void drawTreeLine(Node curr) {
    if (curr == null) return;

    if (curr.left != null) {
      line(
        (int)(curr.x * xstep + width / 2),
        (int)(curr.y * ystep + radius),
        (int)(curr.left.x * xstep + width / 2),
        (int)(curr.left.y * ystep + radius)
      );
    }

    if (curr.right != null) {
      line(
        (int)(curr.x * xstep + width / 2),
        (int)(curr.y * ystep + radius),
        (int)(curr.right.x * xstep + width / 2),
        (int)(curr.right.y * ystep + radius)
      );
    }

    drawTreeLine(curr.left);
    drawTreeLine(curr.right);
  }

  void drawTree(Node curr) {
    if (curr == null) return;

    drawTree(curr.left);

    fill(255);
    ellipse(
      curr.x * xstep + width / 2,
      curr.y * ystep + radius,
      radius, radius
    );

    if (textcolor == 0) fill(0);
    else fill(255);

    text(
      curr.val,
      (int)(curr.x * xstep + width / 2),
      (int)(curr.y * ystep + radius)
    );

    drawTree(curr.right);
  }
}

class Node {
  int val;
  float x, y;
  Node left;
  Node right;

  Node(int v) {
    val = v;
  }

  Node(int v, Node l, Node r) {
    val = v;
    left = l;
    right = r;
  }

  public String toString() {
    if (left == null && right == null) {
      return "N(" + val + ")";
    }

    return "N(" + val + ", " + left + ", " + right + ")";
  }
}
