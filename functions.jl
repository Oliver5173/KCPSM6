include("func_helper.jl")
while i = 1:length(operation)
  operand1 = a[i].operand1
  operand2 = a[i].operand2
  operation = a[i].op_code
#Register Bank Selection
  if operation =="REGBANK"
    if !((using_A && operand1 == "A") || (!using_A && operand1 == "B"))
      using_A = !using_A

#Jump
  elseif operation == "JUMP"
    jump(operand1, operand2, BankA, BankB, using_A)

#Version Control
  elseif operation == "HWBUILD"
    hwbuild(operand1, operand2, BankA, BankB, using_A)

#Register Loading
  elseif operation == "LOAD"
    load(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "star"
    continue

#Logical
  elseif operation == "AND"
    and(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "OR"
    or(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "XOR"
    xor(operand1, operand2, BankA, BankB, using_A)

#Arithmetic
  elseif operation == "ADD"
    add(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "ADDCY"
    addcy(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "SUB"
    sub(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "SUBCY"
    subcy(operand1, operand2, BankA, BankB, using_A)

#Test and Compare
  elseif operation == "TEST"
    test(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "TESTCY"
    testcy(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "COMPARE"
    compare(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "CMPOARECY"
    comparecy(operand1, operand2, BankA, BankB, using_A)

#Shift and Rotate
  elseif operation == "SL0"
    sl0(operand1, BankA, BankB, using_A)
  elseif operation == "SL1"
    sl1(operand1, BankA, BankB, using_A)
  elseif operation == "SLX"
    slx(operand1, BankA, BankB, using_A)
  elseif operation == "SLA"
    sla(operand1, BankA, BankB, using_A)
  elseif operation == "RL"
    rl(operand1, BankA, BankB, using_A)
  elseif operation == "SR0"
    sr0(operand1, BankA, BankB, using_A)
  elseif operation == "SR1"
    sr1(operand1, BankA, BankB, using_A)
  elseif operation == "SRX"
    srx(operand1, BankA, BankB, using_A)
  elseif operation == "SLA"
    sla(operand1, BankA, BankB, using_A)
  elseif operation == "RR"
    rr(operand1, BankA, BankB, using_A)

#Input and Output
  elseif operation == "INPUT"
    input(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "OUTPUT"
    output(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "OUTPUTK"
    outputk(operand1, operand2, BankA, BankB, using_A)
    
#Scratch Pad Memory
  elseif operation == "STORE"
    store(operand1, operand2, BankA, BankB, using_A)
  elseif operation == "FETCH"
    fetch(operand1, operand2, BankA, BankB, using_A)

  end
end
