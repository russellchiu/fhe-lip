import numpy as np

load("../src/proba_utils.sage")
load("../src/utils.sage")

# Key Gen algorithm implemented from ia.cr/2021/1332

def draw_from_distri(s, n, c):
    v = []
    for i in range(n):
        while True:
            x = np.random.randint(-s * pi * log(n), s * pi * log(n))
            proba = np.random.rand(1)
            rho = exp(-x ** 2 / (2 * s ** 2)) / sqrt(2 * pi * s * s)
            if proba[0] <= rho:
                v.append(x + c)
                break
    return vector(v)

'''
Key Sampling
Inputs: (n)
    - n is the dimension
Outputs: (P, U)
    - P, U satisfy P = U^tSU
'''
def sample_matrix(s, n):
    C = 1 - (1 + exp(-pi)) ** -1
    m = ceil(2 * n / C)
    Y = matrix(draw_from_distri(s, n, 0)))
    for i in range(m - 1):
        y = draw_from_distri(s, n, 0)
        Y = Y.augment(y)

    assert rank(Y) >= n
    return extract(Y)

'''
Extracts keys using Hermite Normal Form
Inputs: (Y)
    - Y is the sampled matrix
Outputs: (P, U)
    - P, U matrices computed by the HNF of Y
'''
def extract(Y):
    # TODO: integrate Harshith's HNF code
    pass

'''
Inputs: (None)
Outputs: (pk = P, sk = U)
    - P matrix sampled from I_n (used as the quadratic form input) and used as private key
    - U matrix generated by Hermite Normal Form and used as secret key
'''
def gen(n):
    s = sqrt(log(2 * n + 4) / pi)
    P, U = sample_matrix(s, n)
    return P, U
