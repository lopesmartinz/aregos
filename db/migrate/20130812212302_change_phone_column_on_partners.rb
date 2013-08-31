class ChangePhoneColumnOnPartners < ActiveRecord::Migration
  def up
  	rename_column :partners, :phone, :phone_number
  end

  def down
  end
end
