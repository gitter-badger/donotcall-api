require 'file_helper'

class DownloadListFile

  attr_reader :list_file

  def initialize(list_file)
    @list_file = list_file
    raise ArgumentError.new "File missing fingerprint, cannot continue" unless @list_file.upload_fingerprint.present? 
  end

  def perform
    tempfile = Tempfile.new("#{Time.now.utc.to_i}")
    upload = list_file.upload

    if upload.respond_to?(:s3_object)
      ok = upload.copy_to_local_file(upload.default_style, tempfile.path)
      return false if !ok
    else
      FileUtils.copy(upload.path, tempfile.path)
    end
    raise "Fingerprint does not match #{list_file.upload_fingerprint}" unless fingerprint(tempfile) == list_file.upload_fingerprint 
    tempfile
  end

  private

  def fingerprint(file)
    FileHelper.fingerprint(file)
  end
end
