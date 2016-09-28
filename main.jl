include("reg.jl")
include("program_counter.jl")

import reg,pc

#define banks and cpu flags
BankA = reg.bank(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
BankB = reg.bank(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
Bank_main = reg.bank(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
#flags(Z::Int,C::Int,IE::Int,REGBANK::Char)
flag = pc.flags(0,0,0,'A')

#opreation here
if flag.REGBANK == 'A'
	Bank_main = BankA
else
	Bank_main = BankB
end