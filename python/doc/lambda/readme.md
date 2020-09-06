# Lambda functions

## A simple 1-line function

Syntax:

```python
lambda parameters: return
```

> Do not use def or return keywoards. These are implicit.

### Examples

**Product**

```python
lambda x: 2 *x

def double(x):
  return x*2
```

**Sum**

```python
lambda x,y: x + y

def add(x,y):
  return x + y
```

**Max**

```python
max = lambda x,y: x if x > y else y

def max(x,y):
  if x > y:
    return x
  else
    return y
```

## MAP

Apply same function to each element of a sequence and return the modified list.

```
List, [m, n, p] -- >  MAP -->  New list, [f(m), f(n), f(p)]
```

Syntax:

```python
map(function, list)
```

### Examples

```python
n = [4, 3, 2, 1]
print(list(map(lambda x: x**2, n)))
```

> Note: It is not needed necessarily use a lambda function.

```python
def square(lst1):
  lst2 = []
  for num in lst1:
    lst2.append(num**2)
  return lst2

print(list(map(square, n)))
```

List comprenhesion solution:

```python
print([x**2 for x in n])
```

## FILTER

Returns a list of items that meet a specific condition.

Syntax:

```python
filter(condition, list)
```

### Examples

```python
n = [4, 3, 2, 1]
print(list(filter(lambda: x: x>2, n)))

def over_two(lst1):
  lst2 = [x for x in lst1 if x > 2]
  return lst2

print(over_two([4,3,2,1]))
```

List comprenhension solution

```python
print([x for x in n if x > 2])
```

## REDUCE

Applies same operation to items of a sequence and Use the result of operation as first param of next operation. **Returns an item, not a list**.

Syntax:.

```python
reduce(function list)
```

```python
n = [4, 3, 2, 1]
print(reduce(lambda x,y: x*y, n))

def mult(lst1):
  prod = list1[0]
  for i in range(1,len(lst1)):
    prod *=  lst1[i]
  return prod

print(mult([4,3,2,1]))

# Sequence
# 4 * 3 = 12
# 12 * 2 = 24
# 24* 1 = 24

# result = 24
````
