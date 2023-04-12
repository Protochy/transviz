
from scipy import integrate
from scipy.integrate import quad
import numpy as np


def complex_quadrature(func, a, b, **kwargs):
    def real_func(x):
        return np.real(func(x))
    def imag_func(x):
        return np.imag(func(x))
    real_integral = quad(real_func, a, b, **kwargs)
    imag_integral = quad(imag_func, a, b, **kwargs)
    return (real_integral[0] + 1j*imag_integral[0], real_integral[1:], imag_integral[1:])

def f(x):
  return 200*(x+np.sin(x)) + np.sin(8.4j*x*x)
#s = complex_quadrature(lambda x: f(x)*np.exp(-2j*np.pi*x * 0),0,1)[0]
#print(f'coeff.add(new PVector({s.real},{s.imag}));')
#for n in range(1,3):
 # s = complex_quadrature(lambda x: f(x)*np.exp(-2j*np.pi*x * n),0,1)[0]
  #print(f'coeff.add(new PVector({s.real},{s.imag}));')

  #s = complex_quadrature(lambda x: f(x)*np.exp(2j*np.pi*x * n),0,1)[0]
 # print(f'coeff.add(new PVector({s.real},{s.imag}));')

h = []

import json
with open("points.txt",mode="r+") as f:
  for bruh in f.readlines():
    h.append(json.loads(bruh))


xs = np.linspace(0,1,len(h))
ys = []
for jo in h:
  ys.append(jo[0] + -1j*jo[1])

 #f(x) * e^(-2ipinx)dx
s = integrate.simpson([ys[k]*np.exp(-2j*np.pi* xs[k] * 0) for k in range(0,len(xs))], xs)
print(f'coeff.add(new PVector({s.real},{s.imag}));')
for n in range(1,50):
  s = integrate.simpson([ys[k]*np.exp(-2j*np.pi* xs[k] * n) for k in range(0,len(xs))], xs)
  print(f'coeff.add(new PVector({s.real},{s.imag}));')
  s = integrate.simpson([ys[k]*np.exp(2j*np.pi* xs[k] * n) for k in range(0,len(xs))], xs)
  print(f'coeff.add(new PVector({s.real},{s.imag}));')
  
