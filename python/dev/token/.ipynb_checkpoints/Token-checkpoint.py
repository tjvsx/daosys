from python.dev.token.supply import TokenSupply
from python.dev.token.address import TokenAddress


class Token():
    
    def __init__(self, name, supply = None, addresses = None):
        self.__tname = name
        self.__supply = TokenSupply() if supply == None else supply
        self.__addresses = TokenAddress(self.__supply.get_gons_per_fragment()) if addresses == None else addresses
               
    def set_token(self, token):
        self.__tname = token.get_name()
        self.__supply = token.get_supply()
        self.__addresses = token.get_addresses()
        
    def get_addresses(self):
        return self.__addresses
    
    def get_supply(self):
        return self.__supply    
    
    def get_rate(self):
        return self.__native_rate    
      
    def get_name(self):
        return self.__tname       
    
    def set_rate(self, native_rate):
        self.__native_rate = native_rate 
        
    def set_addresses(self, addresses):
        self.__addresses = addresses
        
    def set_total_supply(self, total_supply):
        return self.__supply.set_total_supply(total_supply)       

    def gen_address(self):
        return self.__addresses.gen_key()
    
    def get_balance_deposits(self):
        deposits = self.__addresses.get_balances()
        return sum(list(deposits.values()))
    
    def deposit(self, delta, address):
        
        if(not self.__addresses.address_exist(address)):
            self.__addresses.set_balance(delta, address)
        else:    
            self.__addresses.delta_balance(delta, address)
 
        self.__supply.rebase(delta) 
    
    def transfer(self, delta, from_address, to_address):
        self.__addresses.delta_balance(-delta, from_address)
        self.__addresses.delta_balance(delta, to_address)
     
    def rebase(self, delta):
        self.__supply.rebase(delta)  