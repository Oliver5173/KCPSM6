include("func_helper.jl")

function execution(inst, labels,flag)
  while i = 1:length(inst)
    operand1 = inst[i].operand1
    operand2 = inst[i].operand2
    operation = inst[i].op_code
  #Register Bank Selection
    if operation =="REGBANK"
      if !((flag && operand1 == "A") || (!flag && operand1 == "B"))
        flag = !flag

  #Jump
    elseif operation == "JUMP"
      jump(operand1, operand2, BankA, BankB, flag)

  #Version Control
    elseif operation == "HWBUILD"
      hwbuild(operand1, operand2, BankA, BankB, flag)

  #Register Loading
    elseif operation == "LOAD"
      load(operand1, operand2, BankA, BankB, flag)
    elseif operation == "star"
      continue

  #Logical
    elseif operation == "AND"
      and(operand1, operand2, BankA, BankB, flag)
    elseif operation == "OR"
      or(operand1, operand2, BankA, BankB, flag)
    elseif operation == "XOR"
      xor(operand1, operand2, BankA, BankB, flag)

  #Arithmetic
    elseif operation == "ADD"
      add(operand1, operand2, BankA, BankB, flag)
    elseif operation == "ADDCY"
      addcy(operand1, operand2, BankA, BankB, flag)
    elseif operation == "SUB"
      sub(operand1, operand2, BankA, BankB, flag)
    elseif operation == "SUBCY"
      subcy(operand1, operand2, BankA, BankB, flag)

  #Test and Compare
    elseif operation == "TEST"
      test(operand1, operand2, BankA, BankB, flag)
    elseif operation == "TESTCY"
      testcy(operand1, operand2, BankA, BankB, flag)
    elseif operation == "COMPARE"
      compare(operand1, operand2, BankA, BankB, flag)
    elseif operation == "CMPOARECY"
      comparecy(operand1, operand2, BankA, BankB, flag)

  #Shift and Rotate
    elseif operation == "SL0"
      sl0(operand1, BankA, BankB, flag)
    elseif operation == "SL1"
      sl1(operand1, BankA, BankB, flag)
    elseif operation == "SLX"
      slx(operand1, BankA, BankB, flag)
    elseif operation == "SLA"
      sla(operand1, BankA, BankB, flag)
    elseif operation == "RL"
      rl(operand1, BankA, BankB, flag)
    elseif operation == "SR0"
      sr0(operand1, BankA, BankB, flag)
    elseif operation == "SR1"
      sr1(operand1, BankA, BankB, flag)
    elseif operation == "SRX"
      srx(operand1, BankA, BankB, flag)
    elseif operation == "SLA"
      sla(operand1, BankA, BankB, flag)
    elseif operation == "RR"
      rr(operand1, BankA, BankB, flag)

  #Input and Output
    elseif operation == "INPUT"
      input(operand1, operand2, BankA, BankB, flag)
    elseif operation == "OUTPUT"
      output(operand1, operand2, BankA, BankB, flag)
    elseif operation == "OUTPUTK"
      outputk(operand1, operand2, BankA, BankB, flag)

  #Scratch Pad Memory
    elseif operation == "STORE"
      store(operand1, operand2, BankA, BankB, flag, scratch)
    elseif operation == "FETCH"
      fetch(operand1, operand2, BankA, BankB, flag, scratch)
    end
  end
end
