require 'download_list_file'

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
    @local_file ||= DownloadListFile.new(self).perform
  end
end
