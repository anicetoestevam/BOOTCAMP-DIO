Aceito sugestões de correção ou novas formas de fazer
As questões do desafio "Criando um Sistema Bancário com Python" eram:

                             <- DEPÓSITO -> 
"Deve ser possível depositar valores positivos para a minha
conta bancária A v 1 do projeto trabalha apenas com 1 usuário,
dessa forma não precisamos nos preocupar em identificar qual
é o número da agência e conta bancária Todos os depósitos
devem ser armazenados em uma variável e exibidos na
operação de extrato."
                             <- SAQUE -> 
"O sistema deve permitir realizar 3 saques diários com limite
máximo de R 500 00 por saque Caso o usuário não tenha
saldo em conta, o sistema deve exibir uma mensagem
informando que não será possível sacar o dinheiro por falta de
saldo Todos os saques devem ser armazenados em uma
variável e exibidos na operação de extrato."
                             <- EXTRATO -> 
"Essa operação deve listar todos os depósitos e saques
realizados na conta No fim da listagem deve ser exibido o
saldo atual da conta Se o extrato estiver em branco, exibir a
mensagem Não foram realizadas movimentações. 
Os valores devem ser exibidos utilizando o formato R xxx xx,
exemplo
1500.45 R$ 1500.45
                             <- RESOLUÇÃO EM PYTHON -> 
menu = """

[D] DEPÓSITO
[S] SAQUE
[E] EXTRATO
[F] FINALIZAR

"""
num_deposito = 0
num_saque_inicial = 0
num_saque_final = 3
deposito = 0
saque = []
extrato = []
saldo = 0

def realizar_deposito(valor):
    global saldo, deposito
    if valor <= 0:
        print("O valor do depósito deve ser positivo.")
        return
    else:
        saldo += valor
        deposito += valor
        extrato.append(valor)
        print(f"Depósito de R$ {valor:.2f} foi realizado com sucesso.")

def realizar_saque(valor):
    global saldo, saque, num_saque_inicial
    if valor <= 0:
        print("O valor do saque deve ser positivo.")
        return
    elif num_saque_inicial == num_saque_final:
        print("Limite diário de saques atingido.")
        return
    elif valor > 500:
        print("O valor máximo para saque é de R$500.00.")
        return
    elif saldo < valor: 
        print("Saldo insuficiente para realizar o saque.")
        return
    
    saldo -= valor
    saque.append(valor)
    extrato.append(valor)
    print(f"Saque de R${valor:.2f} realizado com sucesso.")

def exibir_extrato():
    print("\nExtrato:")
    if not extrato:
        print("Não foram realizadas movimentações.")
        return
    else:
        for movimentacao in extrato:
            print(movimentacao)
    print(f"Saldo atual: R${saldo:.2f}\n")

# Exemplo de uso do menu
while True:
    print(menu)
    opcao = input("Escolha uma opção: ").strip().upper()

    if opcao == 'D':
        valor_deposito = float(input("Digite o valor do depósito: "))
        realizar_deposito(valor_deposito)
    elif opcao == 'S':
        valor_saque = float(input("Digite o valor do saque: "))
        realizar_saque(valor_saque)
    elif opcao == 'E':
        exibir_extrato()
    elif opcao == 'F':
        print("Finalizando o programa.")
        break
    else:
        print("Opção inválida. Tente novamente.")

