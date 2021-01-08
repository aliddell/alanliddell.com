---
title: "Environment Variables in CLion"
date: 2021-01-07
categories: coding
tags: ["Stack Overflow", "tools"]
---

The following is a Stack Overflow [question][question] I asked (and answer I subsequently gave).
I thought it was a well-researched and potentially useful, if somewhat niche, Q&A pair.
If nothing else, IMO it's a model Stack Overflow question and I want to signal-boost it.

(If you're not in the know, [JetBrains CLion][clion] is a great cross-platform C/C++ IDE.)

# The Question

I want to be able to source one or more environment variables from a file within a particular run/debug configuration in JetBrains CLion.
As far as I'm aware and as of this writing, this particular question [has not been answered on Stack Overflow](https://stackoverflow.com/search?q=source+environment+variables+from+file+%5Bclion%5D). I think it should be useful for users of other JetBrains IDEs.

Coming from a mostly Python background, I've made a lot of use of the Python [dotenv](https://pypi.org/project/python-dotenv/) library to define several environment variables in a file.
The syntax in these files looks like

```
VARIABLE_NAME=value
```

This looks similar to how I'd define (local) variables in a shell script.

Other languages that I've worked with in the past have modules (e.g., [Julia](https://github.com/vmari/DotEnv.jl), [Node](https://www.npmjs.com/package/dotenv)) or built-in functionality (e.g., [R](https://stat.ethz.ch/R-manual/R-devel/library/base/html/readRenviron.html)) that all follow this `VARIABLE=value` syntax.
I would expect that sourcing environment variables from a file in an IDE should have a similar feel.

Either CLion does not and I just don't know it, or I've stumbled onto a misconfiguration (more likely) or a bug (less likely).

## What this question is not

I'm not trying to [set CMake variables](https://stackoverflow.com/questions/37662130/clion-or-cmake-does-not-see-environment-variable/38874446#38874446). I want to set environment variables to be visible to my program through `std::getenv`.

An [answer on a related question](https://stackoverflow.com/a/48996134/993881) recommends [a plugin](https://plugins.jetbrains.com/plugin/7861-envfile) which is not compatible with CLion. Moreover, support for sourced environment files in a run/debug configuration is already [built in](hhttps://www.jetbrains.com/help/clion/2020.3/run-debug-configuration.html#add-environment-variables) to CLion, so a plugin shouldn't be necessary.

## What I tried

### Minimal working example

Here is a simple C++ program which prints out an environment variable:

```c++
#include <iostream>

int main() {
    auto test_val = getenv("TEST");
    std::cout << "TEST value: " << test_val << std::endl;
}
```

and here are the contents of `/home/alan/Documents/20201222-clion-env-file-test/env`:

```
TEST=hello
```

(I've tried with and without a newline, but it doesn't make any difference.)

### Broken run/debug configuration

Attempting to source an environment variable from this file appears not to work:

[![CLion run/debug configuration (not working)][1]][1]

#### Expected output

```
/home/alan/Documents/20201222-clion-env-file-test/cmake-build-debug/20201222_clion_env_file_test
TEST value: hello

Process finished with exit code 0
```

#### Actual output

```
/home/alan/Documents/20201222-clion-env-file-test/cmake-build-debug/20201222_clion_env_file_test
TEST value: 
Process finished with exit code 0
```

### Working run/debug configuration

Explicitly defining the variable works:

[![CLion run/debug configuration (working)][2]][2]

#### Expected output

```
/home/alan/Documents/20201222-clion-env-file-test/cmake-build-debug/20201222_clion_env_file_test
TEST value: hi

Process finished with exit code 0
```

#### Actual output

```
/home/alan/Documents/20201222-clion-env-file-test/cmake-build-debug/20201222_clion_env_file_test
TEST value: hi

Process finished with exit code 0
```

## tl;dr

Why is CLion not picking up my environment variables if I set them from a file?

## System info

```
CLion 2020.3
Build #CL-203.5981.166, built on December 1, 2020
...
Runtime version: 11.0.9+11-b1145.21 amd64
VM: OpenJDK 64-Bit Server VM by JetBrains s.r.o.
Linux 5.8.0-7630-generic
```

# The Answer

CLion does not follow the expected syntax, but the [documentation](https://www.jetbrains.com/help/clion/2020.3/run-debug-configuration.html#add-environment-variables) is not explicit about that:

> Use the **Load variables from file** field to point CLion to a script that configures the environment.

The clue is the word *script*. If you want the environment variable to be available outside the script, you need to `export` it, same as you would in the shell:

```console
alan@just-testing:~/Documents/20201222-clion-env-file-test$ cat ./env 
TEST=hello
alan@just-testing:~/Documents/20201222-clion-env-file-test$ source ./env && ./cmake-build-debug/20201222_clion_env_file_test 
TEST value: alan@just-testing:~/Documents/20201222-clion-env-file-test$
```

Making the requisite changes gives the expected result:

```console
alan@just-testing:~/Documents/20201222-clion-env-file-test$ cat env 
export TEST=hello
alan@just-testing:~/Documents/20201222-clion-env-file-test$ source ./env && ./cmake-build-debug/20201222_clion_env_file_test 
TEST value: hello
```

Here is the output from CLion after making this change:

```
/home/alan/Documents/20201222-clion-env-file-test/cmake-build-debug/20201222_clion_env_file_test
TEST value: hello

Process finished with exit code 0
```

If you have any recent C/C++ experience, this is probably obvious, but if you came up on interpreted languages with the `VARIABLE=value` syntax, like I did, this is definitely not obvious.

  [1]: https://i.stack.imgur.com/zbEko.png
  [2]: https://i.stack.imgur.com/PGSf5.png

[clion]: https://www.jetbrains.com/clion/
[question]: https://stackoverflow.com/questions/65413053/am-i-incorrectly-sourcing-environment-variables-from-a-file-in-clion-or-is-env