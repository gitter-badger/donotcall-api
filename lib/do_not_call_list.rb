class DoNotCallList

  def search(text)
    # This currently is tested only to return boolean value
    # But if number is on DNC list, it should return the ListFile object where number was found 
    # so that list_query can store it for future audit purposes
    member = ListMember.includes(:list_file).where(number: text).first
    return member.nil? ? member : member.list_file
  end
end
