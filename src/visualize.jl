using Plots, SimpleDrawing

export life_run, life_movie

"""
`life_run(A)` runs the game of life starting with the matrix `A`. It is
visualized on the screen. It will run forever unless:
* there are no live cells remaining,
* the current state is the same as the previous state, or
* the current state is the same as the state two steps earlier.
If `life_run` halts, it returns the number of iterations.


Optional named arguments:
* `pause = 0.0`: number of extra seconds between frames
* `wrap = false`: determine if the board wraps (is toroidal)
* `counter=true`: show the step number below the image
* `max_steps`: maximum number of steps
"""
function life_run(A::Matrix{Int};
        pause=0.0,
        wrap::Bool=false,
        max_steps::Int=typemax(Int),
        counter::Bool=true
    )
    @assert _life_check(A) "Matrix may only contain 0s and 1s"
    step = 0
    back_1 = 0*A    # previous A
    back_2 = 0*A    # previous previous A

    while true
        p = my_spy(A)
        if counter
            plot!(xlabel=string(step))
        end
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

"""
`life_movie(A)` creates a GIF animation of the game of life.

Optional named arguments:
* `wrap = false`: determine if the board wraps (is toroidal)
* `max_steps`: maximum number of steps
"""
function life_movie(A::Matrix{Int};
        wrap::Bool=false,
        max_steps::Int=typemax(Int)
    )
    @assert _life_check(A) "Matrix may only contain 0s and 1s"
    step = 0
    back_1 = 0*A    # previous A
    back_2 = 0*A    # previous previous A



    G = @gif for k=1:max_steps
        print(".")
        p = my_spy(A)
        back_2 = back_1
        back_1 = A
        A = life_step(A,wrap)

        if A==back_1 || A==back_2 || sum(A) == 0
            break
        end
        if step >= max_steps
            break
        end
        step += 1

    end
    println()
    return G
end
