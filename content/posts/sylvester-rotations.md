---
title: "Sylvester equations with rotation matrices"
date: 2021-06-14T21:30:14-04:00
draft: true
---

It's a well-known result that the matrix equation $AX - XB = C$ (aka the [Sylvester equation][sylvester]) as a unique solution $X^*$ if and only if $A$ and $B$ share no eigenvalues.
As it happens, I've come across a problem involving a special case of the Sylvester equation, namely $AX = XB$ (i.e., $C = 0$), with the additional constraint that $A$, $B$, and $X$ are all rotation matrices.
Since $A$ and $B$ are rotation matrices, they share at least one eigenvalue (namely, 1), and so a solution, if it exists, is not unique.
Does a unique solution exist in $SO(3)$?

(The answer is probably not and you'll have to settle for a minimizer.
I think we're looking at another permadraft...)

More to the point, what about rotations followed by translations?
Take a point $x \in \mathbb{R}^3$.
We can embed it into $\mathbb{R}^4$ by taking $\tilde{x} = (x_1, x_2, x_3, 1)$.

[sylvester]: https://nhigham.com/2020/09/01/what-is-the-sylvester-equation/