class AddFieldsToPressReleases < ActiveRecord::Migration
  def change
  	add_column :press_releases, :entity, :string
  	add_column :press_releases, :date, :string
  	add_column :press_releases, :description, :string
  end
end
