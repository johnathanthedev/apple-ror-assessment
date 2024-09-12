class CreateLocationsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :locations, id: :uuid do |t|
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lon, precision: 10, scale: 6

      t.timestamps
    end
  end
end
