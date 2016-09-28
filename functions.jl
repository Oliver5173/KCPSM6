include("func_helper.jl")


operand1 = command["operand1"]
operand2 =

for operation in command["operation"]
  if operand1 == "s0"
    Bank_main.s0 = func_return(operation, operand1, operand2)
  else if operand1 == "s1"
    Bank_main.s1 = func_return(operation, operand1, operand2)
  else if operand1 == "s2"
    Bank_main.s2 = func_return(operation, operand1, operand2)
  else if operand1 == "s3"
    Bank_main.s3 = func_return(operation, operand1, operand2)
  else if operand1 == "s4"
    Bank_main.s4 = func_return(operation, operand1, operand2)
  else if operand1 == "s5"
    Bank_main.s5 = func_return(operation, operand1, operand2)
  else if operand1 == "s6"
    Bank_main.s6 = func_return(operation, operand1, operand2)
  else if operand1 == "s7"
    Bank_main.s7 = func_return(operation, operand1, operand2)
  else if operand1 == "s8"
    Bank_main.s8 = func_return(operation, operand1, operand2)
  else if operand1 == "s9"
    Bank_main.s9 = func_return(operation, operand1, operand2)
  else if operand1 == "sA"
    Bank_main.sA = func_return(operation, operand1, operand2)
  else if operand1 == "sB"
    Bank_main.sB = func_return(operation, operand1, operand2)
  else if operand1 == "sC"
    Bank_main.sC = func_return(operation, operand1, operand2)
  else if operand1 == "sD"
    Bank_main.sD = func_return(operation, operand1, operand2)
  else if operand1 == "sE"
    Bank_main.sE = func_return(operation, operand1, operand2)
  else if operand1 == "sF"
    Bank_main.sF = func_return(operation, operand1, operand2)
  end
end
