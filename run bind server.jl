import PlutoBindServer

port = if length(ARGS) == 1
    parse(Int64, ARGS[1])
else
    3456
end

@show pwd() readdir()

start_dir = "."

notebookfiles = let
    jlfiles = vcat(map(walkdir(start_dir)) do (root, dirs, files)
        map(
            filter(files) do file
                occursin(".jl", file)
            end
            ) do file
            joinpath(root, file)
        end
    end...)
    filter(jlfiles) do f
        !occursin(".julia", f) &&
        readline(f) == "### A Pluto.jl notebook ###"
    end
end

@show notebookfiles

PlutoBindServer.run_paths(notebookfiles; port=port, host="0.0.0.0")