function solve(matrix, free_members)
    n = size(matrix[1])[1]
    x = fill(0.0, (1,n))
    for i in 1:n-1
        matrix, free_members = replace_lines(matrix, free_members, n, i)
        if (matrix[i][i] == 0)
            return nothing, nothing
        end
        for k in i+1:n
            c = matrix[k][i] / matrix[i][i]
            matrix[k][i] = 0
            for j in i+1:n
                matrix[k][j] = matrix[k][j] - c * matrix[i][j]
            end
            free_members[k] = free_members[k] - c * free_members[i]
        end
    end
    for i in n:-1:1
        s = 0
        for j in i+1:n
            s = s + matrix[i][j] * x[j]
        end
        x[i] = (free_members[i] - s) / matrix[i][i]
    end
    return x, matrix
end

function replace_lines(matrix, free_members, n, i)
    l = i
    for m in i+1:n
        if abs(matrix[m][i]) > abs(matrix[l][i])
            l = m
        end
    end
    if l != i
        for j in i:n
            buf = matrix[i][j]
            matrix[i][j] = matrix[l][j]
            matrix[l][j] = buf
        end
        buf = free_members[i]
        free_members[i] = free_members[l]
        free_members[l] = buf
    end
    return matrix, free_members
end

function count_discrepancies(matrix, free_members, xs)
    counter = 1
    rs = fill(0.0, (1,length(free_members)))
    for line in matrix
        sum = 0
        for i in 1:length(line)
            sum = sum + line[i] * xs[i]
        end
        rs[counter] = free_members[counter] - sum
        counter = counter + 1
    end
    return rs
end
