module TypeVars

export typevar, settypevar

const TYPEVARS = IdDict()

function typevar_key(::Type{T}) where T
    T
end

"""
    settypevar(::Type{T}, obj)

Associate the object with the type. The actual key used is
`typevar_key(T)`, which defaults to identity.
"""
function settypevar(::Type{T}, obj) where T
    get!(TYPEVARS, typevar_key(T), obj)
end

"""
    typevar(::Type)

Return the type varable associated with the type. See also `settypevar`.
"""
@generated function typevar(::Type{T}) where T
    t = TYPEVARS[typevar_key(T)]
    :( $t )
end

end