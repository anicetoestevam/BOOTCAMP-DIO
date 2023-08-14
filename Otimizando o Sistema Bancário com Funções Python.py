https://github.com/anicetoestevam/BOOTCAMP-DIO/pulls

############### DEMONSTRAREI O PASSO A PASSO DE COMO RESOLVI O DESAFIO 

            print("Otimizando o Sistema Bancário com Funções Python")


# Variáveis globais

numero_conta = 0
saldo_inicial = 0
limite_saques_diarios = 3

# Dicionários para armazenar os dados

usuarios = {}
contas = {}

# Função para criar um novo usuário

def criar_usuario():
    global usuarios
    cpf = input("CPF: ")
    if cpf in usuarios:
        print("CPF já cadastrado.")
        return None

    nome = input("Nome: ")
    data_nascimento = input("Data de Nascimento: ")
    endereco = input("Endereço (logradouro, número, bairro, cidade, estado): ")

    usuarios[cpf] = {'nome': nome, 'data_nascimento': data_nascimento, 'endereco': endereco}
    return cpf

# Função para criar uma nova conta

def criar_conta(cpf):
    global numero_conta, contas, saldo_inicial
    numero_conta += 1
    contas[numero_conta] = {'agencia': '0001', 'numero_conta': numero_conta, 'cpf': cpf, 'saldo': saldo_inicial}


# Variável Menu a ser exibido

menu = """
[D] Depositar
[S] Sacar
[E] Extrato
[U] Usuário
[C] Criar Usuário ou Conta
[Q] Sair

=> """


while True:

    # Escolha o menu aqui

    print(menu)
    opcao = input("Escolha uma opção: ").strip().upper()

    # Busque realizar depósito aqui

    if opcao == 'D' or opcao == 'd':
        valor_deposito = float(input("Digite o valor do depósito: "))
        realizar_deposito(valor_deposito)

    # Busque realizar saque aqui

    elif opcao == 'S' or opcao == 's':
        valor_saque = float(input("Digite o valor do saque: "))
        realizar_saque(valor_saque)
    
    # Busque ver o extrato aqui

    elif opcao == 'E' or opcao == 'e':
        exibir_extrato()
   
    # Busque fazer o cadastro do usuário e da conta aqui

    elif opcao == 'C' or opcao == 'c':
        cpf_usuario = criar_usuario()  
        if cpf_usuario:
            nova_conta = input("Criar conta corrente? (S/N): ").strip().lower()
            if nova_conta == 's' or nova_conta == 'sim':
                criar_conta(cpf_usuario)
    
    # Busque o número do CPF ou a da conta aqui
    elif opcao == 'U' or opcao == 'u':
        cpf_usuario = input("Digite o CPF do usuário: ")  
        buscar_usuario(cpf_usuario)
        buscar_conta(cpf_usuario)

    # Busque sair do menu aqui

    elif opcao == 'Q' or opcao == 'q':
        print("Finalizando o programa.")
        break
    else:
        print("Opção inválida. Tente novamente.")
