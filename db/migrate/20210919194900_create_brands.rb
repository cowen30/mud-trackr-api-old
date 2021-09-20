class CreateBrands < ActiveRecord::Migration[6.1]

	def change
		create_table :brands do |t|
			t.string :name
			t.string :logo_path

			t.integer :created_by
			t.integer :updated_by
			t.timestamps
		end

		add_foreign_key :brands, :users, column: :created_by
		add_foreign_key :brands, :users, column: :updated_by
	end

end
