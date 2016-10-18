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
  else
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
  if operand2[1] == 's'
    op2_type = true
  else
    op2_type = false
  end

  terminal_regester_index= parse("0x"*operand1[2:2]) + 1

  if op2_type
    source_regester_index = parse("0x" * operand2[2:2]) + 1
    source_data = main_bank[source_regester_index]
  else
    source_data = parse("0x"*operand2)
  end

  sub_bank[terminal_regester_index] = source_data
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
  # perform AND operation

  if (op2_type == UInt8)
    source_data = parse("0x" * operand2)
    main_bank[target_index] = UInt8(main_bank[target_index]) & UInt8( source_data)
  else
    op2_index = parse("0x" * operand2[2:2]) + 1
    main_bank[target_index] = main_bank[target_index] & main_bank[op2_index]
  end
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
  # perform OR operation

  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    main_bank[target_index] = (main_bank[target_index] | source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    main_bank[target_index] = (main_bank[target_index] | main_bank[op2_index])
  end
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
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)
    main_bank[target_index] = (main_bank[target_index] $ source_data)
  else
    op2_index = parse("0x"*operand2[2:2]) + 1
    main_bank[target_index] = (main_bank[target_index] $ main_bank[op2_index])
  end
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
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
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = UInt8(main_bank[target_index])
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = UInt8(main_bank[source_index])
  end
  #do the operation
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
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data & source_data
  #set zero flag
  if (temp == 0)
    flag.Z = 1
  else
    flag.Z =0
  end
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data & source_data
  #set zero flag
  if (temp == 0 && flag.Z == 1)
    flag.Z = 1
  else
    flag.Z =0
  end
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data - source_data
  #set zero flag
  if (temp == 0)
    flag.Z = 1
  end
  #set carry flag
  if (target_data< source_data)
    flag.C = 1
  end

  if ( target_data > source_data)
    flag.C= 0
    flag.Z =0
  end
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
  #get source data
  if (op2_type == UInt8)
    source_data = parse("0x"*operand2)

  else
    source_index = parse("0x"*operand2[2:2])+1
    source_data = main_bank[source_index]
  end
  #do the operation
  temp = target_data - source_data -1

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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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
  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]
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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

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

  #get target data
  target_index = parse("0x"*operand1[2:2]) + 1
  target_data = main_bank[target_index]

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

  value_index = parse("0x"*operand1[2:2]) + 1
  value = main_bank[value_index]

  if length(operand2) == 2
    index = "0x" * operand2
    target_index = dec(parse(index)) + 1
  else
    target_index = parse("0x"*operand2[3:3]) + 1
  end
    scratch[target_index] = value
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
  target_index = parse(operand1[2:2]) + 1
  if length(operand2) == 2
    indec = "0x" * operand2
    value_index = dec(parse(index)) + 1
  else
    value_index = parsse("0x"*operand2[3:3]) + 1
  end
  main_bank[target_index] = scratch[value_index]
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
  value = readline()
  main_bank[target_index] = value[1: (length(value)-2)]
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
  if operand1[1] == 's'
	port_index = parse("0x" * operand2[2:2])+1
	port = main_bank[port_index]
  else
	port = operand2
  end
  println(port, ' ', value)
end

function outputk(operand1,operand2)
  println(operand2, ' ', operand1)
end
#jump
function jump(operand, labels)
  for label in labels
    if label.label_name == operand
      return label.index
    end
  end
  return -1
end

function jump2(operand1, operand2, BankA, BankB, flag, labels)
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
  target_index = parse("0x" * operand1[2:2]) + 1
  main_bank[target_index] = 0x00
  flag.C = 1
  flag.Z = 0

end
