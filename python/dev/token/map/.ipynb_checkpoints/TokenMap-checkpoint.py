class TokenMap(): 
    
    def __init__(self, ttype = None):
        self.__ttype = ttype
        self.__map = {} 
        
    def get_map(self):
        return self.__map
        
    def append_token(self, name, token):        
        self.__map[name] = token