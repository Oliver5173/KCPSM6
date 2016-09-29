include("func_helper.jl")
while i = 1:length(operation)
  operand1 = a[i].operand1
  operand2 = a[i].operand2
  operation = a[i].op_code
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
