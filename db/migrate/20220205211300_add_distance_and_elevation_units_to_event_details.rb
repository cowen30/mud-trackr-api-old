class AddDistanceAndElevationUnitsToEventDetails < ActiveRecord::Migration[6.1]

	def change
		add_column :event_details, :distance_units, :string
		add_column :event_details, :elevation_units, :string
	end

end
