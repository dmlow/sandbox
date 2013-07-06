''' 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
    
    What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
    
'''
def primeFactors(n):
    ''' returns list of prime factors for n
    '''

    factors = []
    m = n
    for factor in range(2, n+1):
        p = 0
        while ((m % factor) == 0):
            m /= factor
            p += 1
        if p > 0:
            factors.append((factor, p))

    return factors

def product(array):
    p = 1
    for f in array:
        p *= f

    return p

def sequentialLcm(n):
    ''' let's just keep multiplying the numbers in as we need 'em
    '''

    p = 1
    for i in range(n, 0, -1):
        if (p % i) != 0:
            p *= i
        print i, p

    return p

if __name__ == '__main__':
    factors = []
    for n in range(1, 20 + 1):
        factors += primeFactors(n)
        print primeFactors(n)
    print factors
    print sequentialLcm(20)
# p = product(factors)
#  print primeFactors(p)


    