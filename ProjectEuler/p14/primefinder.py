class primefinder:
    def __init__(self):
        self.primes = []
    
    def __getitem__(self,k):
        return self.primes[k]
    
    def findNPrimes(self, n):
        n = int(n)
        
        self.primes = []
        if n <= 1:
            return []
        
        self.primes = [2,3]
        if n == 2:
            return [2,3]
        
        candidate = 3
        
        while len(self.primes) < n:
            isPrime = True
            sqrt = int(candidate ** 0.5 + 0.5)
            
            for p in self.primes:
                if p > sq:
                    break
                if candidate % p == 0:
                    isPrime = False
                    break
            if isPrime:
                self.primes.append(candidate)
            candidate += 2
        
        return self.primes

    def findPrimesUpTo(self, n):
        n = int(n)
        
        self.primes = []
        if n <= 1:
            return []
        
        self.primes.append(2)
        if n == 2:
            return self.primes
                
        candidate = 3
        
        while self.primes[-1] < n:
            isPrime = True
            sq = int(candidate ** 0.5 + 0.5)
            
            for p in self.primes:
                if p > sq:
                    break
                if candidate % p == 0:
                    isPrime = False
                    break
            if isPrime:
                self.primes.append(candidate)
            candidate += 2
        
        self.primes = self.primes[0:-1]
        return self.primes