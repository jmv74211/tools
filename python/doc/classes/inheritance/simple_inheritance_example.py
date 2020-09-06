# Parent class
class Person:
    def __init__(self, fname, lname):
        self.firstname = fname
        self.lastname = lname

    def printname(self):
        print("Person: " + self.firstname + " " + self.lastname)


# Child class
class Student(Person):
    def __init__(self, fname, lname, year):
        Person.__init__(self, fname, lname)
        self.graduationyear = year

    def welcome(self):
        print("Welcome", self.firstname, self.lastname, "to the class of", self.graduationyear)

    # Method override from parent class
    def printname(self):
        print("Student: " + self.firstname + " " + self.lastname)


if __name__ == "__main__":
    p = Person('Jonathan', 'Avd')
    p.printname()

    s = Student('Nerea', 'Fda', '2019')
    s.printname()  # Parent method overrided
    s.welcome()
