class CreateCartStatuses < ActiveRecord::Migration
  def change
    create_table :cart_statuses do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
