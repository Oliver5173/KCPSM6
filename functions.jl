include("func_helper.jl")

function execution(inst, labels,flag)
  i = 1
  count_jump = 0
   while true
    operand1 = inst[i].operand1
    operand2 = inst[i].operand2
    operation = inst[i].op_code
  #Register Bank Selection
    if operation =="REGBANK"
      count_jump = 0
      if !((flag && operand1 == "A") || (!flag && operand1 == "B"))
        flag.REGBANK = !flag.REGBANK
      end
  #Jump
    elseif operation == "JUMP"
      count_jump = count_jump + 1

      if opernad2 != ""
          if operand1 == "Z"
            if flag.Z != NaN
              i = jump(opernad2, labels)
            end
          elseif operand1 == "NZ"
            if flag.Z == NaN
              i = jump(operand2, labels)
            end
          elseif operand1 == "C"
            if flag.C != NaN
              i = jump(operand2, labels)
            end
          elseif operand1 == "NC"
            if flag.C == NaN
              i = jump(operand2, labels)
            end
          end
      else
          i = jump(operand1, labels)
      end

      if i == -1
        println("Label not found...")
        println("Exit in 5 second")
        sleep(4)
        exit()
    elseif operatoin == "JUMP@"
      count_jump = coutn_jump + 1
      i = jump2(operand1, operand2, BankA, BankB, flag, labels)

    elseif operation == "CALL"
      count_jump = 0
      if opernad2 != ""
        if operand1 == "Z"
          if flag.Z != NaN
            i = call(opernad2, labels)
          end
        elseif operand1 == "NZ"
          if flag.Z == NaN
            i = call(operand2, labels)
          end
        elseif operand1 == "C"
          if flag.C != NaN
            i = call(operand2, labels)
          end
        elseif operand1 == "NC"
          if flag.C == NaN
            i = call(operand2, labels)
          end
        end
      else
        i = call(operand1, labels)
      end

      if i == -1
        println("Label not found...")
        println("Exit in 5 second")
        sleep(4)
        exit()
  #Version Control
    else
      count_jump = 0
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
      i = i + 1
  end
end
