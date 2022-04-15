from python.dev.event.record.series import RecordSeries
from python.dev.event.record import Record
from python.dev.token import Token
from python.dev.event import Deposit

class AToken(Token):
    
    def __init__(self, name, supply = None, addresses = None):
        super().__init__(name, None, None)
        self.__rec = Record(Deposit(0,0,0))
        self.__address_records = {}
        self.__init_times = {}
      
    def get_records(self,address):
        return self.__address_records[address]
    
    def init_time(self, time0, address): 
        self.__init_times[address] = time0
         
    def deposit_event(self, apy, t_delta, delta, address):
        
        addresses = super().get_addresses()
        supply = super().get_supply()
        
        event = Deposit(apy,delta,t_delta,address)
        self.__rec.update_event(event)
        delta = delta+self.__rec.get_yield() 
        
        if(not addresses.address_exist(address)):
            time0 = self.__init_times[address]
            self.__address_records[address] = RecordSeries(time0)
            addresses.set_balance(delta, address)
        else:        
            addresses.delta_balance(delta, address)
            
        self.__address_records[address].add_record(self.__rec)                   
        supply.rebase(delta)  
        
        
