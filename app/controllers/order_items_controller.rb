# frozen_string_literal: true

# Controller for OrderItems
class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[show update destroy]

  # GET /order_items
  def index
    puts "GETTING ORDER ITEMS"
    @order = Order.find(params[:order_id])
    puts @order.inspect
    @order_items = @order.order_items
    puts @order_items.inspect

    render json: @order_items
  end

  def get_order_item_objects
    puts "GETTING ORDER ITEM OBJECTS"
    @order = Order.find(params[:order_id])
    @items = Array.new()
    @order_items = @order.order_items
    @order_items.each do |order_item|
      @items.push(Item.find(order_item.item_id))
    end
    puts "INSPECTING ITEMS"
    puts @items.inspect

    render json: @items
  end

  # GET /order_items/1
  def show
    render json: @order_item
  end

  # POST /order_items
  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      render json: @order_item, status: :created, location: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_items/1
  def update
    if @order_item.update(order_item_params)
      render json: @order_item
    else
      render json: @order_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/1
  def destroy
    @order_item.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity)
  end
end
