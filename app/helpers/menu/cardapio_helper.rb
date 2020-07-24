module Menu::CardapioHelper
    def image_category(categoria)
        if categoria.avatar_category.attached?
            img_ctg = categoria.avatar_category
        else
            img_ctg ="/templateMob/img/food1.jpg"
        end
    end

    def image_product(produto)
        if produto.avatar_product.attached?
            img_ctg = produto.avatar_product
        else
            img_ctg ="/templateMob/img/food1.jpg"
        end
    end
end
