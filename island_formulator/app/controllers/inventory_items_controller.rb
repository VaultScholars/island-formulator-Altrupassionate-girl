class InventoryItemsController < ApplicationController
  before_action :require_authentication
  before_action :set_inventory_item, only: %i[ show edit update destroy ]

  # GET /inventory_items or /inventory_items.json
  def index
    # We use .includes(:ingredient) to avoid "N+1" queries.
    # This is a performance optimization that loads all ingredients in one go!
    @inventory_items = current_user.inventory_items.includes(:ingredient).order(purchase_date: :desc)
  end

  # GET /inventory_items/1 or /inventory_items/1.json
  def show
  end

  # GET /inventory_items/new
  def new
    @inventory_item = current_user.inventory_items.build
  end

  # GET /inventory_items/1/edit
  def edit
  end

  # POST /inventory_items or /inventory_items.json
  def create
    @inventory_item = current_user.inventory_items.build(inventory_item_params)

    if @inventory_item.save
      redirect_to inventory_items_path, notice: "Inventory item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @inventory_item.update(inventory_item_params)
      redirect_to inventory_items_path, notice: "Inventory item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory_item.destroy
    redirect_to inventory_items_path, notice: "Inventory item was successfully removed."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_inventory_item
      @inventory_item = current_user.inventory_items.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_item_params
    params.require(:inventory_item).permit(:ingredient_id, :brand, :size, :location, :purchase_date, :notes, :photo)
  end
end
