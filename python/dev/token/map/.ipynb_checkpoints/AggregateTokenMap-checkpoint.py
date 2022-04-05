from python.dev.token import Token
from python.dev.token.map import TokenMap

class AggregateTokenMap(Token):
    
    def __init__(self, name, token_map = TokenMap()):
        super().__init__(name, None, None)
        self.__token_map = token_map
        self.__aggregate_supply = 0
        
    def apply(self):
        token_map = self.__token_map.get_map()
        for key in token_map:
            supply = token_map[key].get_supply().get_total_supply()
            self.__aggregate_supply = self.__aggregate_supply + supply
        super().set_total_supply(self.__aggregate_supply)    
     