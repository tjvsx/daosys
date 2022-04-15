from datetime import datetime
from python.dev.event.record.series import Series

class RecordSeries(Series):   
    def __init__(self, t0, records = None):
        super().__init__(records)
        self.__t0 = t0
    
    def get_principle(self):
        N = super().get_num_records()
        records = super().get_records()
        return [records[k].get_principle() for k in range(N)]
    
    def get_balance(self):
        N = super().get_num_records()
        records = super().get_records()
        return [records[k].get_balance() for k in range(N)]

    def get_tstamp(self):
        N = super().get_num_records()
        ustamp = self.get_ustamp()
        return [datetime.fromtimestamp(t) for t in ustamp]
    
    def get_ustamp(self):
        N = super().get_num_records()
        records = super().get_records()  
        ustamp = [self.__t0]
        for k in range(N): 
            ustamp.append(ustamp[-1]+records[k].get_event().get_time_delta())
        return ustamp[1:]