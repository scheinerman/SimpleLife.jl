module SimpleLife
export life_step

"""
`_validate(A,i,j)` checks if `i,j` is a valid pair of indices for `A`.
"""
function _validate(A::Matrix, i::Int, j::Int)::Bool
    r,c = size(A)
    if i<1 || i>r || j<1 || j>c
        return false
    end
    return true
end

"""
`_neighbor_count(A,i,j)` counts how many neighbors of entry `i,j`
of matrix `A` are nonzero.
"""
function _neighbor_count(A::Matrix{Int},i::Int,j::Int)
    r,c = size(A)
    count = 0
    for a=i-1:i+1
        for b=j-1:j+1
            if (a,b)==(i,j) || !_validate(A,a,b)
                continue
            end
            if A[a,b]!=0
                count += 1
            end
        end
    end
    return count
end

"""
`_new_entry(A,i,j)` computes the new entry in cell `i,j`
if the current state is given by matrix `A`.
"""
function _new_entry(A::Matrix{Int},i::Int,j::Int)
    nc = _neighbor_count(A,i,j)
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
`life_step(A)` gives the next generation after state `A`
in Conway's *Game of Life*.
"""
function life_step(A::Matrix{Int})
    r,c = size(A)
    B = zeros(Int,r,c)
    for i=1:r
        for j=1:c
            B[i,j] = _new_entry(A,i,j)
        end
    end
    return B
end



end  # module SimpleLife
