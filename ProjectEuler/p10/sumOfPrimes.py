from primefinder import primefinder

if __name__ == '__main__':
    n = 2 * 10**6
    pf = primefinder()
    primes = pf.findPrimesUpTo(n)
    print 'the sum of all the primes up to %d is %d' % (n, sum(primes))