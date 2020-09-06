# Python Inheritance

Inheritance allows us to define a class that inherits all the methods and properties from another class.

**Parent class** is the class being inherited from, also called base class.

**Child class** is the class that inherits from another class, also called derived class.

---

# Inheritance

## Create a Parent Class

Any class can be a parent class, so the syntax is the same as creating any other class:

```python
class Person:
  def __init__(self, fname, lname):
    self.firstname = fname
    self.lastname = lname

  def printname(self):
    print(self.firstname, self.lastname)

# Use the Person class to create an object, and then execute the printname method:

x = Person("John", "Doe")
x.printname()
```
## Create a Child Class

To create a class that inherits the functionality from another class, send the parent class as a parameter
when creating the child class:

```python
class Student(Person):
   pass
```
Now the Student class has the same properties and methods as the Person class.

## Add the \_\_init_\_() Function

So far we have created a child class that inherits the properties and methods from its parent.

We want to add the `__init__()` function to the child class (instead of the pass keyword).

When you add the `__init__()` function, the child class will no longer inherit the parent's `__init__()` function.

To keep the inheritance of the parent's `__init__()` function, add a call to the parent's `__init__()` function:

```python
class Student(Person):
  def __init__(self, fname, lname):
    Person.__init__(self, fname, lname)
```

Now we have successfully added the `__init__()` function, and kept the inheritance of the parent class, and we are
ready to add functionality in the `__init__()` function.

## Add Properties

Add a property called graduationyear to the Student class:

```python
class Student(Person):
  def __init__(self, fname, lname):
    Person.__init__(self, fname, lname)
    self.graduationyear = 2019
```

## Add Methods

Add a method called welcome to the Student class:

```python
class Student(Person):
  def __init__(self, fname, lname, year):
    Person.__init__(self, fname, lname)
    self.graduationyear = year

  def welcome(self):
    print("Welcome", self.firstname, self.lastname, "to the class of", self.graduationyear)
```
If you add a method in the child class with the same name as a function in the parent class, the inheritance of the
parent method will be **overridden**.

---

# Multiple Inheritance

Python supports a form of multiple inheritance as well. A class definition with multiple base classes looks like this:

```python
class DerivedClassName(Base1, Base2, Base3):
    <statement-1>
    .
    .
    .
    <statement-N>
```

---

# References

- https://www.w3schools.com/python/python_inheritance.asp
- https://docs.python.org/3/tutorial/classes.html#inheritance
