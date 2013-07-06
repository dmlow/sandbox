import numpy as np

digits = ['','one','two','three','four','five','six','seven','eight','nine']
teens = ['ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen']
tens = ['','','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety']
powers = ['','','hundred','thousand','','','million','','','billion','','','trillion','','','quadrillion']

class counter:
    def __init__(self):
        '''
        '''
        n = 1


    def nString(self, n, **kwargs):
        if n == 0:
            return ''
        
        sep = kwargs.get('sep', ' ')
        
        p = int(np.log10(n))
        m = n / (10 ** p)
        r = n % (m * (10 ** p))

        if p == 0:
            return digits[n]
        elif p == 1:
            if n < 20:
                return teens[n % 10]
            else:
                return '%s%s%s' % (tens[m], sep, self.nString(r, sep = sep))
        elif p == 2:
            if r > 0:
                return '%s%s%s%sand%s%s' % (digits[m], sep, powers[p], sep, sep, self.nString(r, sep = sep))
            else:
                return '%s%s%s' % (digits[m], sep, powers[p])
        elif p > 2:
            p2 = 3 * (p / 3)
            m2 = n / (10 ** p2)
            r2 = n % (m * (10 ** p2))
            return '%s%s%s%s%s' % (self.nString(m2, sep=sep), sep, powers[p2], sep, self.nString(r2, sep=sep))

    def count(self, n, **kwargs):
        sep = kwargs.get('sep', ' ')

        return len(self.nString(n, sep = sep))

    def sequentialCount(self, n, **kwargs):
        sep = kwargs.get('sep', ' ')
        
        nChars = 0
        for i in range(1, n+1):
            nChars += self.count(i, sep = sep)

        return nChars

if __name__ == '__main__':
    counter = counter()
    print counter.sequentialCount(1000, sep = '')