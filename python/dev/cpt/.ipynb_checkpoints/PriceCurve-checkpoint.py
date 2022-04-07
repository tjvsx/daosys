import numpy as np

X_INCREMENT = 0.001
L_FACTOR = 3

class PriceCurve():
    
    def __init__(self, L, l_factor = L_FACTOR, x_inc = X_INCREMENT):
        self.__L = L
        self.__x_inc = x_inc
        self.__l_factor = l_factor 
         
    def set_liquidity(self, L):  
        self.__L = L
        
    def set_factor(self, l_factor):  
        self.__l_factor = l_factor        
        
    def set_x_increment(self, x_inc):
        self.__x_inc = x_inc
        
    def get_factor(self):  
        return self.__l_factor 
       
    def x_val(self, x_bound = None):
        x_bound = self.__l_factor*self.__L if x_bound == None else x_bound
        return np.arange(self.__x_inc, x_bound, self.__x_inc)
    
    def y_val(self, x_vals):
        return self.__L**2/x_vals   
    