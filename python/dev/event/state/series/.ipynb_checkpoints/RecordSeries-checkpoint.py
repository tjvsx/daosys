from datetime import datetime
from python.dev.event.record.series import Series

class RecordSeries(Series):   
    def __init__(self, records = None):
        super().__init__(records)
    
    def get_principle(self):
        N = super().get_num_records()
        records = super().get_records()
        return [records[k].get_principle() for k in range(N)]
    
    def get_balance(self):
        N = super().get_num_records()
        records = super().get_records()
        return [records[k].get_balance() for k in range(N)]

    def get_ustamp(self):
        N = super().get_num_records()
        records = super().get_records()
        return [records[k].get_timestamp() for k in range(N)]
    
    def get_tstamp(self):
        N = super().get_num_records()
        ustamp = self.get_ustamp()
        return [datetime.fromtimestamp(t) for t in ustamp]
