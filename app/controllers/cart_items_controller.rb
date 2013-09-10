# encoding: utf-8

class CartItemsController < ApplicationController

	##################################
	#### ACCÕES DEFAULT
	##################################

	# DELETE
	# apaga o item do carrinho
	def destroy
		@cart_item = CartItem.find(params[:id])

		if @cart_item.delete
			flash[:notice] = "O produto foi removido do carrinho de compras."

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

			if current_cart.cart_items.count == 0
				current_cart.delete
				session.delete(:aregos_cart_id)
				redirect_to root_path
			else
				redirect_to :back
			end
		end
	end

end
