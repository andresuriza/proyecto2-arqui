def generar_mif(nombre_archivo, profundidad, ancho_datos, valores):
    with open(nombre_archivo, 'w') as archivo:
        archivo.write(f"WIDTH = {ancho_datos};\n")
        archivo.write(f"DEPTH = {profundidad};\n\n")
        archivo.write("ADDRESS_RADIX = UNS;\n")
        archivo.write("DATA_RADIX = HEX;\n\n")
        archivo.write("CONTENT BEGIN\n")
        
        for direccion, valor in enumerate(valores):
            # Convertir el valor binario a hexadecimal
            valor_hex = hex(int(valor, 2))[2:].upper().zfill(ancho_datos // 4)
            archivo.write(f"    {direccion} : {valor_hex};\n")
        
        # Rellenar el resto de la memoria con ceros
        archivo.write(f"    [{len(valores)}..{profundidad - 1}] : 0;\n")
        archivo.write("END;\n")
def rInstruction(opcode, code):
    if opcode == "0011":
        rs2 = str(format(0,'020b'))
    else:
        rs2 = str(format(int(code[3][1:]),'020b'))
    rd = str(format(int(code[1][1:]),'04b'))
    rs1 = str(format(int(code[2][1:]),'04b'))
    instBin = rs2 + rs1 + rd + opcode
    
    return instBin

def iInstruction(opcode, code):
    rd = str(format(int(code[1][1:]),'04b'))
    rs1 = str(format(int(code[2][1:]),'04b'))
    imm = str(format(int(code[3][1:]),'020b'))
    instBin = imm + rs1 + rd + opcode
    return instBin

def sInstruction(opcode, code, cleanCode):
    rd = str(format(0,'04b'))
    if opcode == '1010':
        rs1 = str(format(int(code[1][1:]), '04b'))
        rs2 = str(format(int(code[2][1:]), '04b'))
        imm = str(format(int(code[3][1:]), '016b'))
        instBin = imm + rs2 + rs1 + rd + opcode
        return instBin
    else:
        rs1 = str(format(int(code[1][1:]), '04b'))
        rs2 = str(format(int(code[2][1:]), '04b'))
        label = code[3]
        lines = [line.strip() for line in cleanCode.splitlines()]
        labels = [line for line in lines if line.endswith(':')]
        
        label_index = 0
        for index, line in enumerate(labels):
            if line == label + ":":
                label_index = index
                break
        for index, line in enumerate(lines):
            if line == label + ":":
                
                if label_index == 0:
                    imm = str(format(index,'016b'))
                else:
                    imm = str(format(index-label_index,'016b'))
                
                instBin = imm + rs2 + rs1 + rd + opcode
                return instBin

 

def uInstruction(opcode, code, cleanCode):
    if opcode == '1000':
        rd = str(format(int(code[1][1:]),'04b'))
        imm = str(format(int(code[2][1:]),'024b'))
        instBin = imm + rd + opcode
        return instBin
    else:
        rd = str(format(int(code[1][1:]),'04b'))
        label = code[2]
        lines = [line.strip() for line in cleanCode.splitlines()]
        labels = [line for line in lines if line.endswith(':')]
        
        label_index = 0
        for index, line in enumerate(labels):
            if line == label + ":":
                label_index = index
                break
        for index, line in enumerate(lines):
            if line == label + ":":
                
                if label_index == 0:
                    imm = str(format(index,'024b'))
                else:
                    imm = str(format(index-label_index,'024b'))
                
                instBin = imm + rd + opcode
                return instBin

def compilador(code):
    r = [['bsub','0000'],
        ['badd','0001'],
        ['bmul','0010'],
        ['bdiv','0011'],
        ['band','0100'],
        ['bsll', '0101'],
        ['bsrl','0110']]
    i = [['baddi','0111'],
        ['blb','1001']]
    s = [['bsw','1010'],
        ['bbne','1100'],
        ['bbge','1101']]
    u = [['bauipc','1000'],
        ['bjal','1011']]

    code = code.lower()
    cleanCode = code.lower()
    cleanCodeLines = [line for line in cleanCode.splitlines() if line.strip()]
    cleanCode = "\n".join(cleanCodeLines)
    code = code.replace(",", " ")
    temp = code.strip().split("\n")

    codeList = []
    resultados_binarios = []

    for line in temp:
        words = line.split()
        codeList.append(words)

    codeList = [sublist for sublist in codeList if sublist and sublist != ['']]
    for line in codeList:
        instruction = line[0]
        
        for inst in r:
            if instruction == inst[0]:
                resultado = rInstruction(inst[1], line)
                resultados_binarios.append(resultado)
                
        for inst in i:
            if instruction == inst[0]:
                resultado = iInstruction(inst[1], line)
                resultados_binarios.append(resultado)
                
        for inst in s:
            if instruction == inst[0]:
                resultado = sInstruction(inst[1], line, cleanCode)
                resultados_binarios.append(resultado)
                if inst[1] == '1100' or inst[1] == '1101':
                    nops = str(format(0, '032b'))
                    resultados_binarios.append(nops)
                    resultados_binarios.append(nops)
                
        for inst in u:
            if instruction == inst[0]:
                resultado = uInstruction(inst[1], line, cleanCode)
                resultados_binarios.append(resultado)

    return resultados_binarios

# Código de entrada
code = """
main:
	bLb R0, R13, #20
    	bLb R1, R14, #10
	bAuipc R2, #100
	bAuipc R3, #39700
	bAuipc R4, #0
	bAddi R10, R0, #0
calculate_sector:
	bBge R4, R1, continue_main
	bAddi R4, R4, #1
	bAuipc R13, #3
	bAnd R5, R4, R13
	bAuipc R13, #0
	bBne R5, R13, auxiliar
	bAdd R10, R10, R2
	bAuipc R14, #0
	bJal R14, calculate_sector

auxiliar:
	bAdd R10, R10, R3
	bJal R14, calculate_sector

continue_main:
	bAuipc R14, #0
    	bLb R9, R14, #20

	bSw R10, R9, #0

	bLb R11, R14, #16020

	bAuipc R12, #99

loop_100x2:
	bAuipc R12, #99

loop_matrices:
	bLb R0, R10, #0
	bLb R1, R10, #1
	bLb R2, R10, #400
	bLb R3, R10, #401

	bAuipc R9, #3

	bAuipc R8, #99
	bSub R8, R8, R12
	bAuipc R13, #3
	bAnd R7, R8, R13
	bAuipc R14, #2
	bSll R7, R7, R14
	bAuipc R13, #2
	bSrl R8, R8, R13
	bAuipc R5, #16
	bMul R6, R6, R5
	bAdd R8, R7, R6
	bAdd R11, R11, R8

	bSw R0, R11, #0

	bAuipc R13, #1
	bSll R4, R0, R13
	bAdd R4, R4, R1
	bDiv R4, R4, R9

	bSw R4, R11, #1

	bAuipc R14, #1
	bSll R5, R1, R14
	bAdd R5, R5, R0
	bDiv R5, R5, R9
	
	bSw R5, R11, #2
	bSw R1, R11, #3

	bAuipc R13, #1
	bSll R4, R0, R13
	bAdd R4, R4, R2
	bDiv R4, R4, R9
	bSw R4, R11, #396


	bLb R5, R11, #1


	bAuipc R14, #1
	bSll R6, R5, R14
	bAdd R6, R6, R1
	bDiv R6, R6, R9
	bSw R6, R11, #397

	bAuipc R13, #1
	bSll R7, R5, R13
	bAdd R7, R7, R5
	bDiv R7, R7, R9
	bSw R7, R11, #398

	bAuipc R14, #1
	bSll R4, R1, R14
	bAdd R4, R4, R3
	bDiv R4, R4, R9
	bSw R4, R11, #399

	bAuipc R13, #1
	bSll R5, R2, R13
	bAdd R5, R5, R0
	bDiv R5, R5, R9
	bSw R5, R11, #792

	bAuipc R14, #1
	bSll R6, R5, R14
	bAdd R6, R6, R2
	bDiv R6, R6, R9
	bSw R6, R11, #793

	bAuipc R13, #1
	bSll R7, R2, R13
	bAdd R7, R7, R5
	bDiv R7, R7, R9
	bSw R7, R11, #794

	bAuipc R14, #1
	bSll R4, R3, R14
	bAdd R4, R4, R1
	bDiv R4, R4, R9
	bSw R4, R11, #795

	bSw R2, R11, #1188

	bAuipc R13, #1
	bSll R4, R2, R13
	bAdd R4, R4, R3
	bDiv R4, R4, R9
	bSw R4, R11, #1189

	bAuipc R14, #1
	bSll R5, R3, R14
	bAdd R5, R5, R2
	bDiv R5, R5, R9
	bSw R5, R11, #1190

	bSw R3, R11, #1191

	bAddi R10, R10, #1
	bAuipc R13, #0

	bLb R11, R13, #16020

	bAuipc R13, #1
	bSub R12, R12, R13
	bAuipc R14, #0
	bBne R12, R14, loop_matrices

	bAdd R10, R10, #400
	bAdd R11, R11, #1584

	bAuipc R14, #0
	bLb R9,  R14, #16020


	bSw R11, R9, #0
	bAuipc R13, #1
	bSub R12, R12, R13
	bAuipc R14, #0
	bBne R12, R14, loop_100x2

"""

# Generar instrucciones
instrucciones_bin = compilador(code)

# Generar archivo .mif
generar_mif("Instrucciones.mif", 511, 32, instrucciones_bin)
