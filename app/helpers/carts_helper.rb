module CartsHelper

	# "GET" do carrinho actual
	def current_cart
		if !session[:aregos_cart_id].nil?
			current_cart = Cart.find(session[:aregos_cart_id])
		end
	end

end
