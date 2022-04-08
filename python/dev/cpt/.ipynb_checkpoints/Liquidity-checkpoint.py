# Based on Uniswap v1 and v2 (see Reference 1); for Uniswap v3 see reference 3

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
        
    def set_x_real(self, x_real):
        self.__x_real = x_real
        
    def set_y_real(self, y_real):
        self.__y_real = y_real
        
    def calc_delta_y(self, delta_x):
        return (self.__y_real*delta_x)/(self.__x_real+delta_x)

    def calc_delta_x(self, delta_y):
        return (self.__x_real*delta_y)/(self.__y_real+delta_y)

    def calc_delta_x(self, delta_x):    
        self.__x_real = (self.__x_real+delta_x)                      
        return np.sqrt(self.__x_real*self.__y_real)   
    
    def calc_delta_y(self, delta_y):    
        self.__y_real = (self.__y_real+delta_y)                      
        return np.sqrt(self.__x_real*self.__y_real)      
        
    def calc(self, delta_x = None):
        
        if(delta_x != None):
            delta_y = self.calc_delta_y(delta_x)
            self.__x_real = (self.__x_real+delta_x)
            self.__y_real = (self.__y_real-delta_y)            
            
        return np.sqrt(self.__x_real*self.__y_real)
