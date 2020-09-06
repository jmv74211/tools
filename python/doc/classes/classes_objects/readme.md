# Python Classes and Objects

Python is an object oriented programming language.

Almost everything in Python is an object, with its properties and methods.

---

# Create a Class

To create a class, use the keyword `class`:

```python
class MyClass:
   x = 5
```

# Create Object

Now we can use the class named myClass to create objects:

```python
p1 = MyClass()
print(p1.x)
```
# The \_\_init_\_() function

All classes have a function called `__init__()`, which is always executed when the class is being initiated.

Use the `__init__()` function to assign values to object properties, or other operations that are necessary to do when
the object is being created:

```python
class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

p1 = Person("John", 36)

print(p1.name)
print(p1.age)
```

> Note: The __init__() function is called automatically every time the class is being used to create a new object.


# Class and Instance Variables

Generally speaking, instance variables are for data unique to each instance and class variables are for attributes and
methods shared by all instances of the class:

```python
class Dog:

   kind = 'canine'         # class variable shared by all instances

   def __init__(self, name):
   self.name = name    # instance variable unique to each instance
```
      >>> d = Dog('Fido')
      >>> e = Dog('Buddy')
      >>> d.kind                  # shared by all dogs
      'canine'
      >>> e.kind                  # shared by all dogs
      'canine'
      >>> d.name                  # unique to d
      'Fido'
      >>> e.name                  # unique to e
      'Buddy'

# Private Variables

All members in a Python class are **public by default**. Any member can be accessed from outside the class environment.

“Private” instance variables that cannot be accessed except from inside an object **don’t exist in Python**. However,
there is a convention that is followed by most Python code: a name prefixed with an underscore should be treated as a
non-public part of the API


```python
class employee:
    def __init__(self, name, sal):
        self.name=name
        self.salary=sal
```

You can access employee class's attributes and also modify their values, as shown below.

      >>> e1=Employee("Kiran",10000)
      >>> e1.salary
      10000
      >>> e1.salary=20000
      >>> e1.salary
      20000

Python's convention to make an instance variable protected is to add a prefix `_` (single underscore) to it. This
effectively prevents it to be accessed, unless it is from within a sub-class.

```python
class employee:
    def __init__(self, name, sal):
        self._name=name  # protected attribute
        self._salary=sal # protected attribute
```

You can access employee class's attributes and also modify their values, as shown below.

      >>> e1=Employee("Kiran",10000)
      >>> e1.salary
      10000
      >>> e1.salary=20000
      >>> e1.salary
      20000

**Protected variable**

Python's convention to make an instance variable protected is to add a prefix `_` (single underscore) to it. This
effectively prevents it to be accessed, unless it is from within a sub-class.

```python
class employee:
    def __init__(self, name, sal):
        self._name=name  # protected attribute
        self._salary=sal # protected attribute
```

**Private variable**

Similarly, a double underscore __ prefixed to a variable makes it private. It gives a strong suggestion not to touch it
 from outside the class. Any attempt to do so will result in an AttributeError:


```python
class employee:
    def __init__(self, name, sal):
        self.__name=name  # private attribute
        self.__salary=sal # private attribute
```
```
>>> e1=employee("Bill",10000)
>>> e1.__salary
AttributeError: 'employee' object has no attribute '__salary'
```

Python performs name mangling of private variables. Every member with double underscore will be changed
to _object._class_\_variable. If so required, it can still be accessed from outside the class, but the practice
should be refrained.

```
>>> e1=Employee("Bill",10000)
>>> e1._Employee__salary
10000
>>> e1._Employee__salary=20000
>>> e1._Employee__salary
20000
```

# Object Methods

Objects can also contain methods. Methods in objects are functions that belong to the object.

```python
class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

  def myfunc(self):
    print("Hello my name is " + self.name)

p1 = Person("John", 36)
p1.myfunc()
```
> Note: The **self** parameter is a reference to the current instance of the class, and is used to access variables
        that belong to the class.

# Modify Object Properties

You can modify properties on objects like this:

```python
p1.age = 40
```
# Delete Object Properties

You can delete properties on objects by using the del keyword:

```python
del p1.age
```

# Delete Objects

You can delete objects by using the del keyword:

```python
del p1
```

---

# References

- https://docs.python.org/3/tutorial/classes.html
- https://www.w3schools.com/python/python_classes.asp
