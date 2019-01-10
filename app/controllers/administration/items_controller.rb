# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @items = Item.all.alphabetical_order
    end

    def update
      item = Item.find(params[:id])
      if item.update(item_params)
        redirect_to administration_items_path, notice: 'Le prix a bien été modifié'
      else
        redirect_to administration_items_path, alert: "Le prix n'a pas été modifié"
      end
    end

    private

    def item_params
      params.require(:item).permit(:discount_percentage)
    end
  end
end
