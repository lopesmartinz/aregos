class CreateCartStatuses < ActiveRecord::Migration
  def change
    create_table :cart_statuses do |t|

      t.timestamps
    end
  end
end
