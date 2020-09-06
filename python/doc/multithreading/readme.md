# Multithreading

## Introduction

Let's first understand in general what multi-threading means when comes to computer science multi-threading I often
explain by giving the example of a busy mom.

<p align="center">
<img src="https://raw.githubusercontent.com/jmv74211/tools/master/images/repository/tools/python/multithreading/threading_introduction.png" width="85%">
</p>

As you see in this picture busy mom usually juggles between multiple tasks so she might be cooking food and at the same
time she has to take care of baby and she often gets a phone call and she needs to handle that as well in parallel.

These lines are individual tasks that mom is handling and when it comes to programming they are called **threads** so
mom is handling three threads, cooking food taking care of baby and handling phone call hands. Mom is
doing `multi-threading`.

Similarly Python program can handle multiple tasks at the same time and that program is called to be
doing `multi-threading`.

We're going to work on a problem where I have an array a list of numbers and I want to calculate the square
of each of these numbers and I want to print those numbers at the same time, calculating the cube of each of these
 numbers and printing them.

**Secuential tasks**

```python
import time

def calc_square(numbers):
  print("Calculate square numbers")
  for n in numbers:
    time.sleep(0.2)
    print('square:', n*n)

def calc_cube(numbers):
  print("Calculate cube numbers")
  for n in numbers:
    time.sleep(0.2)
    print('cube:', n*n*n)

arr = [2,3,8,9]

t = time.time()
calc_square(arr)
calc_cube(arr)

print("Done in ", time.time() - t)
```

```
Calculate square numbers
square: 4
square: 9
square: 64
square: 81
Calculate cube numbers
cube: 8
cube: 27
cube: 512
cube: 729
Done in  1.602799892425537
```

Let's execute this program in parallel using multithreading

**Using threads**

```python
import time
import threading

def calc_square(numbers):
  print("Calculate square numbers")
  for n in numbers:
    time.sleep(0.2)
    print('square:', n*n)

def calc_cube(numbers):
  print("Calculate cube numbers")
  for n in numbers:
    time.sleep(0.2)
    print('cube:', n*n*n)

arr = [2,3,8,9]

t = time.time()

# Create threads and bind them to proccesses
t1 = threading.Thread(target=calc_square, args=(arr,))
t2 = threading.Thread(target=calc_cube, args=(arr,))

# Start threads execution
t1.start()
t2.start()

# Wait for thread tasks to finish
t1.join()
t2.join()

print("Done in ", time.time() - t)
```

```
Calculate square numbers
Calculate cube numbers
square: 4
cube: 8
square: 9
cube: 27
square: 64
cube: 512
square: 81
cube: 729
Done in  0.8022427558898926
```

As you can see, the execution time has been almost halved because it has been executed in parallel.

**Multi-threading** in Python is little special because there is something called a `group global interpreter lock`
that prevents you from using the true benefits of `multi-threading` but in any case **whenever you are waiting you
are doing io bound operation you can still use `multi-threading`** so go ahead and use it and **if you want to do
real CPU and sand intensive work and you're not waiting for an IO type operation then you need to use
`multi processing`**.

## References

- codebasics, Python Tutorial - 26. Multithreading - Introduction, available in https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=28
