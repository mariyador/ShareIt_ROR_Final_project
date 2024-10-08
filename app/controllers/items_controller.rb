class ItemsController < ApplicationController
    http_basic_authenticate_with name: "", password: "", except: [ :index ]
    before_action :find_item, only: [ :show, :edit, :update, :destroy ]

    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def edit
    end

    def show
    end

    def create
      @item = Item.new(item_params)
      if @item.save
        redirect_to @item, notice: "Item was successfully created."
      else
        render :new
      end
    end

    def update
      if @item.update(item_params)
        redirect_to @item, notice: "Item was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to items_path
    end

    private

    def find_item
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to items_path, alert: "Item not found."
    end

    def item_params
      params.require(:item).permit(:title, :body, :condition, :location, :image)
    end
end
