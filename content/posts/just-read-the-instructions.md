---
title: "Just Read the Instructions"
date: 2021-01-04T16:24:45-05:00
categories: hugo
---

Visitors to this site might have noticed a lengthy but obviously incomplete post called "Binary Search Tree for a Streaming MAD".
This is embarassing enough to write a post about.

When using Hugo, if you don't want your drafts published, don't pass the `-D` flag.
(And don't forget to `rm -r` the public/ directory first.)
The bigger lesson here is: if you're gonna cargo-cult commands, watch out for side effects.

For those of you who didn't see it, my next (first?) post is going to be about using binary search trees to quickly compute streaming medians.
I want to do this to be able to automatically compute robust thresholds (and therefore threshold crossings) in a noisy 1D signal, and to update those thresholds as the (noise distribution of the) data changes.
Exciting stuff!
But the post isn't ready yet because I'm working on implementation, so I'm taking it back for now.
