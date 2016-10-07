include("func_helper.jl")
include("program_counter.jl")
function execution(inst, labels,flag)
  count_jump = 0
  count_call = 0
   while true
    i = pc.base_address*256 + pc.offset_address + 1
    operand1 = inst[i].operand1
    operand2 = inst[i].operand2
    operation = inst[i].op_code

    #Register Bank Selection
    if operation =="REGBANK"
      count_jump = 0
      if !((operand1 == "A") || (operand1 == "B"))
        flag.REGBANK = !flag.REGBANK
      end
      pc.pc_increase()
	elseif operation == "HWBUILD"
	  HWBUILD(operand1, BankA, BankB, flag)
	  pc.pc_increase()
    #Jump
    elseif operation == "JUMP"
      count_jump = count_jump + 1
      if operand2 != ""
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
        return
	    end
    elseif operation == "JUMP@"
      count_jump = coutn_jump + 1
      i = jump2(operand1, operand2, BankA, BankB, flag, labels)
    elseif operation == "CALL"
      j = i
      count_jump = 0
      count_call += 1
      if opernad2 != ""
        if operand1 == "Z"
          if flag.Z != NaN
            i = call1(opernad2, labels)
          end
        elseif operand1 == "NZ"
          if flag.Z == NaN
            i = call1(operand2, labels)
          end
        elseif operand1 == "C"
          if flag.C != NaN
            i = call1(operand2, labels)
          end
        elseif operand1 == "NC"
          if flag.C == NaN
            i = call1(operand2, labels)
          end
        end
      else
        i = call1(operand1, labels)
        i = i + 1
      end

      if i == -1
        println("Label not found...")
        println("returning to previous instrucion")
        i = j
      else
        pc.push()
	    end
    elseif operation == "RETURN"
      count_call -= 1
      i = pc.pop()
    #Version Control
    else
      count_jump = 0
      #Register Loading
      if operation == "LOAD"
        load(operand1, operand2, BankA, BankB, flag)
      elseif operation == "star"
        star(operand1, operand2, Bank_a, Bank_b, flag)
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
        println(flag)
        addcy(operand1, operand2, BankA, BankB, flag)
        println(flag)
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
      pc.pc_increase()
    end

  	if count_jump >= 10
  	  println("Maximum number of jump instruction exceeded")
  	  println("Prese enter to return to main.")
  	  readline()
  	  return
  	end
    if count_call >= 30
      println("Maximum number of call instruction exceeded")
      println("Aborting all instructions")
      println("Press enter to return to main")
      readline()
    end
  end
end
