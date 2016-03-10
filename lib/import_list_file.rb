require 'csv'

class ImportListFile

  attr_reader :model

  def initialize(args)
    @logger = args.fetch(:logger)
    @model  = args.fetch(:model)
    @csv_options = args.fetch(:csv_options, {})
    @number_imported = 0
  end

  def perform
    puts '', "starting import..."
    local_file = model.local_file  #this is a slow method
    @number_imported = 0

    CSV.foreach(local_file, @csv_options) do |row|
      member = model.list_members.create(number: compose_phone_number(row))
      log_result(member)
    end

    puts "finished importing #{@number_imported} rows."
    @number_imported
  end

  private

  def compose_phone_number(row)
    "#{row[0]}#{row[1]}"
  end

  def log_result(member)
    member.persisted? ? log_success(member) : log_error(member)
  end

  def log_success(member)
    @number_imported+= 1 
  end

  def log_error(member)
    @loger.error "FAILED: #{member.inspect}"
  end
end
