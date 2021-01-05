---
title: "alanliddell.com"
date: 2021-01-05
categories: hugo
---

Yes Virginia, this site is a project!
I use the static site generator [Hugo][hugo] and Chip Zoller's excellent [Clarity][clarity] theme.
The site repository is on GitHub [here][github].

## Customizing the theme

I haven't made too many customizations to the theme just yet, though I probably will in the not-too-distant future.
The biggest thing is switching from the default KaTeX to MathJax for typesetting math like so:

$$e^{i \pi} + 1 = 0$$

After grad school I never thought I'd miss TeX, but it's good to see that beautifully rendered math again.

I've also added StackOverflow to the list of available social icons at the top right.
I made a PR of this which was accepted upstream late last year, so now you can feature your own StackOverflow profile on your website.

Finally, I think social sharing icons are somewhat irritating, so I've replaced them all with a simple permalink.
If you'd like to share posts or pages from this site that's great, but I'm not promoting a social media presence and I don't want to shove SHARE ME! icons in your face.
Do unto others, right?

## Lessons learned so far

For the pitfalls of cargo-culting Hugo commands, check out this short post [here][1].

[clarity]: https://github.com/chipzoller/hugo-clarity
[github]: https://github.com/aliddell/alanliddell.com
[hugo]: https://gohugo.io
[1]: /posts/just-read-the-instructions/
