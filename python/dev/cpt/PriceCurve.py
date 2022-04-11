import numpy as np

L_FACTOR = 2
N_SAMP = 10000

class PriceCurve():
    
    def __init__(self, L, l_factor = L_FACTOR, n_samples = N_SAMP):
        self.__L = L
        self.__l_factor = l_factor 
        self.__n_samples = n_samples
         
    def set_liquidity(self, L):  
        self.__L = L
        
    def set_factor(self, l_factor):  
        self.__l_factor = l_factor        
        
    def set_x_increment(self, x_inc):
        self.__x_inc = x_inc
        
    def get_factor(self):  
        return self.__l_factor 
    
    def gen_increment(self):
        return (self.__l_factor*self.__L)/self.__n_samples
       
    def x_val(self, x_bound = None):
        x_bound = self.__l_factor*self.__L if x_bound == None else x_bound
        x_inc = self.gen_increment()
        return np.arange(x_inc, x_bound, x_inc)
    
    def y_val(self, x_vals):
        return self.__L**2/x_vals   
    