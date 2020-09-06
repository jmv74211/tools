import multiprocessing

# Multiprocessing how to share data between processes using Queue

def calc_square(numbers, q):
  for n in numbers:
    q.put(n*n)

if __name__ == '__main__':
  numbers = [2,3,5]
  q = multiprocessing.Queue()
  p1 = multiprocessing.Process(target=calc_square, args=(numbers,q))

  # Start processes execution
  p1.start()

  # Wait for thread tasks to finish
  p1.join()

  while q.empty() is False:
    print(q.get())
