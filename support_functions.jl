function output_reg(banka,bankb,flags)
  println("Z = ",flags.Z,"  C = ",flags.C,"  IE = ", flags.IE,"  REGBANK = ", flags.REGBANK)
  println("BankA: ")
  for j = 1:8
    print("s",uppercase(hex(j-1))," = 0x",uppercase(hex(banka[j])),"  ")
  end
  println()
  for j = 1:8
    print("s",uppercase(hex(j+7))," = 0x",uppercase(hex(banka[j+8])),"  ")
  end
  println()
  println("BankB: ")
  for j = 1:8
    print("s",uppercase(hex(j-1))," = 0x",uppercase(hex(bankb[j])),"  ")
  end
  println()
  for j = 1:8
    print("s",uppercase(hex(j+7))," = 0x",uppercase(hex(bankb[j+8])),"  ")
  end
  println()
end

function print_brand()
  println("  _  __ _____  _____    _____  __  __    __  | ")
  println(" | |/ // ____||  __ \\  / ____||  \\/  |  / /  | Welcome to")
  println(" | ' /| |     | |__) || (___  | \\  / | / /_  |    KCPSM6")
  println(" |  < | |     |  ___/  \\___ \\ | |\\/| || '_ \\ | Commands: ")
  println(" | . \\| |____ | |      ____) || |  | || (_) || r : shows registers value")
  println(" |_|\\_\\\\_____||_|     |_____/ |_|  |_| \\___/ | d : shows code ie.d[i] or d[i:j]")
  println("                                             |")
end

function cmd_excution(cmd,code_arr,bank,flag)
  if length(cmd) == 0
    return
  end
  if cmd == "r"
    output_reg(bank,flag)
    return
  elseif cmd[1] == 'd'
      if length(cmd) == 1
        num = 1
        for i in code_arr
          print(num,":\t",i)
          num += 1
        end
        return
      elseif cmd[2] == '[' && cmd[length(cmd)] == ']'
        if length(cmd) <= 3
          println("command does not exist")
          return
        end
        cmd = cmd[3:length(cmd) - 1]
        if findfirst(cmd,':') == 0
          if length(code_arr) < parse(cmd)
            println("Only has ",length(code_arr)," line(s)")
            return
          end
          print(parse(cmd),":\t",code_arr[parse(cmd)])
        else
          code_line = split(cmd,':')
          for i = parse(code_line[1]) : parse(code_line[2])
            print(i,":\t",code_arr[i])
          end
        end
      end
    else
        println("command does not exist")
    end
end
