f=open("line.txt")
length_of_line=length(readlines(f))
f=open("line.txt")
code_arr=Array{String}(0)
for i = 1:length_of_line
  push!(code_arr,readline(f))
end
