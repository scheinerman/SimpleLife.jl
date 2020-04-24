module SimpleLife
export life_step, random_life

"""
`_get(A,i,j,wrap=fasle)` returns `A[i,j]` or `0` if subscripts are out of bounds.
With `wrap==true` then the indices are taken modulo the number of rows/columns
as appropriate.
"""
function _get(A::Matrix{T}, i::Int, j::Int, wrap::Bool=false)::T where T<:Number
    r,c = size(A)
    if (1<=i<=r) && (1<=j<=c)
        return A[i,j]
    end

    if !wrap
        return zero(T)
    end

    i = mod(i,r)
    j = mod(j,c)
    if i==0
        i=r
    end
    if j==0
        j=c
    end
    return A[i,j]
end


"""
`_neighbor_count(A,i,j,wrap=false)` counts how many neighbors of entry `i,j`
of matrix `A` are nonzero.
"""
function _neighbor_count(A::Matrix{Int},i::Int,j::Int,wrap::Bool=false)::Int
    return sum(_get(A,p,q,wrap)!=0 for p=i-1:i+1 for q=j-1:j+1 if (p,q) != (i,j))
end

"""
`_new_entry(A,i,j)` computes the new entry in cell `i,j`
if the current state is given by matrix `A`.
"""
function _new_entry(A::Matrix{Int},i::Int,j::Int,wrap::Bool=false)
    nc = _neighbor_count(A,i,j,wrap)
    if A[i,j]==0
        if nc==3
            return 1
        else
            return 0
        end
    end
    # so A[i,j] is 1
    if nc==2 || nc==3
        return 1
    else
        return 0
    end
end

"""
`life_step(A,wrap=false)` gives the next generation after state `A`
in Conway's *Game of Life*. With `wrap==true` treats the board toroidally.
"""
function life_step(A::Matrix{Int},wrap::Bool=false)::Matrix{Int}
    r,c = size(A)
    B = zeros(Int,r,c)
    for i=1:r
        for j=1:c
            B[i,j] = _new_entry(A,i,j,wrap)
        end
    end
    return B
end

"""
`random_life(r,c)` creates a random `r`-by-`c` instance of a life board.

`random_life(n)` is equivalent to `random_life(n,n)`.
"""
function random_life(r::Int, c::Int)
    return rand(0:1,r,c)
end

random_life(n::Int) = random_life(n,n)

include("visualize.jl")

end  # module SimpleLife
