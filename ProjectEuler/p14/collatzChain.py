from primefinder import primefinder
from math import log

def collatzChain(n):
    ''' returns a collatz chain starting with n
    '''

    chain = [n]
    m = nextVal(n)
    while m:
        chain.append(m)
        m = nextVal(m)
    
    return chain

def nextVal(n):
    if n == 1:
        return None
    if n % 2:
        return 3 * n + 1
    else:
        return n / 2

def maxPowerOfTwo(n, max):
    return int(log(max)/log(2)) - int(log(n)/log(2))



if __name__ == '__main__':
    max = 10 ** 6
    pf = primefinder()
    primes = pf.findPrimesUpTo(max)
    i = 0
    p = 1
    while p < max:
        p *= primes[i]
        i += 1
    p /= primes[i-1]
    
    vals = [1024, max, max - 1, max - 2, 18, 17, primes[-1], p, 2**19]
    for v in vals:
        chain = collatzChain(v)
        print v, len(chain)

    maxLength = 0
    maxStarter = 1
    for v in range(max):
        length = len(collatzChain(v))
        if length > maxLength:
            maxStarter = v
            maxLength = length
    print maxStarter, maxLength
