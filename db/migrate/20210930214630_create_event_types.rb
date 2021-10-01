class CreateEventTypes < ActiveRecord::Migration[6.1]

	def change
		create_table :event_types do |t|
			t.string :name
			t.string :short_name
			t.integer :brand_id
			t.integer :display_order

			t.integer :created_by
			t.integer :updated_by
			t.timestamps
		end

		add_foreign_key :event_types, :brands
		add_foreign_key :event_types, :users, column: :created_by
		add_foreign_key :event_types, :users, column: :updated_by
	end

end
