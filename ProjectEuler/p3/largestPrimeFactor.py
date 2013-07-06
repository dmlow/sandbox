import numpy as np

def largestPrimeFactor(n):
    max = int(np.sqrt(n))
    
    m = n
    pMax = 2
    for p in range(2, max):
        while (m % p) == 0:
            m /= p
            pMax = p

    return pMax

if __name__ == '__main__':
    n = 600851475143
    p = largestPrimeFactor(n)
    print 'largest prime factor of %d is %d' % (n, p)
