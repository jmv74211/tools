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
