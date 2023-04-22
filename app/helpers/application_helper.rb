# frozen_string_literal: true

module ApplicationHelper
  def extract_csv(file)
    csv = check_csv_validity(file)
    return csv unless csv[:valid]

    csv_obj = []
    csv[:csv_data].each do |row|
      csv_obj << row
    end
    csv_data = csv_obj.map(&:to_hash)

    { valid: true, csv_data: csv_data }
  end

  def check_csv_validity(file)
    return { valid: false, message: 'File Empty' } if file.blank?

    new_file = File.new(file.path)
    begin
      csv = CSV.parse(file.read, headers: true)
    rescue CSV::MalformedCSVError
      return { valid: false, message: 'Invalid CSV file format.' }
    end
    expected_headers = %w[name code image]
    if (expected_headers - csv.headers).present?
      return { valid: false, message: "Invalid CSV file format. Expected headers: #{expected_headers.join(', ')}" }
    end

    { valid: true, csv_data: csv }
  end

  def default_page_size
    Kaminari.config.default_per_page
  end

  def pagination_params(obj)
    {
      current_page: obj.current_page,
      next_page: obj.next_page,
      prev_page: obj.prev_page,
      total_pages: obj.total_pages,
      total_count: obj.total_count
    }
  end
end
