# Multiproccesing

## Introduction

Multiprocessing is used to parallelize tasks using the creation of several processes to which these tasks are assigned.

```python
import time
import multiprocessing

# Multiprocessing program

def calc_square(numbers):
  for n in numbers:
    time.sleep(0.2)
    print('square ', str(n*n))

def calc_cube(numbers):
  for n in numbers:
    time.sleep(0.2)
    print('cube ', str(n*n*n))

if __name__ == '__main__':
  arr = [2,3,8,9]

  # Create new processes biding them to tasks
  p1 = multiprocessing.Process(target=calc_square, args=(arr,))
  p2 = multiprocessing.Process(target=calc_cube, args=(arr,))

  # Start processes execution
  p1.start()
  p2.start()

  # Wait for thread tasks to finish
  p1.join()
  p2.join()

  print('Done!')
```

```
square  4
cube  8
square  9
cube  27
square  64
cube  512
square  81
cube  729
Done!
```

**Every process has its own address space (virtual memory)**. Thus program variables are not shared between to
processes. You need to use interprocess communitcation (IPC) techniques if you want to share data between two processes.



```python
import time
import multiprocessing

# Multiprocessing shared vars example

square_result = []

def calc_square(numbers):
  global square_result

  for n in numbers:
    time.sleep(0.2)
    print('square ', str(n*n))
    square_result.append(n*n)

  print('within a process: result ' + str(square_result))

if __name__ == '__main__':
  arr = [2,3,8,9]

  # Create new processes biding them to tasks
  p1 = multiprocessing.Process(target=calc_square, args=(arr,))

  # Start processes execution
  p1.start()

  # Wait for thread tasks to finish
  p1.join()

  print('result ' + str(square_result))
  print('Done!')
```

```
square  4
square  9
square  64
square  81
within a process: result [4, 9, 64, 81]
result []
Done!
```

So you can see that within a process it has the result and out of the proccess it does not have the result. This is
the key difference between `multiprocessing` and `multithreading`.

## Share data between processes

<p align="center">
<img src="https://raw.githubusercontent.com/jmv74211/tools/master/images/repository/tools/python/multiprocessing/processes_space_address.png" width="65%">
</p>

### How to share data between processes using Array and Value

```python
import multiprocessing

# Multiprocessing how to share data between processes using Array and Value

def calc_square(numbers, result, v):
  v.value = 5.67
  for idx, n in enumerate(numbers):
    result[idx] = n*n

  print('Inside process: result {}'.format(result[:]))

if __name__ == '__main__':
  numbers = [2,3,5]
  result = multiprocessing.Array('i',3) # int array with size 3
  v = multiprocessing.Value('d', 0.0) # Share variable value

  # Create new processes biding them to tasks
  p1 = multiprocessing.Process(target=calc_square, args=(numbers,result,v))

  # Start processes execution
  p1.start()

  # Wait for thread tasks to finish
  p1.join()

  print('Outside process: result {}'.format(result[:]))
  print('Outside process: value {}'.format(v.value))
  print('Done!')
```

```
Inside process: result [4, 9, 25]
Outside process: result [4, 9, 25]
Outside process: value 5.67
Done!
```

### How to share data between processes using Queue

It should be made clear that multiprocessing Queue is not the same as Queue, here are the differences:

**Multiprocessing Queue**

```python3
import multiprocessing
q = multiprocessing.Queue()
```

- Lives in shared memory
- Used to share data between processes

**Queue module**

```python3
import queue
q = queue.Queue()
```

- Lives in in-process memory
- Used to share data between threads

# Locks

Lock is a very important concept when you are talking about `multiprocessing` or `multithreading`.

<p align="center">
<img src="https://raw.githubusercontent.com/jmv74211/tools/master/images/repository/tools/python/multiprocessing/processes_shared_resource.png" width="65%">
</p>

Whenever two processes or threads are trying to access a shared resource such as a memory, shared memory file or a
database it can create a problem so you need to protect that access with a `lock`.

