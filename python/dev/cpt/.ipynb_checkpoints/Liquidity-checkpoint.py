# Based on Uniswap v1 and v2 (see Reference 1); for Uniswap v3 see reference 2

# References: 

# [1] Pandichef, A Brief History of Uniswap and Its Math 
# Link: https://pandichef.medium.com/a-brief-history-of-uniswap-and-its-math-90443241c9b7

# [2] Atis Elsts, Liquidity Math in Uniswap V3  
# Link: https://atiselsts.github.io/pdfs/uniswap-v3-liquidity-math.pdf

import numpy as np

class Liquidity():
    
    def __init__(self, x_real, y_real):
        self.__x_real = x_real
        self.__y_real = y_real
        self.__new_x = 0
        self.__new_y = 0        
 
    def get_x_real(self):
        return self.__x_real

    def get_y_real(self):
        return self.__y_real
        
    def set_y_real(self, y_real):
        self.__y_real = y_real
        
    def set_x_real(self, x_real):
        self.__x_real = x_real   
        
    def add_x(self, x_new):
        self.__x_new = x_new  
      
    def add_y(self, y_new):
        self.__y_new = y_new       
        
    def calc_delta_y(self, delta_x):
        return (self.__y_real*delta_x)/(self.__x_real+delta_x)

    def calc_delta_x(self, delta_y):
        return (self.__x_real*delta_y)/(self.__y_real+delta_y)
  
    def calc(self):    
        return np.sqrt(self.__x_real*self.__y_real)    
         
    def update(self, delta_x):
        
        delta_y = self.calc_delta_y(delta_x)
        self.__x_real = (self.__x_real+delta_x+self.__x_new)
        self.__y_real = (self.__y_real-delta_y+self.__y_new)      
        self.__x_new = 0
        self.__y_new = 0
            
        return np.sqrt(self.__x_real*self.__y_real)
