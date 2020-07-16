desc 'Clear Development database and seed with CSV data.'
task import: :environment do
  require 'csv'

  models = [Transaction, InvoiceItem, Item, Invoice, Merchant, Customer]

  puts 'Resetting database...'

  models.each do |model|
    model.destroy_all
  end

  puts 'Database successfully reset!'

  models.reverse.each do |model|
    puts "Importing #{model} data..."
    CSV.foreach("./data/#{model}s.csv",
                headers: true, header_converters: :symbol) do |row|
      model.create!(row.to_h)
    end
    puts "#{model} data successfully imported!"
  end

  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end

  puts 'Nailed it!'
end
