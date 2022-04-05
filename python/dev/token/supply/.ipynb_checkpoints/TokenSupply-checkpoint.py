DECIMALS = 6
MAX_UINT256 = (2**128) - 1
INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**DECIMALS
TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY)
MAX_SUPPLY = MAX_UINT256

class TokenSupply():

    def __init__(self):
        self.__total_supply = float(INITIAL_FRAGMENTS_SUPPLY)
        self.__gons_per_frag = float(TOTAL_GONS)/float(MAX_SUPPLY)
        
    def get_max_supply(self):
        return self.__total_supply
    
    def get_total_supply(self):
        return self.__total_supply
    
    def set_total_supply(self, total_supply):
        self.__total_supply = total_supply    

    def get_gons_per_fragment(self):
        return self.__gons_per_frag
    
    def rebase(self, delta):

        if (delta < 0):
            self.__total_supply = self.__total_supply - abs(delta)
        else:
            self.__total_supply = self.__total_supply + abs(delta);
             
        self.__gons_per_frag = TOTAL_GONS/self.__total_supply;
        
        if (self.__total_supply > MAX_SUPPLY): 
            self.__total_supply = MAX_SUPPLY
        
        return self.__total_supply