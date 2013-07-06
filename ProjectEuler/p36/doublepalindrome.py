from math import log, ceil

def binarycandidates(n):
    ''' return a list of all binary palindrome candidates up to n '''
    list = []
    p = int(ceil(log(n) / log(2))) / 2

    for i in range(p):
        left = 2*p - i
        right = i

        
