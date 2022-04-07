import matplotlib.pyplot as plt

from python.dev.cpt import ConstantProductTrade
from python.dev.cpt import PriceCurve

class PlotPriceCurve():
    
    def __init__(self, L, cpt = None, pCurve = None):
        self.__L = L
        self.__cpt = ConstantProductTrade(L) if cpt == None else cpt
        self.__pCurve = PriceCurve(L) if pCurve == None else pCurve
        
    def set_liquidity(self, L):
        self.__L = L 
        
    def set_cpt(self, cpt): 
        self.__cpt = cpt
        
    def set_p_curve(self, pCurve): 
        self.__pCurve = pCurve        
 
    def gen_bounds(self, p):
        (x_pnt, y_pnt) = self.__cpt.inflection_point(p)
        x_bound = self.__pCurve.get_factor()*x_pnt
        y_bound = self.__pCurve.get_factor()*y_pnt
        return (x_bound,y_bound)

    def gen_data(self, x_bound):
        x_val = self.__pCurve.x_val(x_bound)
        y_val = self.__pCurve.y_val(x_val)
        return x_val, y_val
        
    def apply(self, p):
        x_bound, y_bound = self.gen_bounds(p)
        x_val, y_val = self.gen_data(x_bound)
        fig, ax = plt.subplots(figsize=(10, 10))
        plt.plot(x_val, y_val, label='curve')
        plt.ylim(0, y_bound)
        plt.xlim(0, x_bound)  
        
    def apply_next(self, p, L): 
        self.__pCurve = PriceCurve(L)
        self.__cpt = ConstantProductTrade(L)
        x_bound, y_bound = self.gen_bounds(p)
        x_val, y_val = self.gen_data(x_bound)        
        plt.plot(x_val, y_val, label='curve')
        plt.ylim(0, y_bound)
        plt.xlim(0, x_bound)         
        
    def plot_trade(self, price, delta, ltype = 'b--', p_lines = True):
        (x_swap,y_swap) = self.__cpt.swap_point(price, delta)  
        plt.scatter([x_swap], [y_swap], marker='o', color='green',s=25, label = 'swaps')
        if(p_lines): 
            plt.plot([self.__cpt.f(y_swap), x_swap],[y_swap, y_swap],ltype,lw=0.5)
            plt.plot([x_swap, x_swap],[y_swap, self.__cpt.f(x_swap)],ltype,lw=0.5)
        