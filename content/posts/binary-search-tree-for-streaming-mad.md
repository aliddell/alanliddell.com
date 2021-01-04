---
title: "Binary Search Tree for a Streaming MAD"
date: 2020-12-29T11:12:25-05:00
draft: true
---

Given a stream of integers, I'd like to compute the [median absolute deviation from the median][MAD] (aka the *MAD*) given by this formula:

$$\text{MAD}(x) := \text{med}(x - \text{med}(x))$$

where $x$ is a buffer of fixed length $M$ representing the integer stream.
Let's let $y = \text{MAD}(x)$, so that $y_i = \text{MAD}(x_i)$.

This isn't quite right. I want 
$y_{i} = \text{MAD}( \hat{x}^{(i)})$, where 

$$\hat{x}^{(i)} = \(x_{i - M / 2}, x_{i - N + 1}, \ldots, x_i, x_{i + 1}, \ldots, x_{i + M / 2 - 1} \)^\intercal$$

It should be understood that $x_k = 0$ for $k \not \in \\{1, \ldots, M \\}$.

First we need a streaming median.

We implement streaming median by means of a self-balancing binary search tree.
There's a cheaper implementation using min-max heaps, but since we need memory, we have to go with the BST.

The tree should be initialized with the first two values in the sequence, namely $x_1$ and $x_2$.
The root node will get the mean of these two values.
Inserting a new value into the tree will put it either into the left subtree or the right subtree, depending on whether it is larger or smaller than the value in the root node.

The left subtree keeps a record of its largest element and the right subtree keeps a record of its smallest element.
The trees should be self-balancing, which will incur some additional overhead, but hopefully the performance hit isn't too bad.

Let's go over some scenarios.

## Both subtrees are evenly matched

If both subtrees have the same number of elements, then the median value (the root node) is the mean of the left tree's maximum and the right tree's minimum.

Suppose we want to insert a value.
If that value is less than or equal to (or greater than) the value in the root node, we insert it into the left (respectively right) subtree.
The maximum value of the left subtree (respectively minimum value of the right subtree) becomes the new median.

If instead we want to remove a value, we can perform a binary search on the tree and remove the node containing it, rearranging that node's subtree into the rest of the tree.
After this operation, either the left subtree or the right subtree will be smaller, having lost a node.
The root node now receives the reserved value of the larger subtree: maximum if the left subtree is larger, minimum if the right subtree is larger.

## One tree is larger than the other

Without loss of generality, let's say the left subtree is the larger of the two.
Under the procedures we're about to lay out, it won't have any more than one more element than the right subtree.
In this case, the root (median) node will contain the maximum value of the left subtree.

Say the left subtree has $n$ elements and the right subtree has $n - 1$.

Let's insert an element.
If that element is larger than the median, all is well.
The value is inserted into the right subtree and the subtrees are evenly matched again: both trees had $n$ elements.
But if the element is less than or equal to the median, we will end up with $n + 1$ elements in the left subtree and $n - 1$ in the right subtree, which is unacceptable.
In this case, we can insert the new element into the left subtree (so now it has $n + 1$ elements), then remove the largest element from the left subtree (now it will have $n$ elements) and move it to the right subtree (which will now also have $n$ elements).

Removing an element from the right (smaller) subtree should be pretty straightforward as well.
Once that element is removed (the right subtree has $n - 2$ elements), we again remove the largest element from the left subtree (which now has $n - 1$ elements) to the right subtree (which now has $n - 1$ elements again).

Either way, the trees are evenly matched.

```cpp
class BST {

};
```

[MAD]: https://en.wikipedia.org/wiki/Median_absolute_deviation