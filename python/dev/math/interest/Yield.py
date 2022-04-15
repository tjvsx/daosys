DAYS_IN_YEAR = 365.25
HOURS_IN_DAY = 24
SECONDS_IN_HOUR = 3600

class Yield():
    def __init__(self, balance, delta_t, apy):
        self.__balance = balance
        self.__delta_t = delta_t
        self.__apy = apy
             
    def __seconds_per_year(self):
        return DAYS_IN_YEAR*HOURS_IN_DAY*SECONDS_IN_HOUR

    def apply(self):  
        multiplier = 1 + self.__apy
        freq = self.__seconds_per_year()
        new_balance = self.__balance*(multiplier)**(self.__delta_t/freq)
        return new_balance-self.__balance