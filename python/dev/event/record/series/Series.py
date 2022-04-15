import copy

class Series():
    
    def __init__(self, records = None):
        self.__records = [] if records == None else records
        
    def get_records(self):
        return self.__records 
    
    def get_num_records(self):
        return len(self.__records)   
    
    def get_record(self, index):
        return self.__records[index]  
    
    def add_record(self, record):
        return self.__records.append(copy.copy(record)) 