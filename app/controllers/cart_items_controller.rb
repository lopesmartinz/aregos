class CartItemsController < ApplicationController

	##################################
	#### ACCÕES DEFAULT
	##################################

	# DELETE
	# apaga o item do carrinho
	def destroy
		@cart_item = CartItem.find(params[:id])

		if @cart_item.delete
			flash[:notice] = "O produto foi removido do carrinho"

			redirect_to :back
		end
	end




	##################################
	#### ACÇÕES EXTRA
	##################################
	
	# PUT
	# incrementa quantidade do item no carrinho
	def increase_quantity
		@cart_item = CartItem.find(params[:id])

		@cart_item.quantity += 1

		if @cart_item.save			
			redirect_to :back
		end
	end


	# PUT
	# decrementa quantidade do item no carrinho
	def decrease_quantity
		@cart_item = CartItem.find(params[:id])

		@cart_item.quantity -= 1

		if @cart_item.save
			# apaga o item se a quantidade for zero
			@cart_item.delete unless @cart_item.quantity > 0

			redirect_to :back
		end
	end

end
