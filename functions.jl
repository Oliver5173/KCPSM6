include("func_helper.jl")
while i = 1:length(operation)
  operand1 = opd1[i]
  operand2 = opd2[i]
  operation = op[i]
  if operation =="REGBANK"
    if using_A && operand1 == "A"
      continue
    elseif !using_A && operand1 == "B"
      continue
    else
      using_A = !using_A
      
  elseif operation == "LOAD"
    load(operand1, operand2, BankA, BankB, using_A)

  elseif operation == ""

end
