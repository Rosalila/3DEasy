class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def checkout
    if !current_user
      return
    end

    @shipping_type = ShippingType.find_by_id(params[:shipping_type_id])
    @printing_hub = PrintingHub.find_by_id(params[:printing_hub_id])

    if !@printing_hub.shipping_types.exists?(id: @shipping_type.id)
      return
    end

    @order = Order.new
    @order.user_id = current_user.id
    @order.order_state_id = OrderState.find_by_name("pending").id
    @order.shipping_address = params[:order][:shipping_address]
    @order.shipping_type_id = @shipping_type.id
    @order.printing_hub_id = @printing_hub.id
    @order.doges = 0
    client = DogecoinClient.new
    if client.valid?
      @order.doge_address = client.get_new_address
    end

    @order.save

    current_user.cart_items.each do |cart_item|
      if cart_item.printing_set.printing_hub == @printing_hub
		    order_item = OrderItem.new
		    order_item.order_id = @order.id
		    order_item.printing_set_id = cart_item.printing_set_id
		    order_item.amount = cart_item.amount

        if !@printing_hub.has_printing_set order_item.printing_set
          @order.destroy
          return
        end

		    order_item.save
        cart_item.destroy
        @order.doges += order_item.amount * order_item.printing_set.doges + @shipping_type.doges
      end
    end

    @order.save

    redirect_to @order
  end

  def cart
    if !current_user
      return
    end

    @printing_hubs_cart_items = {}
    current_user.cart_items.each do |cart_item|
      if @printing_hubs_cart_items[cart_item.printing_set.printing_hub.id] == nil
        @printing_hubs_cart_items[cart_item.printing_set.printing_hub.id] = 1
      else
        @printing_hubs_cart_items[cart_item.printing_set.printing_hub.id]+=1
      end
    end
    if @printing_hubs_cart_items.size == 1
      redirect_to printing_hub_cart_path(current_user.cart_items.first.printing_set.printing_hub)
    end
  end

  def printing_hub_cart
    if !current_user
      return
    end

    @printing_hub = PrintingHub.find_by_id(params[:id])
    @shipping_type = @printing_hub.shipping_types.first
    if params[:shipping_type] != nil
      @shipping_type = ShippingType.find_by_id(params[:shipping_type][:id])
    end
    if params[:shipping_type_id] != nil
      @shipping_type = ShippingType.find_by_id(params[:shipping_type_id])
    end
    @items = []
    current_user.cart_items.each do |cart_item|
      if cart_item.printing_set.printing_hub.id == @printing_hub.id
        @items.push(cart_item)
      end
    end
  end

  def delete_from_cart
    if !current_user
      return
    end

    @cart_item = CartItem.find_by_id(params[:id])

		if !current_user.has_cart_item @cart_item
      return
    end

    @cart_item.destroy
    shipping_type_id = nil
    if params[:shipping_type]
      shipping_type_id = params[:shipping_type][:id]
    end
    if params[:shipping_type_id]
      shipping_type_id = params[:shipping_type_id]
    end
    redirect_to printing_hub_cart_path(@cart_item.printing_set.printing_hub, shipping_type_id: shipping_type_id), notice: 'The item was removed from the cart.'
  end

  def update_item_amount
    if !current_user
      return
    end

    @cart_item = CartItem.find_by_id(params[:item_id])

		if !current_user.has_cart_item @cart_item
      return
    end

    @cart_item.amount = params[:item][:amount]
    @cart_item.save
    shipping_type_id = nil
    if params[:shipping_type]
      shipping_type_id = params[:shipping_type][:id]
    end
    if params[:shipping_type_id]
      shipping_type_id = params[:shipping_type_id]
    end

    redirect_to printing_hub_cart_path(@cart_item.printing_set.printing_hub, shipping_type_id: shipping_type_id), notice: 'The item was updated.'
  end

  def add_to_cart
    if !current_user
      return
    end

    @printing_set = PrintingSet.find_by_id(params[:printing_set_id])

    if CartItem.exists?({ user_id: current_user.id, printing_set_id: @printing_set.id })
      redirect_to PrintingHub.first, notice: 'You already have that item on your cart.'
      return
    end

    CartItem.create({ user_id: current_user.id, printing_set_id: @printing_set.id, amount: 1 })
    redirect_to @printing_set.printing_hub, notice: 'The item was added to your cart.'
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    return
    @order = Order.new(order_params)

    @order.user_id = current_user.id
    @order.order_state_id = OrderState.find_by_name("pending").id
    #TODO Dogecoin @order.doge_address = ...

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    return
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    return
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :order_state_id, :doge_address, :shipping_address, :shipping_type_id)
    end
end
