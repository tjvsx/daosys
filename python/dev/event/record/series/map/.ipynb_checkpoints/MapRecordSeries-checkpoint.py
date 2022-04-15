class MapRecordSeries(): 
    
    def __init__(self, name, address_records = None):
        self.__name = name
        self.__address_records = {}  
        self.__init_times = {}
        
    def get_address_records(self):
        return self.__address_records

    def get_init_times(self):
        return self.__init_times    
    
    def get_init_time(self, address):
        return self.__init_times[address]

    def get_record_series(self, address):
        return self.__address_records[address]
    
    def get_records(self, address):
        return self.__address_records[address]   
 
    def add_init_time(self, time0, address):
        self.__init_times[address] = time0 

    def add_record_series(self, record_series, address):
        self.__address_records[address] = record_series    
        
    def add_record(self, record, address):
        self.__address_records[address].add_record(record)        
    