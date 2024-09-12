class AddLocationToForecasts < ActiveRecord::Migration[7.2]
  def change
    add_reference :forecasts, :location, null: false, foreign_key: true, type: :uuid
  end
end
