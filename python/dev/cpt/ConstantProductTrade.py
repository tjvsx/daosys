import numpy as np

class ConstantProductTrade():
    
    def __init__(self, L):
        self.__L = L
          
    def __x_p(self, p):
        return self.__L/(p ** 0.5)

    def __y_p(self, p):
        return self.__L*(p ** 0.5)

    def set_liquidity(self, L):
        self.__L = L     
    
    def inflection_point(self, price):
        x_pnt = self.__x_p(price)
        y_pnt = self.__y_p(price)
        return (x_pnt,y_pnt) 
          
    def f(self, x):
        return self.__L**2/x  
    
    def gen_swap_x(self, price, delta):
        a = price
        b = -price*delta
        c = -self.__L**2 
        return (-b + (b**2 - 4*a*c)**0.5)/(2*a) 

    def gen_swap_y(self, price, x_swap):
        return price*x_swap 
   
    def swap_point(self, price, delta):
        x_swap = self.gen_swap_x(price, delta)
        y_swap = self.gen_swap_y(price, x_swap)
        return (x_swap,y_swap)   
    
    def random_delta(self, max_trade = 1):
        shape, scale = 1, max_trade/5
        trade = np.random.gamma(shape, scale, 1)
        return min(trade[0],max_trade)    