from python.dev.event import Event

class Withdraw(Event):
    
    def __init__(self, apy, delta, t_delta):
        self.__t_delta = t_delta
        self.__delta = -delta
        self.__apy = apy
        
    def get_time_delta(self):
        return self.__t_delta  
    
    def get_delta(self):
        return self.__delta
    
    def get_apy(self):
        return self.__apy    
    
    def type_of(self):
        return Event.EVENT_WITHDRAW  