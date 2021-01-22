---
title: "Binary Search Trees for Streaming Medians, Part 1"
date: 2021-01-22
tags: ["spike sorting", "data structures"]
categories: coding
---

I'm building an application for real-time [spike sorting][spike-sorting] on high-density electrode arrays.
In order to actually detect action potentials, it's necessary to determine a threshold above which the samples are considered a part of an action potential.
One approach for doing this is called the [median absolute deviation from the median][MAD], aka the *MAD*:

$$\text{MAD}(x) := \text{med}(x - \text{med}(x))$$

where $x$ is a buffer of fixed length $M$.

The idea goes, in order to determine the noise distribution from the samples, you need a measure both of central tendency and of variance.
The signal samples (here, the action potentials), though relatively rare in the samples, are so much larger in magnitude than the noise that they will throw off both, so more robust measures are needed, i.e., the median for the center and the median for the variance.
From there, one can estimate a standard deviation for the noise distribution that is not affected by spiking signals.
A multiple of this standard deviation is used as a threshold for detecting action potentials.

This method is implemented in another piece of software that I currently maintain, [JRCLUST][JRCLUST], and it works well, so I see no reason to discard it.
In JRCLUST this threshold is computed chunk-wise, i.e., the raw data, being quite large, is split into smallish chunks that can be processed on a workstation, using either CPU or GPU.
The threshold is estimated using all the data in the chunk, i.e., the buffer $x$ described above is a single channel's samples from the beginning of the chunk to the end.
This chunk size is somewhat arbitrary and depends on the capacity of the machine being used to process it.
This can lead to sharp jumps in thresholds near chunk boundary regions, whereby some spikes could be detected or not, depending on which side of the boundary they lie on.

I propose to solve this problem by uniquely determining thresholds at every sample, using the median of the data in surrounding samples.
The median, being an [order statistic][order-statistic], is not particularly conducive to streaming computation, but I intend to get around that by clever use of data structures, namely: *binary search trees*.
Specifically, I will construct a binary search tree that maintains the maximum value of its left subtree and the minimum value of its right subtree, sort of like a max-heap and a min-heap.
Whenever the left subtree has one more element than the right, that max value is the median, and when the right subtree has one more element than the left, that min value becomes the median.
When the trees are in balance, element-wise, the average of the max/min values is the median.
After the tree is populated by some number of elements, the oldest element is removed and the max/min values are updated.
This way, we can have $O(\log(n))$ insert, remove, and search operations, rather than an initial $O(n \log(n))$ sort, $O(\log n)$ searches, and $O(n)$ inserts and removes.

As you've probably guessed, this is a multi-part post.
Next time, I'll talk about the design of this data structure, and in the following post we'll get to implementation.
Stay tuned!

[JRCLUST]: https://github.com/JaneliaSciComp/JRCLUST
[MAD]: https://en.wikipedia.org/wiki/Median_absolute_deviation
[order-statistic]: https://en.wikipedia.org/wiki/Order_statistic
[spike-sorting]: http://www.scholarpedia.org/article/Spike_sorting