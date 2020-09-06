import multiprocessing
import time

# Multiprocessing program to use map reduce paradigm

def f(n):
  sum = 0
  for x in range(1000):
    sum += x*x
  return sum

if __name__ == '__main__':

  t1 = time.time()
  p = multiprocessing.Pool() # You can use processes parameter to specify the number of CPU cores.
  result = p.map(f,range(100000)) # Divide the work between all CPU cores
  p.close()
  p.join()

  print("Pool took: ", time.time()-t1)

  t2 = time.time()
  result = []
  for x in range(100000):
    result.append(f(x))

  print("Sequential processing took: ", time.time()-t2)