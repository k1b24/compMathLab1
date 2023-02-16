include("./io/user_input.jl")
include("./maths/gauss_solver.jl")
include("./io/output.jl")

function main()
    matrix, free_members = input_matrix()
    old_matrix = deepcopy(matrix)
    old_free_members = deepcopy(free_members)
    x, triangle_matrix = solve(matrix, free_members)
    if x == nothing && triangle_matrix == nothing
        print_error()
    else
        rs = count_discrepancies(old_matrix, old_free_members, x)
        print_matrix(triangle_matrix)
        print_x_vector(x)
        print_discrepancies_vector(rs)
    end
end

main()