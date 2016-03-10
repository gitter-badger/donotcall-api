class ListFile < ActiveRecord::Base

  STATES = [
    MD = { md: 'Maryland' },
    PA = { pa: 'Pennsylvania' },
    WV = { wv: 'West Virginia' }
  ].reduce({}, :merge)

  has_many :list_members, inverse_of: :list_file, dependent: :restrict_with_exception

  scope :active, -> { where(active: true) }

  # Paperclip gem
  has_attached_file :upload, {preserve_files: "true"}

  validates :state, inclusion: STATES.keys.map(&:to_s)
  validates_attachment_content_type :upload, content_type: /\Atext/
  validates_attachment_file_name    :upload, matches: [/txt\Z/]
  validates :upload_fingerprint, presence: true

  def local_file
    return @local_file if @local_file
    return false unless upload.present?

    tempfile = Tempfile.new("#{Time.now.utc.to_i}")

    if upload.respond_to?(:s3_object)
      ok = upload.copy_to_local_file(upload.default_style, tempfile.path)
      return false if !ok 
    else
      FileUtils.copy(upload.path, tempfile.path)
    end
      
    @local_file = tempfile
  end
end
