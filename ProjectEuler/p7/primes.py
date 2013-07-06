'''By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
    
    What is the 10 001st prime number?
'''
import math
import time

def findPrimes(n):
    n = int(n)
    if n <= 1:
        return []
    if n == 2:
        return [2,3]

    candidate = 3
    primes = [2,3]

    while len(primes) < n:
        isPrime = True
        sqrt = math.sqrt(candidate)
        
        for p in primes:
            if p > sqrt:
                break
            if candidate % p == 0:
                isPrime = False
                break
        if isPrime:
            primes.append(candidate)
        candidate += 2

    return primes

if __name__=='__main__':
    n = 2*10**6
    print 'Finding first %d primes...' % (n)
    start = time.time()
    primes = findPrimes(n)
    t = (time.time() - start) * 1000
    print 'The last one was %d, which we found in %d ms' % (primes[-1], t)
