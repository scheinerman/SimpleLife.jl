using Plots, SimpleDrawing

export run_life

"""
`run_life(A)` runs the game of life starting with the matrix `A`. It is
visualized on the screen. It will run forever unless:
* there are no live cells remaining,
* the current state is the same as the previous state, or
* the current state is the same as the state two steps earlier.
If `run_life` halts, it returns the number of iterations.


Optional named arguments:
* `pause = 0.0`: number of extra seconds between frames
* `wrap = false`: determine if the board wraps (is toroidal)
* `max_steps`: maximum number of steps
"""
function run_life(A::Matrix{Int};
        pause=0.0, wrap::Bool=false, max_steps=typemax(Int))
    @assert _life_check(A) "Matrix may only contain 0s and 1s"
    step = 0
    back_1 = 0*A    # previous A
    back_2 = 0*A    # previous previous A

    while true
        my_spy(A)
        p = plot!(xlabel=string(step))
        display(p)
        sleep(pause)

        back_2 = back_1
        back_1 = A
        A = life_step(A,wrap)

        if A==back_1 || A==back_2 || sum(A) == 0
            return step
        end
        if step >= max_steps
            return step
        end
        step += 1

    end
end
