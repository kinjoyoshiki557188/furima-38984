class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

   def edit
      if @item.user_id == current_user.id && @item.order.nil?
     else
        redirect_to "/items/#{comment.item.id}" 
     end
   end

   def update
    @item.update(item_params)
    if @item.user_id == current_user.id
       @item.valid?
       redirect_to item_path(item_params)

     else
      render 'edit'
     end
   end

  def destroy
     if @item.user_id == current_user.id
        @item.destroy
        redirect_to root_path
     else
        redirect_to root_path
   end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :sipping_cost_id, :prefecture_id, :sipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end