class HttpUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return true if value.blank?

    url = Addressable::URI.parse value
    scheme = url.scheme rescue nil
    probable_mistake = url.host.exclude?('.') rescue true
    if %w[http https].exclude?(scheme) || probable_mistake
      record.errors.add(attribute, 'is not a valid http(s) url')
    end
  end
end

