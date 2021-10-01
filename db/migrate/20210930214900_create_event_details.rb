class CreateEventDetails < ActiveRecord::Migration[6.1]

	def change
		create_table :event_details do |t|
			t.integer :event_id
			t.integer :event_type_id
			t.decimal :lap_distance
			t.decimal :lap_elevation
			t.string :badge_id

			t.integer :created_by
			t.integer :updated_by
			t.timestamps
		end

		add_foreign_key :event_details, :events
		add_foreign_key :event_details, :event_types
		add_foreign_key :event_details, :users, column: :created_by
		add_foreign_key :event_details, :users, column: :updated_by
	end

end
