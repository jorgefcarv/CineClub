json.extract! filme, :id, :imagem_nome, :imagem_caminho, :titulo, :diretores, :ano_lancamento, :nota, :produtora, :opiniao, :created_at, :updated_at
json.url filme_url(filme, format: :json)
