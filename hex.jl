c="01101101'b"
h=c[end-1:end]

  if(h=="'d")
    p=c[1:end-2]
    p=parse(p)
    output=hex(p)
  elseif (h=="'b")
    p=c[1:end-2]
    p=string("0b",p)
    output=parse(p)
    output=string(output)
    output=parse(output)
    output=hex(output)
  end
