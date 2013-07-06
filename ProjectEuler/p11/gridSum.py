class gridsum:
    def __init__(self, filename):
        self.grid = []
        f = open(filename, 'r')
        for line in f:
            self.grid.append(map(int, line.split(' ')))

    def __repr__(self):
        s = ''
        for r in range(len(self.grid)):
            s += ' '.join(map(str, self.grid[r]))
            s += '\n'
        print s

    def __getitem__(self, j, k):
        return self.grid[j][k]

    def arraysum(self, a, n):
        print a
        if n > len(a):
            return None

        maxP = 0
        for i in range(len(a)-n):
            p = 0
            if 0 in a[i:(i+n)]:
                print 'found zero'
            else:
                print 'no zero found'
                p = 1
                for j in range(n):
                    p *= a[i+j]
            if p > maxP:
                maxP = p
                    
        return maxP

    def maxprodh(self, n):
        maxP = 0
        for r in self.grid:
            p = self.arraysum(r, n)
            if p > maxP:
                maxP = p
        return maxP

    def maxprodv(self, n):
        maxP = 0
        for c in range(len(self.grid[0])):
            

if __name__ == '__main__':
    g = gridsum('grid.txt')
    
    print str(g.maxprodh(4))