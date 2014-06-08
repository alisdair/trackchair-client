require 'date'

class Paper < Model
  attr_accessor :number, :track_id, :account_ids, :title, :abstract, :category, :status, :created_at, :updated_at

  def initialize(attributes={})
    super(attributes)
    self.created_at = DateTime.parse(created_at) unless created_at.nil?
    self.updated_at = DateTime.parse(updated_at) unless updated_at.nil?
  end

  def id
    number
  end

  def author_list
    grouped = []

    accounts.each do |a|
      ta = a.affiliation
      la = grouped.last ? grouped.last[:affiliation] : nil

      # If last == this, or one is a substring of the other...
      if la and (la == ta or la.include? ta or ta.include? la)
        # Add the author name
        grouped.last[:authors] << a.name

        # Choose the longest affiliation
        grouped.last[:affiliation] = [la, ta].max_by &:length

      # Otherwise...
      else
        # Add a new authors/affiliation record
        grouped << { authors: [a.name], affiliation: ta }
      end
    end

    # Join the grouped authors in the form "author(, author)*, affiliation;"
    grouped.map {|g| (g[:authors] + [g[:affiliation]]).join(', ') }.join('; ')
  end

  def accounts
    account_ids.map {|id| store.find(Account, id) }
  end

  def track
    store.find(Track, track_id)
  end
end
