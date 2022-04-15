import copy
from python.dev.math.interest import Yield

class Record():
    def __init__(self, event, time0=None):
        self.__event = event
        self.__tn = None
        self.__balance = 0
        self.__principle = 0
        self.__yield = 0
  
    def init_first_record(self, t0):
        self.__tn = t0

    def get_balance(self):
        return self.__balance
    
    def get_principle(self):
        return self.__principle   
    
    def get_timestamp(self):
        return self.__tn     
    
    def get_yield(self):
        return self.__yield   
    
    def get_event(self):
        return self.__event       
    
    def update_event(self, event):
        self.update_timestamp()
        self.update_balance()  
        self.update_principle()
        self.__event = copy.copy(event) 
   
    def update_timestamp(self):
        self.__tn = self.__tn + self.__event.get_time_delta()

    def update_principle(self):
        self.__principle = self.__principle + self.__event.get_delta()

    def update_balance(self):
        self.update_yield()
        self.__balance = self.__balance + self.__yield + self.__event.get_delta()  
       
    def update_yield(self):
        t_delta = self.__event.get_time_delta()
        apy = self.__event.get_apy()        
        self.__yield = Yield(self.__balance, t_delta, apy).apply()
        
        