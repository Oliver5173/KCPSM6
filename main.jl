include("program_counter.jl")
import pc
#define banks and cpu flags
println("")
BankA = Array{UInt8}(16)
BankB = Array{UInt8}(16)

type flags
	Z :: Int
	C :: Int
	IE :: Int
	REGBANK :: Bool
end

flag = flags(0,0,0,true)

println("-----------KCPSM6 simulated-----------")

const FILE_NAME = "test.asm"

#cheak file existance 
if !isfile(FILE_NAME)
	println(FILE_NAME," DOES NOT EXIST\nProgram exit in 5s")
	sleep(4)
	exit()
end

println("Reading Assembly Code ... ...")

#loading file to code_arr
f = open(FILE_NAME)
length_of_line = length(readlines(f))
f = open(FILE_NAME)
code_arr = Array{String}(0)
for i = 1:length_of_line
  push!(code_arr,readline(f))
end
close(f)
