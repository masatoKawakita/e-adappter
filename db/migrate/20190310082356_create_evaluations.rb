class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.integer :evaluator_id,  default: 0, null: false
      t.integer :evaluated_id,  default: 0, null: false
      t.integer :conversion_id, default: 0, null: false
      t.integer :value,         default: 0, null: false
      t.timestamps
    end

    add_index :evaluations, [:evaluator_id, :evaluated_id, :conversion_id],
                            unique: true,
                            :name => :index_conversions_on_evaluator_evaluated_and_conversion_id
  end
end
