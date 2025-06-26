import json
import requests
import time
import os 

API_URL = os.getenv("API_URL", "http://127.0.0.1:8000/api/parceiro/criar")

JSON_FILE_PATH = os.getenv("JSON_FILE_PATH", "pdvs.json")

REQUEST_TIMEOUT = 15

def load_partners_from_json(file_path):
    """
    Carrega dados de parceiros de um arquivo JSON e os envia
    para a API de criação de parceiros.
    """
    print(f"Tentando carregar parceiros via API_URL: {API_URL}")

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            raw_data = json.load(f) 
    except FileNotFoundError:
        print(f"Erro: O arquivo '{file_path}' não foi encontrado.")
        return
    except json.JSONDecodeError as e:
        print(f"Erro: O arquivo '{file_path}' não é um JSON válido. Detalhes: {e}")
        return
    except Exception as e: 
        print(f"Erro inesperado ao ler o arquivo '{file_path}': {e}")
        return

    data = []
    if isinstance(raw_data, dict) and "pdvs" in raw_data:
        data = raw_data["pdvs"]
        print("Aviso: Dados de parceiros encontrados sob a chave 'pdvs' no JSON.")
    elif isinstance(raw_data, list):
        data = raw_data
        print("Aviso: O arquivo JSON contém uma lista direta de parceiros.")
    else:
        print(f"Erro: O conteúdo do arquivo JSON não é uma lista de parceiros ou um dicionário com a chave 'pdvs'. Tipo encontrado: {type(raw_data)}")
        return

    if not isinstance(data, list):
        print(f"Erro: A chave 'pdvs' não contém uma lista. Tipo encontrado: {type(data)}")
        return

    if not data:
        print("Nenhum dado de parceiro válido encontrado no arquivo JSON. Verifique o conteúdo do arquivo.")
        return

    print(f"Iniciando o carregamento de {len(data)} parceiros para a API...")

    cadastros_cont = 0
    falhas_cont = 0

    for i, partner_data in enumerate(data):
        response = None
        partner_name = partner_data.get('tradingName', 'Nome Desconhecido')
        partner_id = partner_data.get('id', 'ID Desconhecido')
        print(f"[{i+1}/{len(data)}] Tentando carregar parceiro: {partner_name} (ID: {partner_id})")

        try:
            response = requests.post(API_URL, json=partner_data, timeout=REQUEST_TIMEOUT)

            if response.status_code >= 200 and response.status_code < 300:
                print(f"  Resposta HTTP: {response.status_code} OK/Criado.")
            else:
                print(f"  Resposta HTTP: {response.status_code} (Possível Erro).")

            response.raise_for_status()  #

            print(f"  Sucesso: Parceiro '{partner_name}' (ID: {partner_id}) criado.")
            cadastros_cont += 1
        except requests.exceptions.Timeout:
            print(f"  Erro de Timeout: A requisição para o parceiro '{partner_name}' (ID: {partner_id}) excedeu o tempo limite de {REQUEST_TIMEOUT} segundos.")
            print(f"  Verifique a conexão com a internet e se o servidor Django está ativo e respondendo rapidamente em '{API_URL}'.")
            falhas_cont += 1
        except requests.exceptions.ConnectionError as e:
            print(f"  Erro de Conexão: Não foi possível conectar ao servidor para o parceiro '{partner_name}' (ID: {partner_id}). Detalhes: {e}")
            print(f"  Verifique se o servidor Django está rodando em '{API_URL}' e se há problemas de rede.")
            falhas_cont += 1
        except requests.exceptions.RequestException as e:
            print(f"  Erro ao carregar parceiro '{partner_name}' (ID: {partner_id}): {e}")
            if response is not None:
                print(f"  Status: {response.status_code}")
                try:
                    api_response_json = response.json()
                    print(f"  Resposta da API (JSON): {json.dumps(api_response_json, indent=2, ensure_ascii=False)}")
                except json.JSONDecodeError:
                    print(f"  Resposta da API (texto bruto): {response.text}")
            else:
                print("  Nenhuma resposta HTTP foi recebida (provável problema de conexão ou URL incorreta).")
                print(f"  Verifique se o servidor Django está rodando em '{API_URL}'")
            falhas_cont += 1
        time.sleep(0.05) 

    print("\n--- Relatório Final ---")
    print(f"Total de parceiros tentados: {len(data)}")
    print(f"Parceiros criados com sucesso: {cadastros_cont}")
    print(f"Parceiros que falharam: {falhas_cont}")

if __name__ == "__main__":
    load_partners_from_json(JSON_FILE_PATH)