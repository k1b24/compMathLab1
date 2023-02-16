using Printf
using DelimitedFiles


function print_x_vector(x)
    print("\nВектор неизвестных X:\n")
    output = []
    push!(output, ["x" * string(i) * ":" for i in 1:length(x)])
    push!(output, [round(elem, digits=3) for elem in x])
    writedlm(stdout, output)
end

function print_discrepancies_vector(rs)
    print("\nВектор невязок r:\n")
    output = []
    push!(output, ["r" * string(i) * ":" for i in 1:length(rs)])
    push!(output, [round(elem, digits=3) for elem in rs])
    writedlm(stdout, output)
end

function print_matrix(matrix)
    print("\nМатрица: " * "\n")
    writedlm(stdout, [[round(num, digits = 3) for num in elem] for elem in matrix])
end

function print_error()
    print("\nПри решении произошло деление на 0!\n")
end
