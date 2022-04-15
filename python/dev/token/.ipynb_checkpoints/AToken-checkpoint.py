from python.dev.event.record.archive import EventArchive
from python.dev.event.record import Record
from python.dev.token import Token
from python.dev.event import Deposit

class AToken(Token):
    
    def __init__(self, time0, name, supply = None, addresses = None):
        super().__init__(name, None, None)
        self.__rec = Record(Deposit(0,0,0))
        self.__events = EventArchive(time0)
      
    def get_events(self):
        return self.__events
    
    def deposit_event(self, apy, t_delta, delta, address):
        
        addresses = super().get_addresses()
        supply = super().get_supply()
        
        event = Deposit(apy,delta,t_delta)
        self.__rec.update_event(event)
        self.__events.add_record(self.__rec)
        delta = delta+self.__rec.get_yield() 
        
        if(not addresses.address_exist(address)):
            addresses.set_balance(delta, address)
        else:        
            addresses.delta_balance(delta, address)
            
        supply.rebase(delta)         
