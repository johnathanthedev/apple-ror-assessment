class CreateForecastsTable < ActiveRecord::Migration[7.2]
  def change
    create_table :forecasts, id: :uuid do |t|
      t.jsonb :current, default: {}, null: false
      t.jsonb :daily, default: {}, null: false

      t.timestamps
    end
  end
end
