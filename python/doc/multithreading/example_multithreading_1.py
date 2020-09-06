import time
import threading

# Multithreading program

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

# Wait until threads tasks finish
t1.join()
t2.join()

print("Done in ", time.time() - t)
