module reg
  type bank
    s0 :: UInt8
    s1 :: UInt8
    s2 :: UInt8
    s3 :: UInt8
    s4 :: UInt8
    s5 :: UInt8
    s6 :: UInt8
    s7 :: UInt8
    s8 :: UInt8
    s9 :: UInt8
    sA :: UInt8
    sB :: UInt8
    sC :: UInt8
    sD :: UInt8
    sE :: UInt8
    sF :: UInt8
  end
  type flags
    Z :: Int
    C :: Int
    IE :: Int
    REGBANK :: Char
  end
end
