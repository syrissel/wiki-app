begin
  page = Page.last
  page.destroy!
rescue ActiveRecord::RecordNotDestroyed => error
  puts "errors that prevented destruction: #{error.record.errors}"
end
