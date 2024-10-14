class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :my_items, :reserve, :unreserve, :show ] # Added :show here
  before_action :find_item, only: [ :show, :edit, :update, :destroy, :reserve, :unreserve ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @items = if params[:search].present?
                Item.where("title LIKE ?", "%#{params[:search]}%")
    else
                Item.all
    end

    # Sort items alphabetically if the sort parameter is present
    if params[:sort] == "newest"
      @items = @items.order(created_at: :desc)
    elsif params[:sort] == "alphabetical"
      @items = @items.order(:title)
    end

    # Paginate the items
    @items = @items.page(params[:page]).per(6)
  end

  def my_items
    @items = current_user.items
  end

  def reserved_items
    @reserved_items = Item.where(reserved_by: current_user.id)
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

  def reserve
    if @item.user_id != current_user.id
      if @item.reserved_by.nil?
        @item.update(reserved_by: current_user.id)
        redirect_to reserved_items_items_path, notice: "Item successfully reserved."
      else
        redirect_to item_path(@item), alert: "Item is already reserved by another user."
      end
    else
      redirect_to item_path(@item), alert: "You cannot reserve your own item."
    end
  end

  def unreserve
    if @item.reserved_by == current_user.id
      @item.update(reserved_by: nil)
      redirect_to reserved_items_items_path, notice: "Reservation canceled successfully."
    else
      redirect_to reserved_items_items_path, alert: "You cannot cancel a reservation that is not yours."
    end
  end

  private

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to items_path, alert: "Item not found."
  end

  def item_params
    params.require(:item).permit(:title, :body, :condition, :location, :image, :reference_number, :category, :custom_category, :city, :state, :zipcode)
  end

  def authorize_user!
    unless @item.user_id == current_user&.id
      redirect_to items_path, alert: "You are not authorized to perform this action."
    end
  end
end
