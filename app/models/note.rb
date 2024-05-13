class Note < ApplicationRecord
  belongs_to :user
  self.table_name = 'na_notes'

  # broadcasts_to ->(notes) { "notes" }, inserts_by: :prepend
  broadcasts_refreshes

  #  after_update_commit :broadcast_update_later

  # private
  #   def broadcast_update_later
  #     broadcast_render_later_to 'notes', partial: 'notes', locals: { note: self }
  #   end
end
