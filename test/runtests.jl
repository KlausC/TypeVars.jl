using TypeVars
using Test


struct Zm{M, T<:Integer}
    val::T
end

import Base: +
+(a::Z, b::Z) where Z<:Zm = Z(mod(a.val + b.val, typevar(Z)))

@testset "TypeVars" begin

    m = big"2"^512 -1 
    M = Symbol(hash(m))
    Z = Zm{M,BigInt}
    settypevar(Z, m)

    a = Z(m - 5)
    b = Z(m - 10)
    c = a + b
    @test c.val == m - 15
end
