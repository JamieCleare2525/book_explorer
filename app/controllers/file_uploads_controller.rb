class FileUploadsController < ApplicationController
  require 'csv'

  def show
    @file_upload = FileUpload.find(params[:id])
    @books = []
    CSV.parse(@file_upload.file.read, headers: true) do |row|
      @books << row
    end
  end

  def create
    raise FileError, 'No file selected.' unless params[:file].present?
    @csv_file = params[:file]
    raise FileError, 'Incorrect file type. Please upload a CSV file.' unless @csv_file.content_type == "text/csv"
    file_name = @csv_file.original_filename
    file_uid = Time.zone.now.to_i
    unique_file_name = "#{file_uid}_#{file_name}"
    ActiveRecord::Base.transaction do
      @file_upload = FileUpload.create!(user: current_user)
      CSV.foreach(@csv_file.path, headers: true) do |row|
        Book.find_or_create_by!(title: row[0], author: row[1], date_published: row[2],
                                uid: row[3], publisher: row[4])
      end
      @file_upload.file = @csv_file
      @file_upload.save!
      if @file_upload.file.present?
        file = @file_upload.file
        @file_upload.update!(name: file.filename, s3_url: file.url)
      end
    end
    flash[:success] = "File '#{file_name}' uploaded successfully."
    redirect_to file_upload_path(@file_upload)
  rescue FileError => e
    flash[:danger] = e.message
    redirect_to root_path
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to root_path
  end
end

class FileError < StandardError
end
