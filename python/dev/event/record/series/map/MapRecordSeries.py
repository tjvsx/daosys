class MapRecordSeries(): 
    
    def __init__(self, name, address_records = None):
        self.__name = name
        self.__address_records = {}  
        
    def get_address_records(self):
        return self.__address_records
    
    def get_records(self, address):
        return self.__address_records[address]   

    def add_record_series(self, record_series, address):
        self.__address_records[address] = record_series    
        
    def add_record(self, record, address):
        self.__address_records[address].add_record(record)        
    