class AddColumnsToGeneralInteractions < ActiveRecord::Migration
  def change
  	add_column :general_interactions, :sender_name, :string
  	add_column :general_interactions, :sender_email, :string
  	add_column :general_interactions, :subject, :string
  	add_column :general_interactions, :description, :string
  end
end
