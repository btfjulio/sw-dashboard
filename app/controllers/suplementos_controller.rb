
class SuplementosController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index]
  

    def index
        if params[:query].present?
            @suplementos = Suplemento.order(:price_cents).sup_search(params[:query]).page(params[:page]).per(50)
        else
            @suplementos = Suplemento.all.page(params[:page]).per(50)
        end
    end
end