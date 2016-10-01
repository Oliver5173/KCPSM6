include("func_helper.jl")

function execution(inst, labels,reg_bank)
  while i = 1:length(inst)
    operand1 = inst[i].operand1
    operand2 = inst[i].operand2
    operation = inst[i].op_code
  #Register Bank Selection
    if operation =="REGBANK"
      if !((reg_bank && operand1 == "A") || (!reg_bank && operand1 == "B"))
        reg_bank = !reg_bank

  #Jump
    elseif operation == "JUMP"
      jump(operand1, operand2, BankA, BankB, reg_bank)

  #Version Control
    elseif operation == "HWBUILD"
      hwbuild(operand1, operand2, BankA, BankB, reg_bank)

  #Register Loading
    elseif operation == "LOAD"
      load(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "star"
      continue

  #Logical
    elseif operation == "AND"
      and(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "OR"
      or(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "XOR"
      xor(operand1, operand2, BankA, BankB, reg_bank)

  #Arithmetic
    elseif operation == "ADD"
      add(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "ADDCY"
      addcy(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "SUB"
      sub(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "SUBCY"
      subcy(operand1, operand2, BankA, BankB, reg_bank)

  #Test and Compare
    elseif operation == "TEST"
      test(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "TESTCY"
      testcy(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "COMPARE"
      compare(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "CMPOARECY"
      comparecy(operand1, operand2, BankA, BankB, reg_bank)

  #Shift and Rotate
    elseif operation == "SL0"
      sl0(operand1, BankA, BankB, reg_bank)
    elseif operation == "SL1"
      sl1(operand1, BankA, BankB, reg_bank)
    elseif operation == "SLX"
      slx(operand1, BankA, BankB, reg_bank)
    elseif operation == "SLA"
      sla(operand1, BankA, BankB, reg_bank)
    elseif operation == "RL"
      rl(operand1, BankA, BankB, reg_bank)
    elseif operation == "SR0"
      sr0(operand1, BankA, BankB, reg_bank)
    elseif operation == "SR1"
      sr1(operand1, BankA, BankB, reg_bank)
    elseif operation == "SRX"
      srx(operand1, BankA, BankB, reg_bank)
    elseif operation == "SLA"
      sla(operand1, BankA, BankB, reg_bank)
    elseif operation == "RR"
      rr(operand1, BankA, BankB, reg_bank)

  #Input and Output
    elseif operation == "INPUT"
      input(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "OUTPUT"
      output(operand1, operand2, BankA, BankB, reg_bank)
    elseif operation == "OUTPUTK"
      outputk(operand1, operand2, BankA, BankB, reg_bank)

  #Scratch Pad Memory
    elseif operation == "STORE"
      store(operand1, operand2, BankA, BankB, reg_bank, scratch)
    elseif operation == "FETCH"
      fetch(operand1, operand2, BankA, BankB, reg_bank)

    end
  end
end
