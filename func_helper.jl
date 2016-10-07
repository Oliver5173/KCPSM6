include("program_counter.jl")
# operand: should be two strings and two banks-array and a flag type(whole flag)

# Register Loading Functions
# -------------------------------------------------
# LOAD (bug fixed)
function load(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end

  #make change in register
  if (op2_type == String)
    source_index = parse("0x" * operand2[2:2]) + 1
    terminal_index= parse("0x" * operand1[2:2]) + 1
    main_bank[terminal_index] = main_bank[source_index]
    println("Loading value from ", operand2, " to ", operand1)
    println("\tValue of operand2 is ", main_bank[source_index])
  else
    println("Loading ", operand2, " to ", operand1)
    source_data = parse("0x"*operand2)
    terminal_index= parse("0x"*operand1[2:2]) + 1
    main_bank[terminal_index] = source_data
  end
end

#STAR (bug fixed)
function star(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end

  #make change in register
  if (op2_type == AbstractString)
    source_regester_index = parse("0x" * operand2[2:2]) + 1
    terminal_regester_index= parse("0x" * operand1[2:2]) + 1
    sub_bank[terminal_regester_index] = main_bank[source_regester_index]
    println("Staring value from ", operand2, " to ", operand1)
    println("\tValue of operand2 is ", main_bank[source_regester_index])
  else
    println("Staring ", operand2, " to ", operand1)
    source_data = parse("0x"*operand2)
    terminal_regester_index= parse("0x"*operand1[2:2]) + 1
    sub_bank[terminal_regester_index] = source_data
  end
end

#Logical Functions
#------------------------------------------------------
#AND (bug fixed)
function and(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = String
  end
  target_index = parse("0x" * operand1[2:2]) + 1
  println("Performing AND operation on ", operand1, " and ", operand2)

  println("\toperand1 has value ", main_bank[target_index])
  # perform AND operation

  if (op2_type == UInt8)
    source_data = parse("0x" * operand2)
    println("\toperand2 has value ", source_data)
    main_bank[target_index] = UInt8(main_bank[target_index]) & UInt8( source_data)
  else
    op2_index = parse("0x" * operand2[2:2]) + 1
    println("\toperand2 has value ", main_bank[op2_index])
    main_bank[target_index] = main_bank[target_index] & main_bank[op2_index]
  end
  println("\tresult saved in ", operand1, " with value ", main_bank[target_index])
  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  flag.C =0
end

#OR (bug fixed)
function or(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  target_index = parse("0x"*operand1[2:2]) + 1
  println("Performing OR operation on ", operand1, " and ", operand2)
  println("\toperand1 has value ", main_bank[target_index])
  # perform OR operation

  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    println("\toperand2 has value ", source_data)
    main_bank[target_index] = (main_bank[target_index] | source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    println("\toperand2 has value ", main_bank[op2_index])
    main_bank[target_index] = (main_bank[target_index] | main_bank[op2_index])
  end
  println("\tresult saved in ", operand1, " with value ", main_bank[target_index])
  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z = 0
  end
  flag.C =0
end

#XOR  (bug fixed)
function xor(operand1, operand2, bank_a, bank_b, flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end

  # perform XOR operation
  target_index = parse("0x"*operand1[2:2]) + 1
  println("Performing XOR operation on ", operand1, " and ", operand2)
  println("\toperand1 has value ", main_bank[target_index])
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    println("\toperand2 has value ", source_data)
    main_bank[target_index] = (main_bank[target_index] $ source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    println("\toperand2 has value ", main_bank[op2_index])
    main_bank[target_index] = (main_bank[target_index] $ main_bank[op2_index])
  end
  println("\tresult saved in ", operand1, " with value ", main_bank[target_index])
  #set zero flag
  if (main_bank[target_index] == 0)
    flag.Z = 1
  else
    flag.Z = 0
  end
  flag.C =0
end

#Arithmetic Functions
#----------------------------------------------------------------
# add (bug fixed)
function add(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing ADD operation on ", operand1, " and ", operand2)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp = UInt8(target_data) + UInt8(source_data)

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (temp < source_data && temp < target_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
end

#addcy (bug fixed)
function addcy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end

  #get target data
  println("Performing ADDCY operation on ", operand1, " and ", operand2)
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = UInt8(main_bank[target_index])
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = UInt8(main_bank[source_index])
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp = (target_data + source_data + flag.C)%256

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (temp < source_data && temp < target_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  println("\tresult saved in ", operand1, " with value ", temp)
  main_bank[target_index] = temp

end

#sub (bug fixed)
function sub(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end

  #get target data
  println("Performing SUB operation on ", operand1, " and ", operand2)
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp = ((target_data - source_data)+256)%256

  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (target_data< source_data)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
end

#subcy (bug fixed)
function subcy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing SUBCY operation on ", operand1, " and ", operand2)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp =target_data - source_data - flag.C

  #set zero flag
  if (temp == 0 && flag.Z == 1)
    flag.Z = 1
  else
    flag.Z =0
  end
  #set carry flag
  if (temp < 0)
    flag.C = 1
  else
    flag.C = 0
  end

  #store data
  temp =( temp + 256 )%256
  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
end

#Test and compare
#----------------------------------------------------------------
#test
function test(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing TEST operation on ", operand1, " and ", operand2)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  println("\toperand2 has value ", source_data)
  #do the operation
  temp = target_data & source_data
  println("\tresult is ", temp)
  println("\t modifying flags...")
  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
  println("\tZero flag is now ", flag.Z)
  #get number of 1s in binary "temp"
  count = 0
  while(temp != 0)
    temp = temp & (temp-1)
    count = count + 1
  end
  #set carry flag
  if (count%2 == 1)
    flag.C = 1
  else
    flag.C = 0
  end
  println("\tCarry flag is now ", flag.C)
end

#testcy
function testcy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing TESTCY operation on ", operand1, " and ", operand2)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperan2 has value ", source_data)
  temp = target_data & source_data
  println("\tresult is ", temp)
  println("\tmodifying flags...")
  #set zero flag
  if (temp == 0 && flag.Z == 1)
    flag.Z = 1
  else
    flag.Z =0
  end
  println("\tZero flag is now ", flag.Z)
  #get number of 1s in binary "temp"
  count = 0
  while(temp != 0)
    temp = temp & (temp-1)
    count = count + 1
  end
  #set carry flag
  if ( (count + flag.C)%2 == 1)
    flag.C = 1
  else
    flag.C = 0
  end
  println("\tCarry flag is now ", flag.C)
end

#compare
function compare(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing COMPARE operation on ", operand1 , " and ", operand2)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp = target_data - source_data
  println("\tresult is ", temp)
  println("\tmodifying flags...")
  #set zero flag
  if (temp == 0)
    flag.Z = 1
  end
  println("\tZero flag is now ", flag.Z)
  #set carry flag
  if (target_data< source_data)
    flag.C = 1
  end

  if ( target_data > source_data)
    flag.C= 0
    flag.Z =0
  end
  println("\tCarry flag is now ", flag.C)
  println("\tZero flag is now ", flag.Z)
end

#comparecy
function comparecy(operand1,operand2,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  #test operand overload
  if (operand2[1] != 's')
    op2_type = UInt8
  else
    op2_type = AbstractString
  end
  println("Performing COMPARECY oepration on ", operand1, " and ", operand2)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  println("\toperand2 has value ", source_data)
  temp = target_data - source_data -1
  println("\treesult is ", temp)
  println("\tmodifying flags...")

  #set zero flag
  if (temp == 0 && flag.Z == 1)
    flag.Z = 1
  end

  #set carry flag
  if (target_data< (source_data +1))
    flag.C = 1
  end

  if (target_data > (source_data + 1))
    flag.C =0
    flag.Z =0
  end
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#Shift and Rotate
#----------------------------------------------------------------
#sl0
function sl0(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SL0 operation on ", operand1)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)

  #set carry flag
  flag.C = Int((target_data & 0x80) >> 7)
  #operate shift
  temp = (target_data << 1 )
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#sl1
function sl1(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SL1 operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #set carry flag
  flag.C = Int((target_data & 0x80) >> 7)
  #operate shift
  temp = (target_data << 1 ) | 0x01
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#slx
function slx(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SLX operation on ", operand1)
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #set carry flag
  flag.C = Int((target_data & 0x80) >> 7)

  #get LSB
  LSB = Int( target_data & 0x01)
  #operate shift
  temp = (target_data << 1 )
  if (LSB == 1)
    temp = temp | 0x01
  else
    temp = temp & 0xF7
  end

  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#sla
function sla(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SLA operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #operate shift
  temp = target_data << 1


  if (flag.C == 1)
    temp = temp | 0x01
  else
    temp = temp & 0xF7
  end
  #set carry flag
  flag.C = Int((target_data & 0x80) >> 7)

  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#rl
function rl(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SL operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #operate shift
  temp = target_data << 1

  #set carry flag
  flag.C = Int((target_data & 0x80) >> 7)

  if (flag.C == 1)
    temp = temp | 0x01
  else
    temp = temp & 0xF7
  end
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#sr0
function sr0(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SR0 operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #set carry flag
  flag.C = Int((target_data & 0x01))
  #operate shift
  temp = (target_data >> 1 ) & 0x7F
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#sr1
function sr1(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SR1 operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #set carry flag
  flag.C = Int((target_data & 0x01))
  #operate shift
  temp = (target_data >> 1 ) | 0x80
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#srx
function srx(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SRX operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)
  #set carry flag
  flag.C = Int((target_data & 0x01))

  #get LSB
  MSB = Int( (target_data & 0x80) >> 7)
  #operate shift
  temp = (target_data >> 1 ) & 0x7F
  if (MSB == 1)
    temp = temp | 0x80
  else
    temp = temp & 0x7F
  end

  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end

  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#sra
function sra(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing SRA operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)

  #operate shift
  temp = target_data >> 1


  if (flag.C == 1)
    temp = temp | 0x80
  else
    temp = temp & 0x7F
  end

  #set carry flag
  flag.C = Int((target_data & 0x01))

  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end
  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#rr
function rr(operand1,bank_a,bank_b,flag)
  #register banks
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing RR operation on ", operand1)

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  println("\toperand1 has value ", target_data)

  #operate shift
  temp = (target_data >> 1 ) & 0x7F

  #set carry flag
  flag.C = Int((target_data & 0x01))

  if (flag.C == 1)
    temp = temp | 0x80
  else
    temp = temp & 0x7F
  end
  #set zero flag
  if (temp == 0 )
    flag.Z = 1
  else
    flag.Z =0
  end
  main_bank[target_index] = temp
  println("\tresult saved in ", operand1, " with value ", temp)
  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end

#Scratch Pad Memory
#----------------------------------------------------------------
# store

function store(operand1, operand2, BankA, BankB, flag, scratch)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing STORE operation")

  value_index = parse("0x"*operand1[2:2]) + 1
  value = main_bank[value_index]
  println("\toperand1 has value ", value)

  if length(operand2) == 2
    index = "0x" * operand2
    target_index = dec(parse(index)) + 1
  else
    target_index = parse("0x"*operand2[3:3]) + 1
  end
    scratch[target_index] = value
    println("\tresult saved in scratchpad at address", target_index, " with value ", value)
end

#fetch
function fetch(operand1, operand2, BankA, BankB, flag, scratch)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing FETCH operation on ", operand1, " and ", operand2)
  target_index = parse(operand1[2:2]) + 1
  println("\Tdestination index is ", target_index)
  if length(operand2) == 2
    indec = "0x" * operand2
    value_index = dec(parse(index)) + 1
  else
    value_index = parsse("0x"*operand2[3:3]) + 1
  end
  println("\ttarget value is ", scratch[value_index])
  main_bank[target_index] = scratch[value_index]
  println("\tsave ", scratch[value_index], " to ", operand1)
end

#Input and Output
#----------------------------------------------------------------
# input
function input(operand1,operand2,bank_a,bank_b,flag)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  target_index = parse("0x"*operand1[2:2]) + 1
  println("Input from keyboard")
  println("\t enter the value you want to save: ")
  value = readline()
  main_bank[target_index] = value[1: (length(value)-2)]
  println("\t", value, " saved to ", operand1)
end

#Output
function output(operand1,operand2,bank_a,bank_b,flag)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  target_index = parse("0x" * operand1[2:2])+1
  value = main_bank[target_index]
  println("Value at register ", operand1, " is ", value)
end


#jump
function jump(operand, labels)
  println("Performing Jump operation")
  for label in labels
    if label.label_name == operand
      return label.index
    end
  end
  return -1
end

function jump2(operand1, operand2, BankA, BankB, flag, labels)
  println("Performing JUMP@ operation")
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end

  first_index = parse("0x" * operand1[3:3]) + 1
  second_index = parse("0x" * operand2[2:2]) + 1
  first_value = main_bank[first_index]
  second_value = main_bank[second_index]
  pc.address_calculator(first_value, second_value)
end


function call1(operand, labels)
  for label in labels
    if label.label_name == operand
      return label.index
    end
  end
  return -1
end

function HWBUILD(operand1, bank_a, bank_b, flag)
  if (flag.REGBANK =='A')
    main_bank = bank_a
    sub_bank = bank_b
  else
    main_bank = bank_b
    sub_bank = bank_a
  end
  println("Performing HWBUILD on ", operand1)
  target_index = parse("0x" * operand1[2:2]) + 1
  main_bank[target_index] = 0x00
  println("\tsave ", HWBUILD, " to ", operand1)
  println("\tmodifying flags...")
  flag.C = 1
  flag.Z = 0

  println("\tZero flag is now ", flag.Z)
  println("\tCarry flag is now ", flag.C)
end
