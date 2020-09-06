class Person:
    race = "human"  # static class variable

    # Constructor
    def __init__(self, name, age):
        self.name = name  # Instance variable
        self.age = age  # Instance variable

    # regular instance method
    def print_message(self):
        print("Message from " + self.name)

    # class method
    @classmethod  # Methods reference: https://julien.danjou.info/guide-python-static-class-abstract-methods/
    def add_one(self, age):
        return age + 1

    # static method class
    @staticmethod
    def print_static_class_message():
        print("Message from static method")


if __name__ == "__main__":
    first_person = Person("Antonio", 25)
    second_person = Person("Francisco", 39)

    first_person.print_message()  # > Message from Antonio
    second_person.print_message()  # > Message from Francisco

    Person.print_static_class_message()  # > Message from static method

    print(Person.add_one(25))  # > 26

    print(first_person.race)  # > human
    print(second_person.race)  # > human

    Person.race = "no human"

    print(first_person.race)  # > no human
    print(second_person.race)  # > no human
