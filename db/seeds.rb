# pegar todos os suplementos
# salvar o preco de cada um criando uma nova instancia com o id do suplemento
require 'pry'

suplementos = Suplemento.all
suplementos.each do |suplemento|
    p = Price.new(
        price_cents: suplemento.price_cents,
        suplemento_id: suplemento.id
    )
    unless suplemento.prices.empty?
        binding.pry
        p.price_changed = (suplemento.price_cents - suplemento.prices.last.price_cents)/1000
    end
    p.save!
end
