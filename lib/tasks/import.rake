desc "Clear Development database and seed with CSV data."
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
    CSV.foreach("./data/#{model.to_s}s.csv",
                headers: true, header_converters: :symbol) do |row|
      model.create!(row.to_h)
    end
    puts "#{model.to_s} data successfully imported!"
  end

  puts 'Nailed it!'
end
