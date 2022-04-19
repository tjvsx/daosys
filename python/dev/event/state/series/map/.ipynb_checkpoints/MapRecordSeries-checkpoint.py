class MapStateSeries(): 
    
    def __init__(self, name, address_states = None):
        self.__name = name
        self.__address_states = {}  
        
    def get_address_states(self):
        return self.__address_states
    
    def get_states(self, address):
        return self.__address_states[address]   

    def add_state_series(self, state_series, address):
        self.__address_states[address] = state_series    
        
    def add_state(self, state, address):
        self.__address_states[address].add_state(state)        
    