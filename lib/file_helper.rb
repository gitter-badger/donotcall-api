class FileHelper

  def self.fingerprint(file)
    Digest::MD5.file(file.path).to_s
  end
end
