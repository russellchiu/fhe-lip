from key_gen import sample_key
from dataclasses import dataclass

@dataclass
class LIPKey:
    P: sage.matrix
    U: sage.matrix

    def generate(ctx) -> LIPKey:
        P, U = sample_key(ctx.s, ctx.n)
        return LIPKey(P=P, U=U)

class Plaintext:
    def __init__(self, message, modulus):
        self.p = modulus
        self.m = message % self.p


@dataclass
class LIPCiphertext:
    e: sage.vector # coset representative a

    def __add__(self, other) -> LIPCiphertext:
        return LIPCiphertext(e=(self.e + other.e))

    def __mul__(self, other) -> LIPCiphertext:
        # this is more complicated
        pass


class Context:
    def __init__(self, smoothing, modulus, dimension):
        self.s = smoothing
        self.q = modulus
        self.n = dimension

    def KeyGen(self) -> LIPKey:
        return LIPKey.generate(self)

    def Encrypt(self, key: LIPKey, message: Plaintext) -> LIPCiphertext:
        # encrypt message under key
        pass

    def Decrypt(self, key: LIPKey, ciphertext: LIPCiphertext) -> Plaintext:
        # decrypt ciphertext under key
        pass

