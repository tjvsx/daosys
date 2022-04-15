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
        self.__rec.init_first_record(time0)
 
    def add_event(self, event):
        
        addresses = super().get_addresses()
        supply = super().get_supply()
        address = event.get_address()
        delta = event.get_delta()
        
        self.__rec.update_event(event)
        delta = delta+self.__rec.get_yield() 
        
        if(not addresses.address_exist(address)):
            self.__record_map.add_record_series(RecordSeries(), address)
            addresses.set_balance(delta, address)
        else:        
            addresses.delta_balance(delta, address)
            
        self.__record_map.add_record(self.__rec, address)                 
        supply.rebase(delta)  
                
        
        
