using Plots, SimpleDrawing

export run_life

"""
`run_life(A)` runs the game of life starting with the matrix `A`. It is
visualized on the screen. It will run forever unless it reaches a state
that does not change.

Optional named arguments:
* `pause = 0.25`: number of seconds between frames
* `wrap = false`: determine if the board wraps (is toroidal)
"""
function run_life(A::Matrix{Int}; pause=0.25, wrap::Bool=false)
    step = 0
    while true
        my_spy(A)
        p = plot!(xlabel=string(step))
        display(p)
        sleep(pause)
        new_A = life_step(A,wrap)
        if A==new_A
            break
        end
        A = new_A
        step += 1
    end
end
