using Test
using SimpleLife

A = zeros(Int, 5, 5)
@test life_step(A) == A

B = ones(Int,5,5)
@test sum(life_step(B)) == 4
