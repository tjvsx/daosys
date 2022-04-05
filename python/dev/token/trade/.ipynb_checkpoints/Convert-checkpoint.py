class Convert(): 
    def __init__(self, native_rate):
        self.__native_rate = native_rate
    
    def apply(self,token_delta):
        return self.__native_rate*token_delta