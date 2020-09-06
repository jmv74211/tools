import time
import multiprocessing

# Multiprocessing demonstration that each process does not share variables

square_result = []

def calc_square(numbers):
  global square_result

  for n in numbers:
    time.sleep(0.2)
    print('square ', str(n*n))
    square_result.append(n*n)

  print('inside process: result ' + str(square_result))

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

