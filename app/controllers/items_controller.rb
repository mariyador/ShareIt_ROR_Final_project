class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :my_items]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    def index
      if params[:search].present?
        @items = Item.where('title LIKE ?', "%#{params[:search]}%")
      else
        @items = Item.all
      end
    end
  end

  def my_items
    @items = current_user.items
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
    @item.user_id = current_user.id
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
    redirect_to items_path, notice: "Item was successfully deleted."
  end

  private

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to items_path, alert: "Item not found."
  end

  def item_params
    params.require(:item).permit(:title, :body, :condition, :location, :image, :user_id, :reserved, :reserved_by, :reference_number, :category, :custom_category)
  end

  def authorize_user!
    unless @item.user_id == current_user.id
      redirect_to items_path, alert: "You are not authorized to perform this action."
    end
  end
end
