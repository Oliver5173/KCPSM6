LOAD s0, 02
SR1 s0
OUTPUT s0, 00
SR1 s1
OUTPUT s1, 00
LOAD s3, 00
SUB s3, 01
OUTPUT s3, 00
OUTPUT s3, (s3)
SRX s3
OUTPUT s3, 00
SRA s3
OUTPUT s3, 00
death: JUMP death
