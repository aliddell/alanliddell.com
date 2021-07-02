---
title: "Notes by a neophyte in differential geometry"
date: 2021-06-30T21:24:24-04:00
draft: true
---

(Side note: I'm a neophyte in too many things.)
[Source](https://people.math.ethz.ch/~salamon/PREPRINTS/diffgeo.pdf).

The shortest path (on a surface) between two points in that surface is called a *geodesic*.
(Handwave alert: this is almost certainly not true for all types of surfaces.
Also, can we restrict this to open sets or does the term *geodesic* apply to the shortest path over the entire surface?
Also also, using "the" shortest path is fraught unless there is a guarantee of uniqueness.)

## Exercises

### 1.1.1.

It is more or less obvious that for any surface $M \subset \mathbb{R}^3$ there is a unique shortest path in $M$ connecting two points if they are sufficiently close.
This shortest path is called the *minimal geodesic* connecting $p$ and $q$.
Use this fact to prove that the minimal geodesic joining two points $p$ and $q$ in $S^2$ [the unit sphere defined by the solution set to the equation $x^2 + y^2 + z^2 = 1$, a 2D surface] is an arc of the great circle through $p$ and $q$.
(This is the intersection of the sphere with the plane through $p$, $q$, and the center of the sphere.)
Also prove that the minimal geodesic connecting two points in a plane is the straight line segment connecting them.
**Hint:** Both a great circle in a sphere and a line in a plane are preserved by a reflection.

***Proof:***

We know that any two points $p$ and $q$ are sufficient to define a line $\overleftrightarrow{pq}$, which can be said to lie on infinitely many planes (think of a single plane sweeping out a cylinder as it rotates about $\overleftrightarrow{pq}$, each slice of that cylinder describing a plane).
(To be continued...)

$\square$