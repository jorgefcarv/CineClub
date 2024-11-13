class CreateMovieReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_reviews do |t|
      t.references :filme, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :opinion

      t.timestamps
    end
  end
end
