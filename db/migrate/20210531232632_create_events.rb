class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.datetime :time
      t.string :location
      t.string :picture
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
