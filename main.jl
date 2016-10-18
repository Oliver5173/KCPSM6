include("read_assemble.jl")
include("support_functions.jl")
include("functions.jl")
import trans
#define banks and cpu flags
BankA = Array{UInt8}(16)
BankB = Array{UInt8}(16)
scratch = Array{UInt8}(256)
#initial BANKs
for i = 1:16
	BankA[i] = 0
	BankB[i] = 0
end

type flags
	Z :: Int
	C :: Int
	IE :: Int
	REGBANK :: Char
end

flag = flags(0,0,0,'A')

#print_brand()

if length(ARGS)  >= 1
	FILE_NAME = ARGS[1]
else
	print("Enter the file name : ")
	FILE_NAME = readline()
	file_length = length(FILE_NAME)
	FILE_NAME = FILE_NAME[1:file_length - 2]
end

#cheak file existance
if !isfile(FILE_NAME)
	println(FILE_NAME," DOES NOT EXIST\nProgram exit in 5s")
	sleep(4)
	exit()
end

#Reading Assembly Code

#loading file to code_arr
f = open(FILE_NAME)
length_of_line = length(readlines(f))
f = open(FILE_NAME)
code_arr = Array{Any}(0)
for i = 1:length_of_line
  push!(code_arr,readline(f))
end
close(f)
code_arr[length(code_arr)] *= "\r\n"
#Converting code

labels, instructions = trans.load_code(length(code_arr), code_arr)
#println("Code loaded ! ")
execution(instructions, labels, flag)
#=println("Enter esc to exit")
while true
	print("command > ")
	cmd = readline()
	cmd = cmd[1:length(cmd) - 2]
	if cmd == "esc"
		break
	end
	cmd_excution(cmd,code_arr,BankA,BankB,flag)
end

#end of the code, delete workspace
workspace()
sleep(1)
exit()
=#
