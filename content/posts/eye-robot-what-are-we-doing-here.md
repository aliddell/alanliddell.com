---
title: "Eye Robot 0: What Are We Doing Here?"
date: 2021-02-12]
categories: "robot"
tags: ["computer vision"]
---

I'm learning computer vision in support of a career pivot.

In graduate school I worked in [numerical algebraic geometry][wp-nag], which can be boiled down to a collection of numerical algorithms for solving systems of polynomial equations, together with data structures and additional algorithms for describing positive-dimensional (i.e., infinite) solution sets called *varieties*.
(Some algebraic geometers, in my experience usually pure mathematicians, use the term *algebraic set* to describe these solution sets and reserve the term *variety* for strictly irreducible algebraic sets, but, last I checked, the convention among numerical algebraic geometers is to use variety for both cases.)
But in the work that I do now, I don't really have much use for that stuff, which is really too bad because algebraic geometry is so beautiful and NAG is so useful -- polynomial systems are *everywhere*.
In fact, algebraists and algebraic geometers are [already working on computer vision][ag4cv].

Algebraic geometry, particularly numerical algebraic geometry; and making sense, computationally, of the world by means of our own primary sense; these things are both already cool enough, but I want to work with *robots*.
Why that is (beyond being just very cool) I'll save for a different post.
Now, robotics is huge.
A while back I remarked to a friend that you could staff an entire math department with faculty focused on one aspect or another of robotics (and then you'd need an entire EECS department for the rest).
So in order to reconcile personal, philosophical, or nontechnical reasons for wanting to work in robotics (remember, robots are *cool*) with a desire to become competent in such a vast domain, so competent that people pay me lots of money for my expertise, I need to specialize.
Computer vision with an application to robotics is a natural choice here (I have the mathematical background and coding chops), though even that is really too broad.

Now, before anybody lets me anywhere near any hardware, it would be good to have some idea of the challenges that one would face as a roboticist with a specialty in vision.
Hence, this project.
By the end of this year, I will build a 4-wheeled robot, from scratch, that will navigate an unknown (but not hostile; think indoors on a single hardwood floor with obstacles, animate and inanimate) environment by sight alone.
(In particular, this means depth estimation from binocular vision.)
I call it the Eye Robot (I can hear you groan but I couldn't resist).

## What all does this entail anyway

There are lots of things involved there that I don't know how to do yet, or have only done a few times, namely:

- simple CAD (I will use [OpenSCAD][openscad] because it's free and it thinks like I do) for the chassis
- 3D printing, also for the chassis
- hardware selection for the battery, wheels, and motors
- wiring
- GPIO programming on a general-purpose OS (Ubuntu on Raspberry Pi)
- streaming camera input, probably with [libcamera][libcamera]
- cross-compiling [ROS][ros] and [OpenCV][opencv] and libcamera for ARM
- depth perception from binocular vision

This is pretty vague because I'm figuring things out as I go.
This is just what I foresee; there are bound to be loads of other things I've missed.
Even with such a small project, I clearly have a lot to accomplish in the next 10.5 months.
Speaking of which:

## A timeline

Late last month I wrote [a post](/posts/11-resolutions) detailing 11 things I wanted to do for the (at the time) 11 remaining months of the year.
Many of those resolutions have to do with the Eye Robot.
Here's the order in which I see this playing out:

1. Acquire a second MIPI camera and a multi-camera adapter for my Pi.
2. Try to use the camera with the [libcamera-apps](https://www.raspberrypi.org/blog/an-open-source-camera-stack-for-raspberry-pi-using-libcamera/) on the Raspberry Pi OS.
   I won't use Raspberry Pi OS on my 4B ultimately because, as of now, they still don't have a 64-bit release whereas Ubuntu does have a 64-bit ARM build; but figuring out how to make the cameras work with libcamera on a Pi is essential.
3. Build OpenCV for and install it on the Pi.
4. Figure out how to pipe libcamera's output into OpenCV's input.
5. Start taking videos and storing them on the Pi's SD card.
6. Do crude relative depth estimation of various objects, with respect to a stationary camera pair, over time; think "closer", "farther", "closer", "too close!"
7. Design an open-air mount for the Pi and the two cameras on top of a more sturdy frame.
8. Print it!
9. Mount the wheels and motors to the frame and wire them up to the Pi.
10. Write a test program to move the frame forwards, backwards, left, right, and in a circle in a constrained space.
11. Build ROS for and install it on the Pi.
12. Write a very simple program to move towards a particular object in the machine's field of vision but stop when it gets too close.

Here's where things start to get fuzzy, but I'll leave it here.
I'll have a clearer idea of later stages as the project unfolds.

[ag4cv]: http://web.math.princeton.edu/~jkileel/thesis.pdf
[libcamera]: https://www.libcamera.org/
[opencv]: https://opencv.org/
[openscad]: https://www.openscad.org/
[ros]: https://www.ros.org/
[wp-nag]: https://en.wikipedia.org/wiki/Numerical_algebraic_geometry