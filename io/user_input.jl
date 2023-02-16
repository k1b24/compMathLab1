function input_matrix()
    print("Вы хотите ввести входные данные из файла (1) или руками(2)?\n")
    s = readline()
    try
        user_ans = parse(Int8, s)
        if user_ans < 1 || user_ans > 2
            print("Введите либо 1 либо 2\n")
            return input_matrix()
        else
            if user_ans == 1

                return input_data_from_file()
            else
                return input_data_from_system_in()
            end
        end
    catch
        print("Введите либо 1 либо 2\n")
        return input_matrix()
    end
end


function input_data_from_file()
    print("Введите путь до файла, чтобы вернуться введите back\n")
    filename = readline()
    if filename == "back"
        return input_data()
    else
        if (filename[begin] != '/')
            filename = pwd() * "/" * filename;
        end
        lines = []
        try
            f = open(filename, "r")
            while ! eof(f)
                push!(lines, readline(f))
            end
            lines = parse_lines_into_data(lines)
            if typeof(lines) == Bool
                return input_matrix()
            else
                n = length(lines[1]) - 1
                matrix = []
                free_members = fill(0.0, (1, n))
                for i in 1:n
                    push!(matrix, lines[i][1:n])
                end
                for i in 1:n
                    free_members[i] = lines[i][n+1]
                end
                return matrix, free_members
            end
        catch e
            print("Такого файла не существует, повторите попытку ввода\n")
            return input_data_from_file()
        end
        close(f)
    end
end


function input_data_from_system_in()
    print("Введите размерность матрицы 0 < n <= 20, чтобы вернуться введите back\n")
    s = readline()
    if s == "back"
        return input_matrix()
    end
    try
        n = parse(Int8, s)
        if (n < 1 || n > 20)
            print("Введите число от 1 до 20!\n")
            return input_data_from_system_in()
        end
        print("Введите матрицу: \n");
        lines = []
        for i in 1:n
            line = readline()
            if size(split(line))[1] == n
                push!(lines, line)
            else
                print("Неверное количество элементов\n")
                return input_data_from_system_in()
            end
        end
        return parse_lines_into_data(lines), input_free_members(length(lines))
    catch
        print("Введите число от 1 до 20!\n")
        return input_data_from_system_in()
    end
end

function parse_lines_into_data(lines)
    nums = []
    try
        for line in lines
            push!(nums, [parse(Float64, ss) for ss in split(line)])
        end
        return nums
    catch
        print("Ошибка при чтении из файла\n")
        return false
    end
end

function input_free_members(n)
    print("Введите список свободных членов размера ")
    print(n)
    print("\n")
    line = split(readline())
    if size(line)[1] != n
        print("Неверное количество свободных членов\n")
        return input_free_members(n)
    end
    try
        nums = [parse(Float64, ss) for ss in line]
        return nums
    catch
        print("Ошибка ввода\n")
        return input_free_members(n)
    end
end
