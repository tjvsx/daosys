from python.dev.event.record.series.map import MapRecordSeries
from python.dev.event.record.series import RecordSeries
from python.dev.event.record import Record
from python.dev.token import Token
from python.dev.event import Deposit

class AToken(Token):
    
    def __init__(self, name, supply = None, addresses = None):
        super().__init__(name, None, None)
        self.__rec = None
        self.__record_map = MapRecordSeries(name)
 
    def get_record_map(self):
        return self.__record_map

    def get_record_series(self,address):
        return self.__record_map.get_records(address)
    
    def init_address(self, time0, address):
        self.__rec = Record(Deposit(0,0,0))
        self.__record_map.add_init_time(time0, address)
         
    def deposit_event(self, apy, t_delta, delta, address):
        
        addresses = super().get_addresses()
        supply = super().get_supply()
        
        event = Deposit(apy,delta,t_delta,address)
        self.__rec.update_event(event)
        delta = delta+self.__rec.get_yield() 
        
        if(not addresses.address_exist(address)):
            time0 = self.__record_map.get_init_time(address)
            self.__record_map.add_record_series(RecordSeries(time0),address)
            addresses.set_balance(delta, address)
        else:        
            addresses.delta_balance(delta, address)
            
        self.__record_map.add_record(self.__rec,address)                 
        supply.rebase(delta)  
        
        
