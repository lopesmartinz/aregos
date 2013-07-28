class CreateGeneralInteractions < ActiveRecord::Migration
  def change
    create_table :general_interactions do |t|

      t.timestamps
    end
  end
end