What happens if you don't add that protection?. I'm going to show that by running this goal so this program is a
banking software program.

Here I have two processes you can see them here the first process is depositing money into a bank and the second
process is withdrawing money from the bank and in the end I am printing the final balance okay so I'm starting with a
two hundred dollar balance.

```python
import multiprocessing
import time

# Multiprocessing manipuling shared data without a lock

def deposit(balance):
  for i in range(100):
    time.sleep(0.01)
    balance.value = balance.value + 1

def withdraw(balance):
  for i in range(100):
    time.sleep(0.01)
    balance.value = balance.value - 1

if __name__ == '__main__':
  balance = multiprocessing.Value('i',200)
  d = multiprocessing.Process(target=deposit, args=(balance,))
  w = multiprocessing.Process(target=withdraw, args=(balance,))
  d.start()
  w.start()
  d.join()
  w.join()
  print(balance.value)
```

If we run this code several times, we get different results:

```
204
198
202
212
```

To solve this problem, we must protect the so-called critical area.

```python
import multiprocessing
import time

# Multiprocessing protecting shared data with a lock

def deposit(balance, lock):
  for i in range(100):
    time.sleep(0.01)
    lock.acquire()
    balance.value = balance.value + 1
    lock.release()

def withdraw(balance, lock):
  for i in range(100):
    time.sleep(0.01)
    lock.acquire()
    balance.value = balance.value - 1
    lock.release()

if __name__ == '__main__':
  balance = multiprocessing.Value('i',200)
  lock = multiprocessing.Lock()

  p1 = multiprocessing.Process(target=deposit, args=(balance,lock))
  p2 = multiprocessing.Process(target=withdraw, args=(balance,lock))

  p1.start()
  p2.start()

  p1.join()
  p2.join()

  print(balance.value)
```

If we run this code, we can see that now the result is the same in all executions:

```
200
200
200
200
```

# Multiprocessing pool (map reduce)

When you execute a program, your OS is gonna select one of the CPU cores, and this core will execute the entire
program. The problem is that you have more cores idle to execute that code.

<p align="center">
<img src="https://raw.githubusercontent.com/jmv74211/tools/master/images/repository/tools/python/multiprocessing/processes_map_reduce_1.png" width="65%">
</p>

If you can somehow parallelize your work code and divide it, you could do the following

<p align="center">
<img src="https://raw.githubusercontent.com/jmv74211/tools/master/images/repository/tools/python/multiprocessing/processes_map_reduce_2.png" width="65%">
</p>

The difference between this approach and the preovius approaches, is that here you have to do some division of work
and then aggregation, using all the processing power.

Fist, it is needed to divide the numbers of inputs between multiple cores. This process is called **map**. The process
of combining the results of each of these divisions is called **reduce**.

```python
import multiprocessing
import time

# Multiprocessing program to use map reduce paradigm

def f(n):
  sum = 0
  for x in range(1000):
    sum += x*x
  return sum

if __name__ == '__main__':

  t1 = time.time()
  p = multiprocessing.Pool() # You can use processes parameter to specify the number of CPU cores.
  result = p.map(f,range(100000)) # Divide the work between all CPU cores
  p.close()
  p.join()

  print("Pool took: ", time.time()-t1)

  t2 = time.time()
  result = []
  for x in range(100000):
    result.append(f(x))

  print("Sequential processing took: ", time.time()-t2)
```

## References

- codebasics, Python Tutorial - 27. Multiprocessing Introduction, available in
  https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=29

- codebasics, Python Tutorial - 28. Sharing Data Between Processes Using Array and Value, available in
  https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=30

- codebasics, Python Tutorial - 29. Sharing Data Between Processes Using Queue, available in
  https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=31

- codebasics, Python Tutorial - 30. Multiprocessing Lock, available in
  https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=32

- codebasics, Python Tutorial - 31. Multiprocessing Pool (Map Reduce), available in
  https://www.youtube.com/watch?v=PJ4t2U15ACo&list=PLeo1K3hjS3usILfyvQlvUBokXkHPSve6S&index=33
