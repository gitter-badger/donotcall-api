if Rails.env.test?
  Paperclip::Attachment.default_options.merge!(
    path: ":rails_root/public/paperclip/:rails_env/:class/:attachment/:id_partition/:filename",
    storage: :filesystem
  )
else
  Paperclip::Attachment.default_options.merge!(
    storage: :s3,
    path: "paperclip/:rails_env/:class/:attachment/:id_partition/:filename",
    s3_permissions: :private,
    s3_credentials: {
      bucket: 'donotcall-api',
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_KEY_ID']
    }
  )
end
