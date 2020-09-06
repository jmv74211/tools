# Decorators

Imagine you have the following code:

```python
import time

def calc_square(numbers):
  start = time.time()
  result = []
  for number in numbers:
    result.append(number*number)

  end = time.time()
  print("calc_square took " + str((end - start)*1000) + " mil sec")
  return result

def calc_cube(numbers):
  start = time.time()
  result = []
  for number in numbers:
    result.append(number*number*number)

  end = time.time()
  print("calc_square took " + str((end - start)*1000) + " mil sec")
  return result

array = range(1,100000)
out_square = calc_square(array)
out_cube = calc_cube(array)
```

As you can see, the same code snippet is being used to measure the performance of each function, that is, each
function has duplicate code.

If you want to measure the performance, the second problem is that there is a function logic that is combined with the
timing logic.

**Decorators** solve the both of these issues:

- Code duplication

- Cluterring main logic of function with additional functionality

The resulting code using decorator functions is the following:

```python
import time

# Decorator function
def time_it(func):
  def wrapper(*args, **kwargs):
    start = time.time()
    result = func(*args,**kwargs)
    end = time.time()
    print(func.__name__ + " took " + str((end - start)*1000) + "mil seconds")
    return result

  return wrapper

@time_it
def calc_square(numbers):
  result = []
  for number in numbers:
    result.append(number*number)

  return result

@time_it
def calc_cube(numbers):
  result = []
  for number in numbers:
    result.append(number*number*number)

  return result

array = range(1,100000)
out_square = calc_square(array)
out_cube = calc_cube(array)
```
