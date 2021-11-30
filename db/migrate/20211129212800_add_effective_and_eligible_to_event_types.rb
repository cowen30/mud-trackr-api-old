class AddEffectiveAndEligibleToEventTypes < ActiveRecord::Migration[6.1]

	def change
		add_column :event_types, :effective_start, :date
		add_column :event_types, :effective_end, :date
		add_column :event_types, :legionnaire_eligible, :boolean
	end

end
