module CartsHelper

	# "GET" do carrinho actual
	def current_cart
		if !session[:aregos_cart_id].nil?
			current_cart = Cart.find(session[:aregos_cart_id])
		end
	end


	# "GET" do estado do carrinho actual
	def exists_pending_cart?
		!current_cart.nil? && current_cart.cart_status == CartStatus.find(2)
	end

end
