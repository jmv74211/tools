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