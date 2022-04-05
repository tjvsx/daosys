from python.dev.token import Token

class Swap(Token): 
    
    def __init__(self, token, native_rate, address = None):
        super().__init__(token.get_name(), token.get_supply(), token.get_addresses())
        self.__native_rate = native_rate
        self.__address = address if token.get_rate().gen_key() == None else address
     
    def apply(self, token, token_delta, address):
        token_balance = token.get_addresses().get_balance(address)
        balance = self.__native_rate*token_delta  
        super().set_balance(balance, self.__address)
        token.set_balance(balance-token_delta, address)