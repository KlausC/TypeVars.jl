# TypeVars

[![Build Status][gha-img]][gha-url]     [![Coverage Status][codecov-img]][codecov-url]

## Introduction

Sometimes it is useful to associate a data object with a parameterized type.
For example, the type `Zmod{m}` would represent integer calculations modulo `m`
where `m` is a samll integer.

This tiny package provides a way to extend this if type parameters are not
feasible to keep the data.

## API

There are 2 functions that make the user interface:

`settypevar(::Type, object)` is called once per type variant to define the association.

`typevar(::Type)` makes the object available in an efficient way.

## Usage Example

``` julia

using TypeVars

struct Zmod{M,T<:Integer>}
    val::T
end

m = big"2"^512 - 1
M = Symbol(hash(m))
settypevar(Zmod{M,BigInt}, m)

add(a::Z, b::Z) where Z<:Zmod = Zmod(mod(a.val + b.val, typevar(Z)))
```

## Implementation

The obvious idea of using a global `Dict` suffers from access time overhead.
We make `typevar` a generated function to levearge this access.

[gha-img]: https://github.com/KlausC/TypeVars.jl/workflows/CI/badge.svg
[gha-url]: https://github.com/KlausC/TypeVars.jl/actions?query=workflow%3ACI

[codecov-img]: https://codecov.io/gh/KlausC/TypeVars.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/KlausC/TypeVars.jl
