def findPalindrome(n):
# finds the largest palindrome that is the product of two n-digit numbers by working backwards from the larger products, which we do by traversing the product matrix by eliminating slant diagonals of the upper triangular matrix starting from the bottom right corner: eg, 999x999, 998x999, 998x998, 999x997, 997x998, 996x999, 997x997...
    a = 10 ** n
    b = 10 ** n
    p = a * b

    r = a - 1
    c = b - 1
    
    while not(isPalindrome(p)):
        a = r
        b = c
        # traverse up and two the right
        while (b < 999) and not(isPalindrome(p)):
            p = a * b
            a -= 1
            b += 1
        # move up on odd rows, left on even rows
        if (r % 2):
            r -= 1
        else:
            c -= 1



    return (p, a, b)

def isPalindrome(n):
    # string check -- there ought to be a better mathematical check
    s = str(n)
    return s == s[::-1]

if __name__ == '__main__':
    n = 3
    (p, a, b) = findPalindrome(n)
    print 'the largest palindrome made from the product of two 3-digit numbers is %d = %d x %d' % (p, a, b)

    '''
    by inspection, i determined that the sort order of products follows a pattern starting from the bottom right corner of the upper triangular matrix of products, and moves up and to the right until until we reach the far right edge, after which we move along the next slant diagonal in the matrix...
        
    m = []
    f = []
    for r in range(994, 1000):
        mrow = []
        frow = []
        for c in range(993, r-1):
            frow.append('       ')
            mrow.append(0)
        for c in range(r, 1000):
            frow.append('%dx%d' % (r, c))
            mrow.append(r*c)
        f.append(frow)
        m.append(mrow)

    print np.matrix(m)
    print np.matrix(f)
    '''
