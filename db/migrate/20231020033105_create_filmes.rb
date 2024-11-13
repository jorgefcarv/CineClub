class CreateFilmes < ActiveRecord::Migration[7.0]
  def change
    create_table :filmes do |t|
      t.text :imagem_caminho
      t.string :titulo
      t.string :diretores
      t.date :ano_lancamento
      t.text :idiomas
      t.text :genero
      t.integer :nota
      t.string :produtora
      t.text :opiniao
      t.timestamps
    end
  end
end
